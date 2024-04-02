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
// BSLLS:UnusedLocalVariable-off
// BSLLS:UsingServiceTag-off

//@skip-check module-unused-local-variable

#Область СлужебныйПрограммныйИнтерфейс

#Область HTTPМетоды

#Область ЗапросыБезТела

Функция Get(Знач URL, Знач Параметры = "", Знач ДопЗаголовки = "") Экспорт
    Возврат ВыполнитьЗапросБезТела(URL, "GET", Параметры, ДопЗаголовки);
КонецФункции

Функция Delete(Знач URL, Знач Параметры = "", Знач ДопЗаголовки = "") Экспорт
    Возврат ВыполнитьЗапросБезТела(URL, "DELETE", Параметры, ДопЗаголовки);
КонецФункции

#КонецОбласти

#Область ЗапросыСТелом

Функция Post(Знач URL, Знач Параметры = "", Знач ДопЗаголовки = "", Знач JSON = Истина) Экспорт
    Возврат ВыполнитьЗапросСТелом(URL, "POST", Параметры, ДопЗаголовки, JSON);
КонецФункции

Функция Patch(Знач URL, Знач Параметры = "", Знач ДопЗаголовки = "", Знач JSON = Истина) Экспорт
    Возврат ВыполнитьЗапросСТелом(URL, "PATCH", Параметры, ДопЗаголовки, JSON);
КонецФункции

Функция Put(Знач URL, Знач Параметры = "", Знач ДопЗаголовки = "", Знач JSON = Истина) Экспорт
    Возврат ВыполнитьЗапросСТелом(URL, "PUT", Параметры, ДопЗаголовки, JSON);
КонецФункции

#КонецОбласти 

#Область ЗапросыMultipart

Функция PostMultipart(Знач URL
    , Знач Параметры
    , Знач Файлы = ""
    , Знач ТипКонтента = "image/jpeg"
    , Знач ДопЗаголовки = "") Экспорт

    Возврат ВыполнитьЗапросМультипарт(URL, "POST", Параметры, Файлы, ТипКонтента, ДопЗаголовки);

КонецФункции

Функция PutMultipart(Знач URL
    , Знач Параметры
    , Знач Файлы = ""
    , Знач ТипКонтента = "image/jpeg"
    , Знач ДопЗаголовки = "") Экспорт

    Возврат ВыполнитьЗапросМультипарт(URL, "PUT", Параметры, Файлы, ТипКонтента, ДопЗаголовки);

КонецФункции

Функция PostMultipartRelated(Знач URL, Знач JSON = "", Знач Файлы = "", Знач ДопЗаголовки = "") Экспорт   
    Возврат ВыполнитьЗапросМультипартРелэйтед(URL, "POST", JSON, Файлы, ДопЗаголовки);
КонецФункции

Функция PatchMultipartRelated(Знач URL, Знач JSON = "", Знач Файлы = "", Знач ДопЗаголовки = "") Экспорт   
    Возврат ВыполнитьЗапросМультипартРелэйтед(URL, "PATCH", JSON, Файлы, ДопЗаголовки);
КонецФункции

#КонецОбласти

#КонецОбласти

#Область Служебные

Функция ПараметрыЗапросаВСтроку(Знач Параметры) Экспорт

    Если Параметры.Количество() = 0 Тогда
        Возврат "";
    КонецЕсли;

    СтрокаПараметров = "?";

    Для Каждого Параметр Из Параметры Цикл
        СтрокаПараметров = СтрокаПараметров 
            + Параметр.Ключ 
            + "=" 
            + КодироватьСтроку(Параметр.Значение,
            СпособКодированияСтроки.КодировкаURL) 
            + "&";
    КонецЦикла;

    СтрокаПараметров = Лев(СтрокаПараметров, СтрДлина(СтрокаПараметров) - 1);

    Возврат СтрокаПараметров;

КонецФункции

Функция РазбитьURL(Знач URL) Экспорт

    URL = СтрЗаменить(URL, "https://", "");
    URL = СтрЗаменить(URL, "http://", "");
    URL = СтрЗаменить(URL, ":443", "");

    Адрес  = Прав(URL, СтрДлина(URL) - СтрНайти(URL, "/", НаправлениеПоиска.СНачала) + 1);
    Сервер = Лев(URL, СтрНайти(URL, "/", НаправлениеПоиска.СНачала) - 1);
    
    Попытка        
        SSL = Новый ЗащищенноеСоединениеOpenSSL;   
    Исключение
        Сервер = "https://" + Сервер;
    КонецПопытки;
      
    СтруктураВозврата = Новый Структура;
    СтруктураВозврата.Вставить("Сервер", Сервер);
    СтруктураВозврата.Вставить("Адрес" , Адрес);

    Возврат СтруктураВозврата;

КонецФункции

Функция JsonВСтруктуру(Знач Текст) Экспорт

    Если Не ЗначениеЗаполнено(Текст) Тогда
        Возврат "";
    КонецЕсли;
    
    Текст = ?(ТипЗнч(Текст) = Тип("ДвоичныеДанные"), ПолучитьСтрокуИзДвоичныхДанных(Текст), Текст);

    ЧтениеJSON = Новый ЧтениеJSON;
    ЧтениеJSON.УстановитьСтроку(Текст);

    Данные = ПрочитатьJSON(ЧтениеJSON, Истина, Неопределено, ФорматДатыJSON.ISO);
    ЧтениеJSON.Закрыть();

    Возврат Данные;

КонецФункции

Функция JSONСтрокой(Знач Данные, Знач Экранирование = "Нет") Экспорт

    ПараметрыJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Windows
        , " "
        , Истина
        , ЭкранированиеСимволовJSON[Экранирование]
        , Ложь
        , Ложь
        , Ложь
        , Ложь);

    Попытка
        
        ЗаписьJSON = Новый ЗаписьJSON;
        ЗаписьJSON.УстановитьСтроку(ПараметрыJSON);
    
        ЗаписатьJSON(ЗаписьJSON, Данные);
        Возврат ЗаписьJSON.Закрыть();
    
    Исключение      
        Возврат "НЕ JSON: " + Строка(Данные);
    КонецПопытки;

КонецФункции

Функция ЧислоВСтроку(Знач Число) Экспорт
    Возврат СтрЗаменить(Строка(Число), Символы.НПП, "");
КонецФункции

Функция ПрочитатьJSONФайл(Знач Путь) Экспорт
    
    ЧтениеJSON = Новый ЧтениеJSON;
    ЧтениеJSON.ОткрытьФайл(Путь);  
    Значения = ПрочитатьJSON(ЧтениеJSON);
    
    ЧтениеJSON.Закрыть();
    
    Возврат Значения;
    
КонецФункции

Функция ПараметрыЗапросаВСоответствие(Знач СтрокаПараметров) Экспорт

    СоответствиеВозврата = Новый Соответствие;
    КоличествоЧастей     = 2;
    МассивПараметров     = СтрРазделить(СтрокаПараметров, "&", Ложь);

    Для Каждого Параметр Из МассивПараметров Цикл

        МассивКлючЗначение = СтрРазделить(Параметр, "=");

        Если МассивКлючЗначение.Количество() = КоличествоЧастей Тогда
            СоответствиеВозврата.Вставить(МассивКлючЗначение[0], МассивКлючЗначение[1]);
        КонецЕсли;

    КонецЦикла;

    Возврат СоответствиеВозврата;

КонецФункции

Функция ПолучитьТекущуюДату() Экспорт
    Возврат МестноеВремя(ТекущаяУниверсальнаяДата());    
КонецФункции

Функция UNIXTime(Знач Дата) Экспорт
    
    ОТД  = Новый ОписаниеТипов("Дата");
    Дата = ОТД.ПривестиЗначение(Дата);
    
    Возврат Формат(Дата - Дата(1970, 1, 1, 1, 0, 0), "ЧЦ=10; ЧДЦ=0; ЧГ=0");
    
КонецФункции

Процедура ЗначениеВМассив(Значение) Экспорт
    
    Значение_ = Новый Массив;
    Значение_.Добавить(Значение);
    Значение = Значение_;

КонецПроцедуры

Процедура ЗаменитьСпецСимволы(Текст) Экспорт

    МассивСимволов = Новый Соответствие;
    МассивСимволов.Вставить("<", "&lt;");
    МассивСимволов.Вставить(">", "&gt;");
    МассивСимволов.Вставить("&", "&amp;");
    МассивСимволов.Вставить("_", " ");
    МассивСимволов.Вставить("[", "(");
    МассивСимволов.Вставить("]", ")");

    Для Каждого СимволМассива Из МассивСимволов Цикл
        Текст = СтрЗаменить(Текст, СимволМассива.Ключ, СимволМассива.Значение);
    КонецЦикла;

КонецПроцедуры

Процедура УдалитьПустыеПоляКоллекции(Коллекция) Экспорт
    
    ТипКоллекции        = ТипЗнч(Коллекция);
    ВыходнаяКоллекция   = Новый(ТипКоллекции);
    
    Если ТипКоллекции = Тип("Соответствие") Или ТипКоллекции = Тип("Структура") Тогда
        
        УдалитьПустыеКлючиЗначения(Коллекция, ВыходнаяКоллекция);
        
    ИначеЕсли ТипКоллекции = Тип("Массив") Тогда
        
        УдалитьПустыеЭлементыМассива(Коллекция, ВыходнаяКоллекция);
        
    Иначе
        
        ВыходнаяКоллекция = Коллекция;
        
    КонецЕсли;
    
    Коллекция = ВыходнаяКоллекция;
    
КонецПроцедуры

Процедура Пауза(Знач Секунды) Экспорт
    
    Соединение = Новый HTTPСоединение("1C.ru", 11111, , , , Секунды);
    Попытка
        Соединение.Получить(Новый HTTPЗапрос(""));
    Исключение
        Возврат;  
    КонецПопытки;
    
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ВыполнитьЗапросСТелом(Знач URL, Знач Вид, Знач Параметры = "", Знач ДопЗаголовки = "", Знач JSON = Истина)
    
    Если Не ЗначениеЗаполнено(Параметры) Тогда
        Параметры = Новый Структура;
    КонецЕсли;
    
    ТипДанных     = ?(JSON, "application/json", "application/x-www-form-urlencoded");   
    СтруктураURL  = РазбитьURL(URL);
    Сервер        = СтруктураURL["Сервер"];
    Адрес         = СтруктураURL["Адрес"];
    
    Запрос        = СоздатьЗапрос(Адрес, ДопЗаголовки, ТипДанных);
    Соединение    = СоздатьСоединение(Сервер);
    
    УстановитьТелоЗапроса(Запрос, Параметры, JSON);

    Ответ = Соединение.ВызватьHTTPМетод(Вид, Запрос);
     
    Если ЭтоПереадресация(Ответ) Тогда  
        Ответ = ВыполнитьЗапросСТелом(Ответ.Заголовки["Location"], Вид, Параметры, ДопЗаголовки, JSON);    
    Иначе    
        ОбработатьОтвет(Ответ);      
    КонецЕсли;

    Возврат Ответ;

КонецФункции

Функция ВыполнитьЗапросБезТела(Знач URL, Знач Вид, Знач Параметры = "", Знач ДопЗаголовки = "")
    
    Если Не ЗначениеЗаполнено(Параметры) Тогда
        Параметры = Новый Структура;
    КонецЕсли;

    СтруктураURL        = РазбитьURL(URL);
    Сервер              = СтруктураURL["Сервер"];
    Адрес               = СтруктураURL["Адрес"] + ПараметрыЗапросаВСтроку(Параметры);
    
    Запрос     = СоздатьЗапрос(Адрес, ДопЗаголовки);
    Соединение = СоздатьСоединение(Сервер);   
    Ответ      = Соединение.ВызватьHTTPМетод(Вид, Запрос);
      
    Если ЭтоПереадресация(Ответ) Тогда  
        Ответ = ВыполнитьЗапросБезТела(Ответ.Заголовки["Location"], Вид, Параметры, ДопЗаголовки);    
    Иначе    
        ОбработатьОтвет(Ответ);      
    КонецЕсли;

    Возврат Ответ;
    
КонецФункции

Функция ВыполнитьЗапросМультипарт(Знач URL
    , Знач Вид
    , Знач Параметры
    , Знач Файлы = ""
    , Знач ТипКонтента = "image/jpeg"
    , Знач ДопЗаголовки = "")
    
    Если Не ЗначениеЗаполнено(Параметры) Тогда
        Параметры = Новый Структура;
    КонецЕсли;

    Если Не ЗначениеЗаполнено(Файлы) Тогда
        Файлы = Новый Соответствие;
    КонецЕсли;

    Переадресация    = 300;
    Ошибка           = 400;
    Boundary         = СтрЗаменить(Строка(Новый УникальныйИдентификатор), "-", "");
    РазделительСтрок = Символы.ВК + Символы.ПС;
    ТипДанных        = "multipart/form-data; boundary=" + Boundary;
    СтруктураURL     = РазбитьURL(URL);
    Сервер           = СтруктураURL["Сервер"];
    Адрес            = СтруктураURL["Адрес"];
    
    Запрос        = СоздатьЗапрос(Адрес, ДопЗаголовки, ТипДанных);
    Соединение    = СоздатьСоединение(Сервер);
    ТелоЗапроса   = Запрос.ПолучитьТелоКакПоток();
    ЗаписьТекста  = Новый ЗаписьДанных(ТелоЗапроса, КодировкаТекста.UTF8, ПорядокБайтов.LittleEndian, "", "", Ложь);

    ЗаписатьПараметрыМультипарт(ЗаписьТекста, Boundary, Параметры);
    ЗаписатьФайлыМультипарт(ЗаписьТекста, Boundary, ТипКонтента, Файлы);
    
    ЗаписьТекста.ЗаписатьСтроку("--" + boundary + "--" + РазделительСтрок);
    ЗаписьТекста.Закрыть();

    Ответ            = Соединение.ВызватьHTTPМетод(Вид, Запрос);
    ЭтоПереадресация = Ответ.КодСостояния >= Переадресация И Ответ.КодСостояния < Ошибка;
   
    Если ЭтоПереадресация Тогда  
        Ответ = ВыполнитьЗапросМультипарт(Ответ.Заголовки["Location"]
            , Вид
            , Параметры
            , Файлы
            , ТипКонтента
            , ДопЗаголовки);    
    Иначе    
        ОбработатьОтвет(Ответ);      
    КонецЕсли;

    Возврат Ответ;
       
КонецФункции

Функция ВыполнитьЗапросМультипартРелэйтед(URL, Вид, JSON = "", Файлы = "", ДопЗаголовки = "") 
    
    Переадресация    = 300;
    Ошибка           = 400;
    Boundary         = СтрЗаменить(Строка(Новый УникальныйИдентификатор), "-", "");
    РазделительСтрок = Символы.ВК + Символы.ПС;
    ТипДанных        = "multipart/related; boundary=" + Boundary;
    СтруктураURL     = РазбитьURL(URL);
    Сервер           = СтруктураURL["Сервер"];
    Адрес            = СтруктураURL["Адрес"];
    
    Запрос        = СоздатьЗапрос(Адрес, ДопЗаголовки, ТипДанных);
    Соединение    = СоздатьСоединение(Сервер);
    
    ТелоЗапроса   = Запрос.ПолучитьТелоКакПоток();
    ЗаписьТекста  = Новый ЗаписьДанных(ТелоЗапроса, КодировкаТекста.UTF8, ПорядокБайтов.LittleEndian, "", "", Ложь);

    ЗаписатьJSONМультипарт(ЗаписьТекста, Boundary, JSON);
    ЗаписатьФайлыРелэйтед(ЗаписьТекста, Boundary, Файлы);        
    
    ЗаписьТекста.ЗаписатьСтроку("--" + boundary + "--" + РазделительСтрок);
    ЗаписьТекста.Закрыть();
    
    ДобавитьContentLength(Запрос);
    
    Ответ            = Соединение.ВызватьHTTPМетод(Вид, Запрос);
    ЭтоПереадресация = Ответ.КодСостояния >= Переадресация И Ответ.КодСостояния < Ошибка;
    
    Если ЭтоПереадресация Тогда  
        Ответ = ВыполнитьЗапросМультипартРелэйтед(Ответ.Заголовки["Location"], "POST", JSON, Файлы, ДопЗаголовки);    
    Иначе    
        ОбработатьОтвет(Ответ);      
    КонецЕсли;
    
    Возврат Ответ;

КонецФункции

Функция СоздатьЗапрос(Знач Адрес, Знач ДопЗаголовки = "", Знач ТипДанных = "")
      
    Заголовки = Новый Соответствие;
    Заголовки.Вставить("Accept-Encoding", "gzip");
    Заголовки.Вставить("Accept"         , "*/*");
    Заголовки.Вставить("Connection"     , "keep-alive");
    Заголовки.Вставить("Accept-Charset" , "utf-8");
   
    Если ЗначениеЗаполнено(ТипДанных) Тогда
        Заголовки.Вставить("Content-Type", ТипДанных);
    КонецЕсли;
       
    Если ТипЗнч(ДопЗаголовки) = Тип("Соответствие") Тогда
        
        Для Каждого Заголовок Из ДопЗаголовки Цикл
            Заголовки.Вставить(Заголовок.Ключ, Заголовок.Значение);
        КонецЦикла;
        
    КонецЕсли;
    
    НовыйЗапрос = Новый HTTPЗапрос(Адрес, Заголовки);
    
    Возврат НовыйЗапрос;
    
КонецФункции

Функция СоздатьСоединение(Знач Сервер)
    
    Попытка 
        SSL = Новый ЗащищенноеСоединениеOpenSSL;
        Возврат Новый HTTPСоединение(Сервер, 443, , , , 300, SSL);
    Исключение
        Возврат Новый HTTPСоединение(Сервер, 443, , , , 300);
    КонецПопытки;
    
КонецФункции

Функция ЭтоПереадресация(Знач Ответ)
    
    Переадресация  = 300;
    Ошибка         = 400;

    ЭтоПереадресация = Ответ.КодСостояния >= Переадресация И Ответ.КодСостояния < Ошибка;
    
    Возврат ЭтоПереадресация;
    
КонецФункции

Процедура ОбработатьОтвет(Ответ) 
    
    GZip            = "gzip";        
    НужнаРаспаковка = 
        Ответ.Заголовки.Получить("Content-Encoding") = GZip 
        Или Ответ.Заголовки.Получить("content-encoding") = GZip;
    
    Если НужнаРаспаковка Тогда
        Ответ = РаспаковатьОтвет(Ответ);
    КонецЕсли;
    
    Ответ = ?(ТипЗнч(Ответ) = Тип("HTTPОтвет"), Ответ.ПолучитьТелоКакДвоичныеДанные(), Ответ);
    
    Если ТипЗнч(Ответ) = Тип("ДвоичныеДанные") Тогда
        
        Попытка
            Ответ = JsonВСтруктуру(Ответ);
        Исключение
            Возврат;
        КонецПопытки;
        
    КонецЕсли;
    
КонецПроцедуры

Процедура УстановитьТелоЗапроса(Запрос, Знач Параметры, Знач JSON)
    
    Если JSON Тогда
        Данные           = JSONСтрокой(Параметры);
    Иначе
        СтрокаПараметров = ПараметрыЗапросаВСтроку(Параметры);
        Данные           = Прав(СтрокаПараметров, СтрДлина(СтрокаПараметров) - 1);
    КонецЕсли;
    
    Запрос.УстановитьТелоИзСтроки(Данные);
    
КонецПроцедуры

Процедура ЗаписатьПараметрыМультипарт(ЗаписьТекста, Знач Boundary, Знач Параметры)
    
    РазделительСтрок = Символы.ВК + Символы.ПС;
    
    Для Каждого Параметр Из Параметры Цикл
        
        Если Параметр.Значение = Неопределено
            Или Параметр.Значение = NULL Тогда
            Продолжить;
        КонецЕсли;
        
        ЗаписьТекста.ЗаписатьСтроку("--" + boundary + РазделительСтрок);
        ЗаписьТекста.ЗаписатьСтроку("Content-Disposition: form-data; name=""" + Параметр.Ключ + """");
        ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
        ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
        
        Если ТипЗнч(Параметр.Значение) = Тип("Строка") 
            Или ТипЗнч(Параметр.Значение) = Тип("Число") Тогда
            
            ЗначениеСтрокой = ЧислоВСтроку(Параметр.Значение);
            ЗаписьТекста.ЗаписатьСтроку(ЗначениеСтрокой);
            
        ИначеЕсли ТипЗнч(Параметр.Значение) = Тип("Булево") Тогда
            
            ЗаписьТекста.ЗаписатьСтроку(?(Параметр.Значение, "true", "false"));
            
        Иначе
            
            ЗаписьТекста.Записать(Параметр.Значение);
            
        КонецЕсли;
        
        ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
        
    КонецЦикла;
    
КонецПроцедуры

Процедура ЗаписатьФайлыМультипарт(ЗаписьТекста, Знач Boundary, Знач ТипКонтента, Знач Файлы)
    
    РазделительСтрок = Символы.ВК + Символы.ПС;
    ЗаменаТочки      = "___";
    
    Для Каждого Файл Из Файлы Цикл
        
        ПутьФайл = СтрЗаменить(Файл.Ключ, ЗаменаТочки, ".");
        
        Если ТипКонтента = "image/jpeg" Тогда
            ИмяФайлаОтправки = "photo";
        Иначе
            ИмяФайлаОтправки = СтрЗаменить(Файл.Ключ, ЗаменаТочки, ".");
            ИмяФайлаОтправки = Лев(ИмяФайлаОтправки, СтрНайти(ИмяФайлаОтправки, ".") - 1);
            ИмяФайлаОтправки = ?(ЗначениеЗаполнено(ИмяФайлаОтправки), ИмяФайлаОтправки, СтрЗаменить(Файл.Ключ,
            ЗаменаТочки, "."));
        КонецЕсли;
        
        ЗаписьТекста.ЗаписатьСтроку("--" + boundary + РазделительСтрок);
        ЗаписьТекста.ЗаписатьСтроку("Content-Disposition: form-data; name=""" 
            + ИмяФайлаОтправки 
            + """; filename=""" 
            + ПутьФайл
            + """");
        ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
        ЗаписьТекста.ЗаписатьСтроку("Content-Type: " + ТипКонтента);
        ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
        ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
        ЗаписьТекста.Записать(Файл.Значение);
        ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
        
    КонецЦикла;

КонецПроцедуры

Процедура ЗаписатьФайлыРелэйтед(ЗаписьТекста, Знач Boundary, Знач Файлы)
    
    Если Не ЗначениеЗаполнено(Файлы) Тогда
        Возврат;
    КонецЕсли;
    
    РазделительСтрок = Символы.ВК + Символы.ПС;
    
    Если ТипЗнч(Файлы) = Тип("Соответствие") Тогда
        Для Каждого Файл Из Файлы Цикл
            
            ЗаписьТекста.ЗаписатьСтроку("--" + boundary + РазделительСтрок);
            ЗаписьТекста.ЗаписатьСтроку("Content-Type: " + Файл.Значение);
            ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
            ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
            ЗаписьТекста.Записать(Файл.Ключ);
            ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
            ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
            
        КонецЦикла;
        
    КонецЕсли;

КонецПроцедуры

Процедура ЗаписатьJSONМультипарт(ЗаписьТекста, Знач Boundary, Знач JSON)
    
    Если Не ЗначениеЗаполнено(JSON) Тогда
        Возврат;
    КонецЕсли;
    
    РазделительСтрок = Символы.ВК + Символы.ПС;
    
    ЗаписьТекста.ЗаписатьСтроку("--" + boundary + РазделительСтрок);
    ЗаписьТекста.ЗаписатьСтроку("Content-Type: application/json; charset=UTF-8");
    ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
    ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
    ЗаписьТекста.ЗаписатьСтроку(JSON);
    ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);
    ЗаписьТекста.ЗаписатьСтроку(РазделительСтрок);

КонецПроцедуры

Процедура ДобавитьContentLength(Запрос)
    
    ТелоЗапроса = Запрос.ПолучитьТелоКакДвоичныеДанные();
    
    Если ЗначениеЗаполнено(ТелоЗапроса) Тогда
        
        Размер = ТелоЗапроса.Размер();
        Запрос.Заголовки.Вставить("Content-Length", ЧислоВСтроку(Размер));
        
    КонецЕсли;

КонецПроцедуры

Процедура УдалитьПустыеКлючиЗначения(Знач Коллекция, ВыходнаяКоллекция)
    
    Для Каждого ЭлементКоллекции Из Коллекция Цикл
        
        Если Не ЭлементКоллекции.Значение = Неопределено И Не ЭлементКоллекции.Значение = NULL Тогда
            ВыходнаяКоллекция.Вставить(ЭлементКоллекции.Ключ, ЭлементКоллекции.Значение);
        КонецЕсли;
        
    КонецЦикла;
    
КонецПроцедуры

Процедура УдалитьПустыеЭлементыМассива(Знач Коллекция, ВыходнаяКоллекция)
    
    Для Каждого ЭлементКоллекции Из Коллекция Цикл
        
        Если Не ЭлементКоллекции = Неопределено И Не ЭлементКоллекции = NULL Тогда
            ВыходнаяКоллекция.Добавить(ЭлементКоллекции);
        КонецЕсли;
        
    КонецЦикла;
    
КонецПроцедуры

#Область GZip

// Описание структур см. здесь https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT
// Источник: https://github.com/vbondarevsky/Connector 

// Коннектор: удобный HTTP-клиент для 1С:Предприятие 8
//
// Copyright 2017-2023 Vladimir Bondarevskiy
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//
//
// URL:    https://github.com/vbondarevsky/Connector
// e-mail: vbondarevsky@gmail.com
// Версия: 2.4.8
//
// Требования: платформа 1С версии 8.3.10 и выше

Функция РаспаковатьОтвет(Ответ)

    Попытка
        Возврат ПрочитатьGZip(Ответ.ПолучитьТелоКакДвоичныеДанные());
    Исключение
        Возврат Ответ;
    КонецПопытки;

КонецФункции

Функция ПрочитатьGZip(СжатыеДанные) Экспорт

    РазмерПрефиксаGZip  = 10;
    РазмерПостфиксаGZip = 8;
    
    РазмерДД  = ZipРазмерDD();
    РазмерСДХ = ZipРазмерCDH();
    РазмерЕСД = ZipРазмерEOCD();
    РазмерЛФХ = ZipРазмерLFH();

    ЧтениеДанных = Новый ЧтениеДанных(СжатыеДанные);
    ЧтениеДанных.Пропустить(РазмерПрефиксаGZip);
    РазмерСжатыхДанных = ЧтениеДанных.ИсходныйПоток().Размер() - РазмерПрефиксаGZip - РазмерПостфиксаGZip;

    ПотокZip     = Новый ПотокВПамяти(РазмерЛФХ 
       + РазмерСжатыхДанных 
       + РазмерДД 
       + РазмерСДХ 
       + РазмерЕСД);
       
    ЗаписьДанных = Новый ЗаписьДанных(ПотокZip);
    ЗаписьДанных.ЗаписатьБуферДвоичныхДанных(ZipLFH());
    ЧтениеДанных.КопироватьВ(ЗаписьДанных, РазмерСжатыхДанных);

    ЗаписьДанных.Закрыть();
    ЗаписьДанных = Новый ЗаписьДанных(ПотокZip);

    CRC32 = ЧтениеДанных.ПрочитатьЦелое32();
    РазмерНесжатыхДанных = ЧтениеДанных.ПрочитатьЦелое32();
    ЧтениеДанных.Закрыть();

    ЗаписьДанных.ЗаписатьБуферДвоичныхДанных(ZipDD(CRC32, РазмерСжатыхДанных, РазмерНесжатыхДанных));
    ЗаписьДанных.ЗаписатьБуферДвоичныхДанных(ZipCDH(CRC32, РазмерСжатыхДанных, РазмерНесжатыхДанных));
    ЗаписьДанных.ЗаписатьБуферДвоичныхДанных(ZipEOCD(РазмерСжатыхДанных));
    ЗаписьДанных.Закрыть();

    Возврат ПрочитатьZip(ПотокZip);

КонецФункции

Функция ПрочитатьZip(СжатыеДанные, ТекстОшибки = Неопределено)

    Каталог   = ПолучитьИмяВременногоФайла();
    ЧтениеZip = Новый ЧтениеZipФайла(СжатыеДанные);
    ИмяФайла  = ЧтениеZip.Элементы[0].Имя;
    Попытка
        ЧтениеZip.Извлечь(ЧтениеZip.Элементы[0], Каталог, РежимВосстановленияПутейФайловZIP.НеВосстанавливать);
    Исключение
        // Игнорируем проверку целостности архива, просто читаем результат
        ТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
    КонецПопытки;
    ЧтениеZip.Закрыть();

    Результат = Новый ДвоичныеДанные(Каталог + ПолучитьРазделительПути() + ИмяФайла);
    УдалитьФайлы(Каталог);

    Возврат Результат;

КонецФункции

Функция ZipРазмерLFH()

    Возврат 34;

КонецФункции

Функция ZipРазмерDD()

    Возврат 16;

КонецФункции

Функция ZipРазмерCDH()

    Возврат 50;

КонецФункции

Функция ZipРазмерEOCD()

    Возврат 22;

КонецФункции

Функция ZipLFH()
    
    // Local file header
    Буфер = Новый БуферДвоичныхДанных(ZipРазмерLFH());
    Буфер.ЗаписатьЦелое32(0, 67324752); // signature 0x04034b50
    Буфер.ЗаписатьЦелое16(4, 20);       // version
    Буфер.ЗаписатьЦелое16(6, 10);       // bit flags    
    Буфер.ЗаписатьЦелое16(8, 8);        // compression method
    Буфер.ЗаписатьЦелое16(10, 0);       // time
    Буфер.ЗаписатьЦелое16(12, 0);       // date
    Буфер.ЗаписатьЦелое32(14, 0);       // crc-32
    Буфер.ЗаписатьЦелое32(18, 0);       // compressed size
    Буфер.ЗаписатьЦелое32(22, 0);       // uncompressed size
    Буфер.ЗаписатьЦелое16(26, 4);       // filename legth - "data"
    Буфер.ЗаписатьЦелое16(28, 0);       // extra field length
    Буфер.Записать(30, ПолучитьБуферДвоичныхДанныхИзСтроки("data", "ascii", Ложь));

    Возврат Буфер;

КонецФункции

Функция ZipDD(CRC32, РазмерСжатыхДанных, РазмерНесжатыхДанных)
    
    // Data descriptor
    Буфер = Новый БуферДвоичныхДанных(ZipРазмерDD());
    Буфер.ЗаписатьЦелое32(0, 134695760);
    Буфер.ЗаписатьЦелое32(4, CRC32);
    Буфер.ЗаписатьЦелое32(8, РазмерСжатыхДанных);
    Буфер.ЗаписатьЦелое32(12, РазмерНесжатыхДанных);

    Возврат Буфер;

КонецФункции

Функция ZipCDH(CRC32, РазмерСжатыхДанных, РазмерНесжатыхДанных)
    
    // Central directory header
    Буфер = Новый БуферДвоичныхДанных(ZipРазмерCDH());
    Буфер.ЗаписатьЦелое32(0, 33639248);              // signature 0x02014b50
    Буфер.ЗаписатьЦелое16(4, 798);                   // version made by
    Буфер.ЗаписатьЦелое16(6, 20);                    // version needed to extract
    Буфер.ЗаписатьЦелое16(8, 10);                    // bit flags
    Буфер.ЗаписатьЦелое16(10, 8);                    // compression method
    Буфер.ЗаписатьЦелое16(12, 0);                    // time
    Буфер.ЗаписатьЦелое16(14, 0);                    // date
    Буфер.ЗаписатьЦелое32(16, CRC32);                // crc-32
    Буфер.ЗаписатьЦелое32(20, РазмерСжатыхДанных);   // compressed size
    Буфер.ЗаписатьЦелое32(24, РазмерНесжатыхДанных); // uncompressed size
    Буфер.ЗаписатьЦелое16(28, 4);                    // file name length
    Буфер.ЗаписатьЦелое16(30, 0);                    // extra field length
    Буфер.ЗаписатьЦелое16(32, 0);                    // file comment length
    Буфер.ЗаписатьЦелое16(34, 0);                    // disk number start
    Буфер.ЗаписатьЦелое16(36, 0);                    // internal file attributes
    Буфер.ЗаписатьЦелое32(38, 2176057344);           // external file attributes
    Буфер.ЗаписатьЦелое32(42, 0);                    // relative offset of local header
    Буфер.Записать(46, ПолучитьБуферДвоичныхДанныхИзСтроки("data", "ascii", Ложь));

    Возврат Буфер;

КонецФункции

Функция ZipEOCD(РазмерСжатыхДанных)
    
    // End of central directory
    РазмерCDH = 50;
    Буфер = Новый БуферДвоичныхДанных(ZipРазмерEOCD());
    Буфер.ЗаписатьЦелое32(0, 101010256); // signature 0x06054b50
    Буфер.ЗаписатьЦелое16(4, 0); // number of this disk
    Буфер.ЗаписатьЦелое16(6, 0); // number of the disk with the start of the central directory
    Буфер.ЗаписатьЦелое16(8, 1); // total number of entries in the central directory on this disk
    Буфер.ЗаписатьЦелое16(10, 1); // total number of entries in the central directory
    Буфер.ЗаписатьЦелое32(12, РазмерCDH); // size of the central directory    
    // offset of start of central directory with respect to the starting disk number
    Буфер.ЗаписатьЦелое32(16, ZipРазмерLFH() + РазмерСжатыхДанных + ZipРазмерDD());
    Буфер.ЗаписатьЦелое16(20, 0); // the starting disk number

    Возврат Буфер;

КонецФункции

#КонецОбласти

#КонецОбласти