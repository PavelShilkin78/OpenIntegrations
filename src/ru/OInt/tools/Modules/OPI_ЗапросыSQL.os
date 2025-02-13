﻿// OneScript: ./OInt/tools/Modules/OPI_ЗапросыSQL.os

// MIT License

// Copyright (c) 2023 Anton Tsitavets

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// https://github.com/Bayselonarrend/OpenIntegrations

// BSLLS:Typo-off
// BSLLS:LatinAndCyrillicSymbolInWord-off
// BSLLS:IncorrectLineBreak-off
// BSLLS:NumberOfOptionalParams-off
// BSLLS:UsingServiceTag-off
// BSLLS:LineLength-off
// BSLLS:QueryParseError-off
// BSLLS:AssignAliasFieldsInQuery-off

//@skip-check module-structure-top-region
//@skip-check module-structure-method-in-regions
//@skip-check wrong-string-literal-content
//@skip-check method-too-many-params
//@skip-check constructor-function-return-section

// Раскомментировать, если выполняется OneScript
#Использовать "./internal"

#Область СлужебныйПрограммныйИнтерфейс

Функция СоздатьБазуДанных(Знач Модуль, Знач База, Знач Соединение = "") Экспорт

    Схема = ПустаяСхемаSQL("CREATEDATABASE");

    УстановитьИмяБазы(Схема, База);

    Запрос    = СформироватьТекстSQL(Схема);
    Результат = Модуль.ВыполнитьЗапросSQL(Запрос, , , Соединение);

    Возврат Результат;

КонецФункции

Функция УдалитьБазуДанных(Знач Модуль, Знач База, Знач Соединение = "") Экспорт

    Схема = ПустаяСхемаSQL("DROPDATABASE");

    УстановитьИмяБазы(Схема, База);

    Запрос    = СформироватьТекстSQL(Схема);
    Результат = Модуль.ВыполнитьЗапросSQL(Запрос, , , Соединение);

    Возврат Результат;

КонецФункции

Функция СоздатьТаблицу(Знач Модуль, Знач Таблица, Знач СтруктураКолонок, Знач Соединение = "") Экспорт

    ТекстОшибки = "Структура колонок не является валидной структурой ключ-значение";
    OPI_ПреобразованиеТипов.ПолучитьКоллекциюКлючИЗначение(СтруктураКолонок, ТекстОшибки);

    Схема = ПустаяСхемаSQL("CREATE");

    УстановитьИмяТаблицы(Схема, Таблица);

    Для Каждого Колонка Из СтруктураКолонок Цикл
        ДобавитьКолонку(Схема, Колонка.Ключ, Колонка.Значение);
    КонецЦикла;

    Запрос    = СформироватьТекстSQL(Схема);
    Результат = Модуль.ВыполнитьЗапросSQL(Запрос, , , Соединение);

    Возврат Результат;

КонецФункции

Функция ДобавитьЗаписи(Знач Модуль
    , Знач Таблица
    , Знач МассивДанных
    , Знач Транзакция = Истина
    , Знач Соединение = "") Экспорт

    OPI_ПреобразованиеТипов.ПолучитьМассив(МассивДанных);
    OPI_ПреобразованиеТипов.ПолучитьБулево(Транзакция);

    Соединение     = ОткрытьСоединениеВМодуле(Модуль.ИмяКоннектора(), Соединение);
    ПроблемныйЭтап = ОбработатьНачалоЗаписи(Модуль, Транзакция, Соединение);

    Если ЗначениеЗаполнено(ПроблемныйЭтап) Тогда
        Возврат ПроблемныйЭтап;
    КонецЕсли;

    СтруктураОбработки  = ОбработатьЗаписи(Модуль, Таблица, МассивДанных, Транзакция, Соединение);
    СтруктураРезультата = ОбработатьКонецЗаписи(СтруктураОбработки, Модуль, Транзакция, Соединение);

    Возврат СтруктураРезультата;

КонецФункции

Функция ПолучитьЗаписи(Знач Модуль
    , Знач Таблица
    , Знач Поля       = "*"
    , Знач Фильтры    = ""
    , Знач Сортировка = ""
    , Знач Количество = ""
    , Знач Соединение = "") Экспорт

    Схема = ПустаяСхемаSQL("SELECT");

    УстановитьИмяТаблицы(Схема, Таблица);
    УстановитьЛимит(Схема, Количество);

    ЗаполнитьПоля(Схема, Поля);
    ЗаполнитьФильтры(Схема, Фильтры);
    ЗаполнитьСортировку(Схема, Сортировка);

    Запрос = СформироватьТекстSQL(Схема);

    Результат = Модуль.ВыполнитьЗапросSQL(Запрос, Схема["values"], , Соединение);

    Возврат Результат;

КонецФункции

Функция ОбновитьЗаписи(Знач Модуль
    , Знач Таблица
    , Знач СтруктураЗначений
    , Знач Фильтры    = ""
    , Знач Соединение = "") Экспорт

    Схема = ПустаяСхемаSQL("UPDATE");

    МассивПолей    = Новый Массив;
    МассивЗначений = Новый Массив;

    УстановитьИмяТаблицы(Схема, Таблица);
    РазделитьКоллекциюДанных(СтруктураЗначений, МассивПолей, МассивЗначений);

    Схема["values"] = МассивЗначений;

    Для Каждого Поле Из МассивПолей Цикл
        ДобавитьПоле(Схема, Поле);
    КонецЦикла;

    ЗаполнитьФильтры(Схема, Фильтры);

    Запрос    = СформироватьТекстSQL(Схема);
    Результат = Модуль.ВыполнитьЗапросSQL(Запрос, Схема["values"], , Соединение);

    Возврат Результат;

КонецФункции

Функция УдалитьЗаписи(Знач Модуль, Знач Таблица, Знач Фильтры = "", Знач Соединение = "") Экспорт

    Схема = ПустаяСхемаSQL("DELETE");

    УстановитьИмяТаблицы(Схема, Таблица);

    ЗаполнитьФильтры(Схема, Фильтры);

    Запрос    = СформироватьТекстSQL(Схема);
    Результат = Модуль.ВыполнитьЗапросSQL(Запрос, Схема["values"], , Соединение);

    Возврат Результат;

КонецФункции

Функция УдалитьТаблицу(Знач Модуль, Знач Таблица, Знач Соединение = "") Экспорт

    Схема = ПустаяСхемаSQL("DROP");

    УстановитьИмяТаблицы(Схема, Таблица);

    Запрос    = СформироватьТекстSQL(Схема);
    Результат = Модуль.ВыполнитьЗапросSQL(Запрос, , , Соединение);

    Возврат Результат;

КонецФункции

Функция ОчиститьТаблицу(Знач Модуль, Знач Таблица, Знач Соединение = "") Экспорт

    Схема = ПустаяСхемаSQL("TRUNCATE");

    УстановитьИмяТаблицы(Схема, Таблица);

    Запрос    = СформироватьТекстSQL(Схема);
    Результат = Модуль.ВыполнитьЗапросSQL(Запрос, , , Соединение);

    Возврат Результат;

КонецФункции

Функция ПолучитьСтруктуруФильтраЗаписей(Знач Пустая = Ложь) Экспорт

    СтруктураФильтра = Новый Структура;

    СтруктураФильтра.Вставить("field", "<имя поля для отбора>");
    СтруктураФильтра.Вставить("type" , "<тип сравнения>");
    СтруктураФильтра.Вставить("value", "<значение для сравнения>");
    СтруктураФильтра.Вставить("union", "<связь со следующим условием: AND, OR и пр.>");
    СтруктураФильтра.Вставить("raw"  , "<истина - значение будет вставлено текстом, как есть, ложь - через параметр>");

    Если Пустая Тогда
        СтруктураФильтра = OPI_Инструменты.ОчиститьКоллекциюРекурсивно(СтруктураФильтра);
    КонецЕсли;

    //@skip-check constructor-function-return-section
    Возврат СтруктураФильтра;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Схемы

Функция ПустаяСхемаSQL(Знач Действие, Знач Особенности = Неопределено)

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Действие);

    Действие = вРег(Действие);

    Если Действие = "SELECT" Тогда

        Схема = ПустаяСхемаSelect();

    ИначеЕсли Действие = "INSERT" Тогда

        Схема = ПустаяСхемаInsert(Особенности);

    ИначеЕсли Действие = "UPDATE" Тогда

        Схема = ПустаяСхемаUpdate();

    ИначеЕсли Действие = "DELETE" Тогда

        Схема = ПустаяСхемаDelete();

    ИначеЕсли Действие = "CREATE" Тогда

        Схема = ПустаяСхемаCreate();

    ИначеЕсли Действие = "DROP" Тогда

        Схема = ПустаяСхемаDrop();

    ИначеЕсли Действие = "TRUNCATE" Тогда

        Схема = ПустаяСхемаTruncate();

    ИначеЕсли Действие = "CREATEDATABASE" Тогда

        Схема = ПустаяСхемаCreateDatabase();

    ИначеЕсли Действие = "DROPDATABASE" Тогда

        Схема = ПустаяСхемаDropDatabase();

    Иначе

        Схема = Новый Структура;

    КонецЕсли;

    Возврат Схема;

КонецФункции

Функция ПустаяСхемаSelect()

    Схема = Новый Структура("type", "SELECT");

    Схема.Вставить("table"   , "");
    Схема.Вставить("filter"  , Новый Массив);
    Схема.Вставить("order"   , Новый Массив);
    Схема.Вставить("limit"   , 0);
    Схема.Вставить("set"     , Новый Массив);
    Схема.Вставить("values"  , Новый Массив);

    Возврат Схема;

КонецФункции

Функция ПустаяСхемаInsert(Знач Особенности)

    Схема = Новый Структура("type", "INSERT");

    НумерацияПараметров = ?(ЗначениеЗаполнено(Особенности), Особенности["НумерацияПараметров"], Ложь);
    МаркерПараметров    = ?(ЗначениеЗаполнено(Особенности), Особенности["МаркерПараметров"]   , "?");

    Схема.Вставить("table", "");
    Схема.Вставить("set"  , Новый Массив);
    Схема.Вставить("nump" , НумерацияПараметров);
    Схема.Вставить("markp", МаркерПараметров);

    Возврат Схема;

КонецФункции

Функция ПустаяСхемаUpdate()

    Схема = Новый Структура("type", "UPDATE");

    Схема.Вставить("table"   , "");
    Схема.Вставить("set"     , Новый Массив);
    Схема.Вставить("filter"  , Новый Массив);
    Схема.Вставить("values"  , Новый Массив);

    Возврат Схема;

КонецФункции

Функция ПустаяСхемаDelete()

    Схема = Новый Структура("type", "DELETE");

    Схема.Вставить("table" , "");
    Схема.Вставить("filter", Новый Массив);
    Схема.Вставить("values", Новый Массив);

    Возврат Схема;

КонецФункции

Функция ПустаяСхемаCreate()

    Схема = Новый Структура("type", "CREATE");

    Схема.Вставить("table"  , "");
    Схема.Вставить("columns", Новый Массив);

    Возврат Схема;

КонецФункции

Функция ПустаяСхемаDrop()

    Схема = Новый Структура("type", "DROP");

    Схема.Вставить("table"  , "");

    Возврат Схема;

КонецФункции

Функция ПустаяСхемаTruncate()

    Схема = Новый Структура("type", "TRUNCATE");

    Схема.Вставить("table"  , "");

    Возврат Схема;

КонецФункции

Функция ПустаяСхемаCreateDatabase();

    Схема = Новый Структура("type", "CREATEDATABASE");

    Схема.Вставить("database"  , "");

    Возврат Схема;

КонецФункции

Функция ПустаяСхемаDropDatabase();

    Схема = Новый Структура("type", "DROPDATABASE");

    Схема.Вставить("database"  , "");

    Возврат Схема;

КонецФункции

#КонецОбласти

#Область Процессоры

Функция СформироватьТекстSQL(Знач Схема)

    ТекстОшибки = "Переданное значение не является валидной схемой SQL запроса";
    OPI_ПреобразованиеТипов.ПолучитьКоллекциюКлючИЗначение(Схема, ТекстОшибки);

    ТипСхемы = "";

    Если Не OPI_Инструменты.ПолеКоллекцииСуществует(Схема, "type", ТипСхемы) Тогда
        ВызватьИсключение ТекстОшибки;
    КонецЕсли;

    ТипСхемы = вРег(ТипСхемы);

    Если ТипСхемы = "SELECT" Тогда

        ТекстЗапроса = СформироватьТекстSelect(Схема);

    ИначеЕсли ТипСхемы = "INSERT" Тогда

        ТекстЗапроса = СформироватьТекстInsert(Схема);

    ИначеЕсли ТипСхемы = "UPDATE" Тогда

        ТекстЗапроса = СформироватьТекстUpdate(Схема);

    ИначеЕсли ТипСхемы = "DELETE" Тогда

        ТекстЗапроса = СформироватьТекстDelete(Схема);

    ИначеЕсли ТипСхемы = "CREATE" Тогда

        ТекстЗапроса = СформироватьТекстCreate(Схема);

    ИначеЕсли ТипСхемы = "DROP" Тогда

        ТекстЗапроса = СформироватьТекстDrop(Схема);

    ИначеЕсли ТипСхемы = "TRUNCATE" Тогда

        ТекстЗапроса = СформироватьТекстTruncate(Схема);

    ИначеЕсли ТипСхемы = "CREATEDATABASE" Тогда

        ТекстЗапроса = СформироватьТекстCreateDatabase(Схема);

    ИначеЕсли ТипСхемы = "DROPDATABASE" Тогда

        ТекстЗапроса = СформироватьТекстDropDatabase(Схема);
    Иначе

        ТекстЗапроса = "";

    КонецЕсли;

    Возврат ТекстЗапроса;

КонецФункции

Функция СформироватьТекстSelect(Знач Схема)

    ПроверитьОбязательныеПоляСхемы(Схема, "table,filter,order,limit,set");

    Таблица    = Схема["table"];
    Поля       = Схема["set"];
    Фильтры    = Схема["filter"];
    Сортировка = Схема["order"];
    Количество = Схема["limit"];

    ШаблонSQL = "SELECT %1 FROM %2
    |%3;";

    БлокНастроек = СформироватьТекстНастроекSelect(Фильтры, Сортировка, Количество);

    ТекстSQL = СтрШаблон(ШаблонSQL, СтрСоединить(Поля, ", "), Таблица, БлокНастроек);

    Возврат ТекстSQL;

КонецФункции

Функция СформироватьТекстInsert(Знач Схема)

    ПроверитьОбязательныеПоляСхемы(Схема, "table,set");

    Таблица   = Схема["table"];
    Поля      = Схема["set"];
    Нумерация = Схема["nump"];
    Маркер    = Схема["markp"];

    ШаблонSQL = "INSERT INTO %1 (%2) VALUES (%3);";

    Параметры = Новый Массив;

    Для Н = 1 По Поля.Количество() Цикл

        ТекущийМаркер = Маркер;

        Если Нумерация Тогда
            ТекущийМаркер = ТекущийМаркер + OPI_Инструменты.ЧислоВСтроку(Н);
        КонецЕсли;

        Параметры.Добавить(ТекущийМаркер);

    КонецЦикла;

    ТекстSQL = СтрШаблон(ШаблонSQL
        , Таблица
        , СтрСоединить(Поля, ", ")
        , СтрСоединить(Параметры, ", "));

    Возврат ТекстSQL;

КонецФункции

Функция СформироватьТекстUpdate(Знач Схема)

    ПроверитьОбязательныеПоляСхемы(Схема, "table,set,values");

    Таблица = Схема["table"];
    Поля    = Схема["set"];
    Фильтры = Схема["filter"];

    ШаблонSQL = "UPDATE %1 SET %2 %3;";

    ТекстФильтра = СформироватьТекстФильтра(Фильтры);

    Для Н = 0 По Поля.ВГраница() Цикл

        Поля[Н] = Поля[Н] + " = ?" + OPI_Инструменты.ЧислоВСтроку(Н + 1);

    КонецЦикла;

    ТекстSQL = СтрШаблон(ШаблонSQL, Таблица, СтрСоединить(Поля, "," + Символы.ПС), ТекстФильтра);

    Возврат ТекстSQL;

КонецФункции

Функция СформироватьТекстDelete(Знач Схема)

    ПроверитьОбязательныеПоляСхемы(Схема, "table");

    Таблица = Схема["table"];
    Фильтры = Схема["filter"];

    ШаблонSQL = "DELETE FROM %1 %2;";

    ТекстФильтра = СформироватьТекстФильтра(Фильтры);

    ТекстSQL = СтрШаблон(ШаблонSQL, Таблица, ТекстФильтра);

    Возврат ТекстSQL;

КонецФункции

Функция СформироватьТекстCreate(Знач Схема)

    ПроверитьОбязательныеПоляСхемы(Схема, "table,columns");

    Таблица = Схема["table"];
    Колонки = Схема["columns"];

    ШаблонSQL = "CREATE TABLE %1 (
    | %2
    | );";

    ШаблонКолонки = "%1 %2";

    МассивОписанийКолонок = Новый Массив;

    Для Каждого Колонка Из Колонки Цикл
        Для Каждого Элемент Из Колонка Цикл
            МассивОписанийКолонок.Добавить(СтрШаблон(ШаблонКолонки, Элемент.Ключ, Элемент.Значение));
        КонецЦикла;
    КонецЦикла;

    ОписанияКолонок = СтрСоединить(МассивОписанийКолонок, "," + Символы.ПС);

    ТекстSQL = СтрШаблон(ШаблонSQL, Таблица, ОписанияКолонок);

    Возврат ТекстSQL;

КонецФункции

Функция СформироватьТекстDrop(Знач Схема)

    ПроверитьОбязательныеПоляСхемы(Схема, "table");

    Таблица = Схема["table"];

    ШаблонSQL = "DROP TABLE %1;";

    ТекстSQL = СтрШаблон(ШаблонSQL, Таблица);

    Возврат ТекстSQL;

КонецФункции

Функция СформироватьТекстTruncate(Знач Схема)

    ПроверитьОбязательныеПоляСхемы(Схема, "table");

    Таблица = Схема["table"];

    ШаблонSQL = "TRUNCATE TABLE %1;";

    ТекстSQL = СтрШаблон(ШаблонSQL, Таблица);

    Возврат ТекстSQL;

КонецФункции

Функция СформироватьТекстCreateDatabase(Знач Схема)

    ПроверитьОбязательныеПоляСхемы(Схема, "database");

    База = Схема["database"];

    ШаблонSQL = "CREATE DATABASE %1;";

    ТекстSQL = СтрШаблон(ШаблонSQL, База);

    Возврат ТекстSQL;

КонецФункции

Функция СформироватьТекстDropDatabase(Знач Схема)

    ПроверитьОбязательныеПоляСхемы(Схема, "database");

    База = Схема["database"];

    ШаблонSQL = "DROP DATABASE %1;";

    ТекстSQL = СтрШаблон(ШаблонSQL, База);

    Возврат ТекстSQL;

КонецФункции

#КонецОбласти

#Область Вспомогательные

Функция ОбработатьЗаписи(Знач Модуль, Знач Таблица, Знач МассивДанных, Знач Транзакция, Знач Соединение)

    МассивОшибок    = Новый Массив;
    ОшибкаКоллекции = "Invalid data";
    Счетчик         = 0;
    СчетчикУспешных = 0;

    Для Каждого Запись Из МассивДанных Цикл

        Счетчик = Счетчик + 1;

        Попытка
            OPI_ПреобразованиеТипов.ПолучитьКоллекциюКлючИЗначение(Запись, ОшибкаКоллекции);
        Исключение

            МассивОшибок.Добавить(Новый Структура("row,error", Счетчик, ОшибкаКоллекции));

            Если Транзакция Тогда
                Прервать;
            Иначе
                Продолжить;
            КонецЕсли;

        КонецПопытки;

        Результат = ДобавитьЗапись(Модуль, Таблица, Запись, Соединение);

        Если Результат["result"] Тогда

            СчетчикУспешных = СчетчикУспешных + 1;

        Иначе

            МассивОшибок.Добавить(Новый Структура("row,error", Счетчик, Результат["error"]));

        КонецЕсли;

    КонецЦикла;

    Результат = Новый Структура("МассивОшибок,СчетчикУспешных", МассивОшибок, СчетчикУспешных);
    Возврат Результат;

КонецФункции

Функция ОбработатьНачалоЗаписи(Знач Модуль, Знач Транзакция, Знач Соединение)

    Если Не ЭтоКомпонента(Соединение) Тогда
        Возврат Соединение;
    КонецЕсли;

    Если Транзакция Тогда

        Начало = Модуль.ВыполнитьЗапросSQL("BEGIN", , , Соединение);

        Если Не Начало["result"] Тогда
            Возврат Начало;
        КонецЕсли;

    КонецЕсли;

КонецФункции

Функция ОбработатьКонецЗаписи(Знач СтруктураОбработки, Знач Модуль, Знач Транзакция, Знач Соединение)

    СтруктураРезультата = Новый Структура;

    МассивОшибок    = СтруктураОбработки["МассивОшибок"];
    СчетчикУспешных = СтруктураОбработки["СчетчикУспешных"];

    Если Транзакция Тогда

        Если МассивОшибок.Количество() > 0 Тогда

            Откат = Модуль.ВыполнитьЗапросSQL("ROLLBACK;", , , Соединение);

            СчетчикУспешных = 0;
            СтруктураРезультата.Вставить("rollback", Откат);

        Иначе

            Завершение = Модуль.ВыполнитьЗапросSQL("COMMIT;", , , Соединение);
            СтруктураРезультата.Вставить("commit", Завершение);

        КонецЕсли;

    КонецЕсли;

    СтруктураРезультата.Вставить("result", МассивОшибок.Количество() = 0);
    СтруктураРезультата.Вставить("rows"  , СчетчикУспешных);
    СтруктураРезультата.Вставить("errors", МассивОшибок);

    Возврат СтруктураРезультата;

КонецФункции

Функция ДобавитьЗапись(Знач Модуль, Знач Таблица, Знач Запись, Знач Соединение)

    МассивПолей    = Новый Массив;
    МассивЗначений = Новый Массив;

    Особенности = Модуль.ПолучитьОсобенности();

    Схема = ПустаяСхемаSQL("INSERT", Особенности);
    УстановитьИмяТаблицы(Схема, Таблица);

    РазделитьКоллекциюДанных(Запись, МассивПолей, МассивЗначений);

    Для Каждого Поле Из МассивПолей Цикл
        ДобавитьПоле(Схема, Поле);
    КонецЦикла;

    Запрос = СформироватьТекстSQL(Схема);

    Результат = Модуль.ВыполнитьЗапросSQL(Запрос, МассивЗначений, , Соединение);

    Возврат Результат;

КонецФункции

Функция СформироватьТекстНастроекSelect(Знач Фильтры, Знач Сортировка, Знач Количество)

    ШаблонБлока = "%1
    |%2
    |%3";

    ТекстФильтра    = СформироватьТекстФильтра(Фильтры);
    ТекстСортировки = СформироватьТекстСортировки(Сортировка);
    ТекстКоличества = СформироватьТекстКоличества(Количество);

    ТекстБлока = СтрШаблон(ШаблонБлока, ТекстФильтра, ТекстСортировки, ТекстКоличества);

    Возврат ТекстБлока;

КонецФункции

Функция СформироватьТекстФильтра(Знач Фильтры)

    Если Не ЗначениеЗаполнено(Фильтры) Тогда
        Возврат "";
    КонецЕсли;

    ТекстФильтров = "WHERE %1";

    МассивФильтров = Новый Массив;

    Счетчик = 1;
    Всего   = Фильтры.Количество();

    Для Каждого Фильтр Из Фильтры Цикл

        ТекущийТекст = "%1 %2 %3 %4";

        Поле       = Фильтр["field"];
        Тип        = Фильтр["type"];
        Значение   = Фильтр["value"];
        Соединение = Фильтр["union"];
        Соединение = ?(ЗначениеЗаполнено(Соединение), Соединение, "AND");

        Если Счетчик = Всего Тогда
            Соединение = "";
        КонецЕсли;

        ТекущийТекст = СтрШаблон(ТекущийТекст, Поле, Тип, Значение, Соединение);
        МассивФильтров.Добавить(ТекущийТекст);

        Счетчик = Счетчик + 1;

    КонецЦикла;

    ТекстФильтров = СтрШаблон(ТекстФильтров, СтрСоединить(МассивФильтров, " "));

    Возврат ТекстФильтров;

КонецФункции

Функция СформироватьТекстСортировки(Знач Сортировка)

    Если Не ЗначениеЗаполнено(Сортировка) Тогда
        Возврат "";
    КонецЕсли;

    ТекстСортировки = "ORDER BY %1";

    МассивСортировки = Новый Массив;

    Для Каждого Элемент Из Сортировка Цикл

        МассивСортировки.Добавить(Элемент["field"] + " " + Элемент["type"]);

    КонецЦикла;

    ТекстСортировки = СтрШаблон(ТекстСортировки, СтрСоединить(МассивСортировки, ", "));

    Возврат ТекстСортировки;

КонецФункции

Функция СформироватьТекстКоличества(Знач Количество)

    Если Не ЗначениеЗаполнено(Количество) Тогда
        Возврат "";
    КонецЕсли;

    ТекстКоличества = "LIMIT %1";
    ТекстКоличества = СтрШаблон(ТекстКоличества, OPI_Инструменты.ЧислоВСтроку(Количество));

    Возврат ТекстКоличества;

КонецФункции

Функция ОткрытьСоединениеВМодуле(Знач Коннектор, Знач База)

    Если ЭтоКомпонента(База) Тогда
        Возврат База;
    КонецЕсли;

    OPI_ПреобразованиеТипов.ПолучитьСтроку(База);
    OPI_Инструменты.ВернутьУправляющиеПоследовательности(База);

    ИмяПоля   = ПолучитьИмяОсновногоПоля(Коннектор);
    Коннектор = ПодключитьКомпонентуНаСервере(Коннектор);

    Коннектор[ИмяПоля] = База;

    Результат = Коннектор.Connect();
    Результат = OPI_Инструменты.JsonВСтруктуру(Результат, Ложь);

    Возврат ?(Результат["result"], Коннектор, Результат);

КонецФункции

Функция ЭтоКомпонента(Знач Значение)

    ТипЗначения = Строка(ТипЗнч(Значение));
    Возврат СтрНачинаетсяС(ТипЗначения, "AddIn.");

КонецФункции

Функция ПодключитьКомпонентуНаСервере(Знач ИмяКомпоненты, Знач Класс = "Main")

    Если OPI_Инструменты.ЭтоOneScript() Тогда
        ИмяМакета = OPI_Инструменты.КаталогКомпонентOS() + ИмяКомпоненты + ".zip";
    Иначе
        ИмяМакета = "ОбщийМакет." + ИмяКомпоненты;
    КонецЕсли;

    ПодключитьВнешнююКомпоненту(ИмяМакета, ИмяКомпоненты, ТипВнешнейКомпоненты.Native);

    Компонента = Новый ("AddIn." + ИмяКомпоненты + "." + Класс);
    Возврат Компонента;

КонецФункции

Функция ПолучитьИмяОсновногоПоля(Знач Коннектор)

    Если Коннектор = "OPI_SQLite" Тогда
        Возврат "Database";
    Иначе
        Возврат "ConnectionString";
    КонецЕсли;

КонецФункции

Процедура РазделитьКоллекциюДанных(Знач Запись, МассивПолей, МассивЗначений)

    ТекстОшибки = "Некорректный набор данных для обновления";
    OPI_ПреобразованиеТипов.ПолучитьКоллекциюКлючИЗначение(Запись, ТекстОшибки);

    Для Каждого Элемент Из Запись Цикл

        МассивПолей.Добавить(Элемент.Ключ);
        МассивЗначений.Добавить(Элемент.Значение);

    КонецЦикла;

КонецПроцедуры

Процедура ЗаполнитьПоля(Схема, Знач Поля)

    Если Не ЗначениеЗаполнено(Поля) Тогда
        Поля = "*";
    КонецЕсли;

    OPI_ПреобразованиеТипов.ПолучитьМассив(Поля);

    Для Каждого Поле Из Поля Цикл
        ДобавитьПоле(Схема, Поле);
    КонецЦикла;

КонецПроцедуры

Процедура ЗаполнитьФильтры(Схема, Знач Фильтры)

    Если Не ЗначениеЗаполнено(Фильтры) Тогда
        Возврат;
    КонецЕсли;

    OPI_ПреобразованиеТипов.ПолучитьМассив(Фильтры);

    Для Каждого Фильтр Из Фильтры Цикл

        ДобавитьОтбор(Схема
            , Фильтр["field"]
            , ?(OPI_Инструменты.ПолеКоллекцииСуществует(Фильтр, "type"), Фильтр["type"], "=")
            , Фильтр["value"]
            , ?(OPI_Инструменты.ПолеКоллекцииСуществует(Фильтр, "union"), Фильтр["union"], "AND")
            , ?(OPI_Инструменты.ПолеКоллекцииСуществует(Фильтр, "raw"), Фильтр["raw"], Ложь));

    КонецЦикла;

КонецПроцедуры

Процедура ЗаполнитьСортировку(Знач Схема, Знач Сортировка)

    Если Не ЗначениеЗаполнено(Сортировка) Тогда
        Возврат;
    КонецЕсли;

    OPI_ПреобразованиеТипов.ПолучитьКоллекцию(Сортировка);

    Для Каждого Элемент Из Сортировка Цикл

        ДобавитьСортировку(Схема, Элемент.Ключ, Элемент.Значение);

    КонецЦикла;

КонецПроцедуры

Процедура ПроверитьОбязательныеПоляСхемы(Схема, Знач Поля)

    МассивОбязательныхПолей = СтрРазделить(Поля, ",");
    МассивОтсутствующих     = OPI_Инструменты.НайтиОтсутствующиеПоляКоллекции(Схема, МассивОбязательныхПолей);

    Если ЗначениеЗаполнено(МассивОтсутствующих) Тогда
        ВызватьИсключение "Отсутствуют необходимые поля схемы: " + СтрСоединить(МассивОтсутствующих, ", ");
    КонецЕсли;

КонецПроцедуры

Процедура ДобавитьКолонку(Схема, Знач Имя, Знач Тип) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Имя);
    OPI_ПреобразованиеТипов.ПолучитьСтроку(Тип);

    Если Не Схема["type"] = "CREATE" Тогда
        Возврат;
    КонецЕсли;

    СоответствиеКолонки = Новый Соответствие;
    СоответствиеКолонки.Вставить(Имя, Тип);

    Схема["columns"].Добавить(СоответствиеКолонки);

КонецПроцедуры

Процедура ДобавитьПоле(Схема, Знач Имя) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Имя);

    Схема["set"].Добавить(Имя);

КонецПроцедуры

Процедура ДобавитьОтбор(Схема, Знач Поле, Знач Тип, Знач Значение, Знач Группировка, Знач КакЕсть)

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Поле);
    OPI_ПреобразованиеТипов.ПолучитьСтроку(Тип);
    OPI_ПреобразованиеТипов.ПолучитьСтроку(Группировка);
    OPI_ПреобразованиеТипов.ПолучитьБулево(КакЕсть);

    ОсновнаяСтруктура = Новый Структура("field,type,union"
        , Поле
        , Тип
        , Группировка);

    Если КакЕсть Тогда

        ОсновнаяСтруктура.Вставить("value", Строка(Значение));

    Иначе

        Схема["values"].Добавить(Значение);

        ПорядковыйНомер = Схема["values"].Количество();
        ОсновнаяСтруктура.Вставить("value", "?" + OPI_Инструменты.ЧислоВСтроку(ПорядковыйНомер));

    КонецЕсли;

    Схема["filter"].Добавить(ОсновнаяСтруктура);

КонецПроцедуры

Процедура ДобавитьСортировку(Схема, Знач Поле, Знач Тип)

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Поле);
    OPI_ПреобразованиеТипов.ПолучитьСтроку(Тип);

    Схема["order"].Добавить(Новый Структура("field,type", Поле, Тип));

КонецПроцедуры

Процедура УстановитьИмяТаблицы(Схема, Знач Имя)

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Имя);

    Схема.Вставить("table", Имя);

КонецПроцедуры

Процедура УстановитьИмяБазы(Схема, Знач Имя)

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Имя);

    Схема.Вставить("database", Имя);

КонецПроцедуры

Процедура УстановитьЛимит(Схема, Знач Количество)

    OPI_ПреобразованиеТипов.ПолучитьЧисло(Количество);

    Схема.Вставить("limit", Количество);

КонецПроцедуры

#КонецОбласти

#КонецОбласти
