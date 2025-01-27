use postgres::types::{ToSql};
use serde_json::{Value, json, Map};
use base64::{engine::general_purpose, Engine as _};
use crate::component::AddIn;
use std::collections::HashMap;
use std::net::IpAddr;
use std::time::{SystemTime, UNIX_EPOCH};

pub fn execute_query(
    add_in: &mut AddIn,
    query: String,
    params_json: String,
    force_result: bool,
) -> String {

    let client = match add_in.get_connection() {
        Some(c) => c,
        None => return format_json_error("No connection initialized"),
    };

    // Парсинг JSON параметров
    let params: Vec<Value> = match serde_json::from_str(&params_json) {
        Ok(params) => params,
        Err(e) => return format_json_error(&e.to_string()),
    };

    let params_ref = match process_params(&params){
        Ok(params) => params,
        Err(e) => return format_json_error(&e.to_string()),
    };

    let params_unboxed = params_ref.as_slice().iter().map(|boxed| boxed.as_ref()).collect::<Vec<_>>();

    if query.trim_start().to_uppercase().starts_with("SELECT") || force_result {
        match client.query(&query, &params_unboxed) {
            Ok(rows) => {
                rows_to_json(rows)
            }
            Err(e) => format_json_error(&e.to_string()),
        }
    } else {
        match client.execute(&query, &params_unboxed) {
            Ok(_) => json!({"result": true}).to_string(),
            Err(e) => format_json_error(&e.to_string()),
        }
    }
}

fn process_object(object: &Map<String, Value>) -> Result<Box<dyn ToSql + Sync>, String> {
    if object.len() != 1 {
        return Err("Object must have exactly one key-value pair specifying the type and value".to_string());
    }

    let (key, value) = object.iter().next().unwrap();
    match key.as_str() {
        "BOOL" => value
            .as_bool()
            .map(|v| Box::new(v) as Box<dyn ToSql + Sync>)
            .ok_or_else(|| "Invalid value for BOOL".to_string()),
        "\"char\"" => value
            .as_i64()
            .and_then(|v| i8::try_from(v).ok())
            .map(|v| Box::new(v) as Box<dyn ToSql + Sync>)
            .ok_or_else(|| "Invalid value for \"char\"".to_string()),
        "SMALLINT" | "SMALLSERIAL" => value
            .as_i64()
            .and_then(|v| i16::try_from(v).ok())
            .map(|v| Box::new(v) as Box<dyn ToSql + Sync>)
            .ok_or_else(|| format!("Invalid value for {}", key)),
        "INT" | "SERIAL" => value
            .as_i64()
            .and_then(|v| i32::try_from(v).ok())
            .map(|v| Box::new(v) as Box<dyn ToSql + Sync>)
            .ok_or_else(|| format!("Invalid value for {}", key)),
        "OID" => value
            .as_u64()
            .and_then(|v| u32::try_from(v).ok())
            .map(|v| Box::new(v) as Box<dyn ToSql + Sync>)
            .ok_or_else(|| "Invalid value for OID".to_string()),
        "BIGINT" | "BIGSERIAL" => value
            .as_i64()
            .map(|v| Box::new(v) as Box<dyn ToSql + Sync>)
            .ok_or_else(|| format!("Invalid value for {}", key)),
        "REAL" => value
            .as_f64()
            .map(|v| v as f32) // Преобразование f64 в f32
            .map(|v| Box::new(v) as Box<dyn ToSql + Sync>)
            .ok_or_else(|| "Invalid value for REAL".to_string()),
        "DOUBLE PRECISION" => value
            .as_f64()
            .map(|v| Box::new(v) as Box<dyn ToSql + Sync>)
            .ok_or_else(|| "Invalid value for DOUBLE PRECISION".to_string()),
        "VARCHAR" | "TEXT" | "CHAR" | "CITEXT" | "NAME" | "LTREE" | "LQUERY" | "LTXTQUERY" => value
            .as_str()
            .map(|v| Box::new(v.to_string()) as Box<dyn ToSql + Sync>)
            .ok_or_else(|| format!("Invalid value for {}", key)),
        "BYTEA" => value
            .as_str()
            .map(|blob_str| {
                // Очистка строки base64 от лишних символов
                let cleaned_base64 = blob_str.replace(&['\n', '\r', ' '][..], "");
                general_purpose::STANDARD.decode(&cleaned_base64)
            })
            .and_then(|res| res.ok())
            .map(|v| Box::new(v) as Box<dyn ToSql + Sync>)
            .ok_or_else(|| "Invalid base64 value for BYTEA".to_string()),
        "HSTORE" => value
            .as_object()
            .map(|obj| {
                let mut map = HashMap::new();
                for (k, v) in obj.iter() {
                    map.insert(
                        k.clone(),
                        v.as_str().map(String::from), // Значение может быть None
                    );
                }
                Box::new(map) as Box<dyn ToSql + Sync>
            })
            .ok_or_else(|| "Invalid object for HSTORE".to_string()),
        "TIMESTAMP" | "TIMESTAMP WITH TIME ZONE" => value
            .as_i64()
            .map(|v| {
                let duration = UNIX_EPOCH + std::time::Duration::from_secs(v as u64);
                let system_time = SystemTime::from(duration);
                Box::new(system_time) as Box<dyn ToSql + Sync>
            })
            .ok_or_else(|| "Invalid value for TIMESTAMP".to_string()),
        "INET" => value
            .as_str()
            .and_then(|s| s.parse::<IpAddr>().ok())
            .map(|ip| Box::new(ip) as Box<dyn ToSql + Sync>)
            .ok_or_else(|| "Invalid value for INET".to_string()),
        _ => Err(format!("Unsupported type: {}", key)),
    }
}

/// Конвертирует JSON-параметры в Postgres-совместимые типы
fn process_params(params: &Vec<Value>) -> Result<Vec<Box<dyn ToSql + Sync>>, String> {
    let mut result = Vec::new();
    for param in params {
        let processed: Box<dyn ToSql + Sync> = match param {
            Value::Null => Box::new(Option::<i32>::None),
            Value::Bool(b) => Box::new(*b),
            Value::Number(n) => {
                if let Some(i) = n.as_i64() {
                    Box::new(i)
                } else if let Some(f) = n.as_f64() {
                    Box::new(f)
                } else {
                    return Err("Invalid number".to_string());
                }
            }
            Value::String(s) => Box::new(s.clone()),
            Value::Object(obj) => process_object(obj)?,
            _ => return Err("Unsupported parameter type".to_string()),
        };
        result.push(processed);
    }
    Ok(result)
}

fn rows_to_json(rows: Vec<postgres::Row>) -> String{

    for row in rows {
        for coloumn in row.columns() {

            let ctype = coloumn.type_().name().to_string();
            let cname = coloumn.name();

            let val = match ctype.as_str() {
                _ => Value::String("".to_string())
            };

        }
    }

    "".to_string()
}

fn format_json_error(error: &str) -> String {
    json!({
        "result": false,
        "error": error
    })
        .to_string()
}
