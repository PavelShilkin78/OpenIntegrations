﻿// OneScript: ./OInt/tools/Modules/internal/Modules/OPI_Инструменты.os

// MIT License

// Copyright (c) 2023-2025 Anton Tsitavets

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
// BSLLS:NumberOfOptionalParams-off

//@skip-check module-unused-local-variable
//@skip-check method-too-many-params
//@skip-check module-structure-top-region
//@skip-check module-structure-method-in-regions
//@skip-check wrong-string-literal-content
//@skip-check use-non-recommended-method

#Область СлужебныйПрограммныйИнтерфейс

#Область РаботаССетью

Процедура ОбработатьОтвет(Ответ, Знач ПолныйОтвет = Ложь) Экспорт

    Если ПолныйОтвет Или ТипЗнч(Ответ) <> Тип("HTTPОтвет") Тогда
        Возврат;
    КонецЕсли;

    ФайлТела = Ответ.ПолучитьИмяФайлаТела();

    Если Не ФайлТела = Неопределено Тогда

        Ответ = ФайлТела;
        Возврат;

    КонецЕсли;

    GZip = "gzip";

    НужнаРаспаковка                                      = Ответ.Заголовки.Получить("Content-Encoding") = GZip
        Или Ответ.Заголовки.Получить("content-encoding") = GZip;

    Если НужнаРаспаковка Тогда
        Ответ = РаспаковатьОтвет(Ответ);
    КонецЕсли;

    Ответ = ?(ТипЗнч(Ответ) = Тип("HTTPОтвет"), Ответ.ПолучитьТелоКакДвоичныеДанные(), Ответ);

    Если ТипЗнч(Ответ) = Тип("ДвоичныеДанные") Тогда

        Если Ответ.Размер() = 0 Тогда

            Ответ = ПолучитьДвоичныеДанныеИзСтроки("{}");

        КонецЕсли;

        Попытка

            Ответ = JsonВСтруктуру(Ответ);

        Исключение
            Возврат;
        КонецПопытки;

    КонецЕсли;

КонецПроцедуры

Функция ПараметрыЗапросаВСтроку(Знач Параметры, Знач ОтдельныеЭлементыМассивов = Ложь, Знач Начало = Истина) Экспорт

    Если Параметры.Количество() = 0 Тогда
        Возврат "";
    КонецЕсли;

    СтрокаПараметров = ?(Начало, "?", "&");

    Для Каждого Параметр Из Параметры Цикл

        ТекущееЗначение = Параметр.Значение;
        ТекущийКлюч     = Параметр.Ключ;

        Если Не ТипЗнч(ТекущееЗначение) = Тип("Массив") Или Не ОтдельныеЭлементыМассивов Тогда

            ЗначениеПараметра = ПреобразоватьПараметрВСтроку(ТекущееЗначение);

            СтрокаПараметров = СтрокаПараметров + Параметр.Ключ + "=" + ЗначениеПараметра + "&";

        Иначе

            ЗначениеПараметра = РазделитьМассивНаПараметрыURL(ТекущийКлюч, ТекущееЗначение);
            СтрокаПараметров  = СтрокаПараметров + ЗначениеПараметра + "&";

        КонецЕсли;

    КонецЦикла;

    СтрокаПараметров = Лев(СтрокаПараметров, СтрДлина(СтрокаПараметров) - 1);

    Возврат СтрокаПараметров;

КонецФункции

Функция ПараметрыЗапросаВСоответствие(Знач СтрокаПараметров) Экспорт

    СоответствиеВозврата = Новый Соответствие;
    КоличествоЧастей     = 2;
    МассивПараметров     = СтрРазделить(СтрокаПараметров, "&", Ложь);

    Для Каждого Параметр Из МассивПараметров Цикл

        МассивКлючЗначение = СтрРазделить(Параметр, "=");

        Если МассивКлючЗначение.Количество() = КоличествоЧастей Тогда
            СоответствиеВозврата.Вставить(МассивКлючЗначение[0], МассивКлючЗначение[1]);
        Иначе
            СоответствиеВозврата.Вставить(МассивКлючЗначение[0], Неопределено);
        КонецЕсли;

    КонецЦикла;

    Возврат СоответствиеВозврата;

КонецФункции

Функция РазбитьURL(Знач URL) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(URL);

    ВернутьУправляющиеПоследовательности(URL);

    ЗащищенноеСоединение = Не СтрНачинаетсяС(URL, "http://");

    URL = СтрЗаменить(URL, "https://", "");
    URL = СтрЗаменить(URL, "http://" , "");

    Если СтрНайти(URL, "/") = 0 Тогда
        Адрес = "";
        Домен = URL;
    Иначе
        Адрес = Прав(URL, СтрДлина(URL) - СтрНайти(URL, "/", НаправлениеПоиска.СНачала) + 1);
        Домен = Лев(URL, СтрНайти(URL, "/", НаправлениеПоиска.СНачала) - 1);
    КонецЕсли;

    Если СтрНайти(Домен, ":") <> 0 Тогда

        ХостПорт = СтрРазделить(Домен, ":");
        Домен    = ХостПорт[0];
        Порт     = ХостПорт[1];

        OPI_ПреобразованиеТипов.ПолучитьЧисло(Порт);

    Иначе

        Порт = ?(ЗащищенноеСоединение, 443, 80);

    КонецЕсли;

    Если ЭтоOneScript() И ЗащищенноеСоединение Тогда
        Сервер = "https://" + Домен;
    Иначе
        Сервер = Домен;
    КонецЕсли;

    СтруктураВозврата = Новый Структура;
    СтруктураВозврата.Вставить("Сервер"    , Сервер);
    СтруктураВозврата.Вставить("Адрес"     , Адрес);
    СтруктураВозврата.Вставить("Защищенное", ЗащищенноеСоединение);
    СтруктураВозврата.Вставить("Порт"      , Порт);
    СтруктураВозврата.Вставить("Домен"     , Домен);

    Возврат СтруктураВозврата;

КонецФункции

Функция ПолучитьДомен(Знач СтрокаПодключения) Экспорт

    Домен = Строка(СтрокаПодключения);

    Если Не нРег(СтрНачинаетсяС(Домен, "http")) И СтрНайти(Домен, "@") <> 0 Тогда

        Части = СтрРазделить(Домен, "@");
        Домен = Части[1];

    КонецЕсли;

    ОкончаниеПротокола = СтрНайти(Домен, "://");

    Если ОкончаниеПротокола > 0 Тогда
        Домен = Прав(Домен, СтрДлина(Домен) - (ОкончаниеПротокола + 2));
    КонецЕсли;

    Если СтрНайти(Домен, ":") <> 0 Тогда

        ХостПорт = СтрРазделить(Домен, ":");
        Домен    = ХостПорт[0];

    КонецЕсли;

    Если СтрНайти(Домен, "/") > 0 Тогда
        Домен = Лев(Домен, СтрНайти(Домен, "/", НаправлениеПоиска.СНачала) - 1);
    КонецЕсли;

    Домен = СтрЗаменить(Домен, "www.", "");

    Возврат Домен;

КонецФункции

#КонецОбласти

#Область JSON

Функция JsonВСтруктуру(Знач Текст, Знач ВСоответствие = Истина) Экспорт

    Если Не ЗначениеЗаполнено(Текст) Тогда
        Возврат "";
    КонецЕсли;

    Текст = ?(ТипЗнч(Текст) = Тип("ДвоичныеДанные"), ПолучитьСтрокуИзДвоичныхДанных(Текст), Текст);

    ЧтениеJSON = Новый ЧтениеJSON;
    ЧтениеJSON.УстановитьСтроку(Текст);

    Данные = ПрочитатьJSON(ЧтениеJSON, ВСоответствие, Неопределено, ФорматДатыJSON.ISO);
    ЧтениеJSON.Закрыть();

    Возврат Данные;

КонецФункции

Функция JSONСтрокой(Знач Данные
    , Знач Экранирование  = "Нет"
    , Знач ПереносСтрок   = Истина
    , Знач ДвойныеКавычки = Истина) Экспорт

    Перенос = ?(ПереносСтрок, ПереносСтрокJSON.Windows, ПереносСтрокJSON.Нет);

    ПараметрыJSON = Новый ПараметрыЗаписиJSON(Перенос
        , " "
        , ДвойныеКавычки
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

Функция ПрочитатьJSONФайл(Знач Путь) Экспорт

    ЧтениеJSON = Новый ЧтениеJSON;
    ЧтениеJSON.ОткрытьФайл(Путь);
    Значения   = ПрочитатьJSON(ЧтениеJSON);

    ЧтениеJSON.Закрыть();

    Возврат Значения;

КонецФункции

#КонецОбласти

#Область XML

Функция ОбработатьXML(XML) Экспорт

    НачалоОбработкиXML(XML);

    ВозвращаемоеЗначение = Новый Соответствие;

    Пока XML.Прочитать() Цикл

        ТипУзла = XML.ТипУзла;

        Если Не ПодходящийТипУзла(ТипУзла) Тогда
            Продолжить;
        КонецЕсли;

        ИмяУзла = XML.Имя;

        СуществующееЗначение = ВозвращаемоеЗначение.Получить(ИмяУзла);

        Если ТипУзла = ТипУзлаXML.НачалоЭлемента Тогда

            Если СуществующееЗначение = Неопределено Тогда
                ВозвращаемоеЗначение.Вставить(ИмяУзла, ОбработатьXML(XML));
            Иначе
                ЗначениеВМассив(СуществующееЗначение);
                СуществующееЗначение.Добавить(ОбработатьXML(XML));
                ВозвращаемоеЗначение.Вставить(ИмяУзла, СуществующееЗначение);
            КонецЕсли;

        Иначе

            Если Не ТипУзла = ТипУзлаXML.КонецЭлемента Тогда
                ВозвращаемоеЗначение = XML.Значение;
                XML.Прочитать();
            КонецЕсли;

            Прервать;

        КонецЕсли;

    КонецЦикла;

    Возврат ВозвращаемоеЗначение;

КонецФункции

Функция ПолучитьXML(Значение, ПространствоИмен = "", ЗаписьXML = Неопределено) Экспорт

    ЭтоВход = НачалоФормированияXML(Значение, ЗаписьXML);

    ТипЗначения = ТипЗнч(Значение);

    Если ТипЗначения = Тип("Структура") Или ТипЗначения = Тип("Соответствие") Тогда

        Для Каждого ЗначениеКоллекции Из Значение Цикл

            ЗаписьXML.ЗаписатьНачалоЭлемента(ЗначениеКоллекции.Ключ, ПространствоИмен);

            Если ЗначениеЗаполнено(ПространствоИмен) Тогда
                ЗаписьXML.ЗаписатьСоответствиеПространстваИмен("", ПространствоИмен);
            КонецЕсли;

            ПолучитьXML(ЗначениеКоллекции.Значение, "", ЗаписьXML);
            ЗаписьXML.ЗаписатьКонецЭлемента();

        КонецЦикла;

    ИначеЕсли ТипЗначения = Тип("Массив") Тогда

        Для Каждого ЭлементМассива Из Значение Цикл
            ПолучитьXML(ЭлементМассива, "", ЗаписьXML);
        КонецЦикла;

    Иначе

        ЗаписьXML.ЗаписатьТекст(ЧислоВСтроку(Значение));

    КонецЕсли;

    Если ЭтоВход Тогда
        Возврат ЗаписьXML.Закрыть();
    Иначе
        Возврат Неопределено;
    КонецЕсли;

КонецФункции

#КонецОбласти

#Область Коллекции

Процедура ДобавитьПоле(Знач Имя, Знач Значение, Знач Тип, Коллекция) Экспорт

    Заполнено = ЗначениеЗаполнено(Значение);

    Если Не Заполнено Тогда
        Возврат;
    КонецЕсли;

    Если Тип = "Дата" Тогда
        OPI_ПреобразованиеТипов.ПолучитьДату(Значение);
        Значение = UNIXTime(Значение);

    ИначеЕсли Тип = "ДатаISO" Тогда
        OPI_ПреобразованиеТипов.ПолучитьДату(Значение);
        Значение = Лев(XMLСтрока(Значение), 19);

    ИначеЕсли Тип = "ДатаISOZ" Тогда
        OPI_ПреобразованиеТипов.ПолучитьДату(Значение);
        Значение = Лев(XMLСтрока(Значение), 19) + "Z";

    ИначеЕсли Тип = "ДатаБезВремени" Тогда
        OPI_ПреобразованиеТипов.ПолучитьДату(Значение);
        Значение = Формат(Значение, "ДФ=yyyy-MM-dd");

    ИначеЕсли Тип = "Коллекция" Тогда
        OPI_ПреобразованиеТипов.ПолучитьКоллекцию(Значение);

    ИначеЕсли Тип = "Булево" Тогда
        OPI_ПреобразованиеТипов.ПолучитьБулево(Значение);

    ИначеЕсли Тип = "СтрокаФайла" Тогда
        OPI_ПреобразованиеТипов.ПолучитьСтроку(Значение, Истина);

    ИначеЕсли Тип = "Массив" Тогда
        OPI_ПреобразованиеТипов.ПолучитьМассив(Значение);

    ИначеЕсли Тип = "ДвоичныеДанные" Тогда
        OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Значение);

    ИначеЕсли Тип = "Число" Тогда
        OPI_ПреобразованиеТипов.ПолучитьЧисло(Значение);

    ИначеЕсли Тип = "УникальныйИдентификатор" Тогда

        OPI_ПреобразованиеТипов.ПолучитьСтроку(Значение);
        Значение = Новый УникальныйИдентификатор(Значение);

    Иначе

        Если Не Тип = "Текущий" Тогда
            OPI_ПреобразованиеТипов.ПолучитьСтроку(Значение);
        КонецЕсли;

    КонецЕсли;

    Коллекция.Вставить(Имя, Значение);

КонецПроцедуры

Процедура ДобавитьКлючЗначение(Таблица, Знач Ключ, Знач Значение) Экспорт

    ЕстьКлюч     = Ложь;
    ЕстьЗначение = Ложь;

    Для Каждого Колонка Из Таблица.Колонки Цикл

        Если Колонка.Имя = "Ключ" Тогда

            ЕстьКлюч = Истина;

        ИначеЕсли Колонка.Имя = "Значение" Тогда

            ЕстьЗначение = Истина;

        Иначе
            Продолжить;
        КонецЕсли;

    КонецЦикла;

    Если Не ЕстьКлюч Тогда
        Таблица.Колонки.Добавить("Ключ");
    КонецЕсли;

    Если Не ЕстьЗначение Тогда
        Таблица.Колонки.Добавить("Значение");
    КонецЕсли;

    НовоеЗначение          = Таблица.Добавить();
    НовоеЗначение.Ключ     = Ключ;
    НовоеЗначение.Значение = Значение;

КонецПроцедуры

Процедура УдалитьПустыеПоляКоллекции(Коллекция) Экспорт

    ТипКоллекции      = ТипЗнч(Коллекция);
    ВыходнаяКоллекция = Новый (ТипКоллекции);

    Если ТипКоллекции = Тип("Соответствие") Или ТипКоллекции = Тип("Структура") Тогда

        УдалитьПустыеКлючиЗначения(Коллекция, ВыходнаяКоллекция);

    ИначеЕсли ТипКоллекции = Тип("Массив") Тогда

        УдалитьПустыеЭлементыМассива(Коллекция, ВыходнаяКоллекция);

    Иначе

        ВыходнаяКоллекция = Коллекция;

    КонецЕсли;

    Коллекция = ВыходнаяКоллекция;

КонецПроцедуры

Процедура ЗначениеВМассив(Значение) Экспорт

    Если ТипЗнч(Значение) = Тип("Массив") Тогда
        Возврат;
    КонецЕсли;

    Значение_ = Новый Массив;
    Значение_.Добавить(Значение);
    Значение  = Значение_;

КонецПроцедуры

Функция ПолеКоллекцииСуществует(Знач Коллекция, Знач Поле, ЗначениеПоля = Неопределено) Экспорт

    ТипКоллекции = ТипЗнч(Коллекция);

    ЭтоСтруктура    = ТипКоллекции = Тип("Структура");
    ЭтоСоответствие = ТипКоллекции = Тип("Соответствие");
    ЭтоКоллекция    = ЭтоСтруктура Или ЭтоСоответствие;

    Если СтрНайти(Поле, ".") И ЭтоКоллекция Тогда

        ЧастиПоля   = СтрРазделить(Поле, ".");
        ТекущееПоле = ЧастиПоля[0];

        Если Не ПолеКоллекцииСуществует(Коллекция, ТекущееПоле, ЗначениеПоля) Тогда

            Возврат Ложь;

        Иначе

            ЧастиПоля.Удалить(0);
            СледующаяКоллекция = Коллекция[ТекущееПоле];
            СледующееПоле      = СтрСоединить(ЧастиПоля, ".");

            Возврат ПолеКоллекцииСуществует(СледующаяКоллекция, СледующееПоле, ЗначениеПоля);

        КонецЕсли;

    ИначеЕсли ЭтоСтруктура Тогда

        Возврат Коллекция.Свойство(Поле, ЗначениеПоля);

    ИначеЕсли ЭтоСоответствие Тогда

        ЗначениеПоля = Коллекция[Поле];
        Возврат ЗначениеПоля <> Неопределено;

    Иначе

        Возврат Ложь;

    КонецЕсли;

КонецФункции

Функция НайтиОтсутствующиеПоляКоллекции(Знач Коллекция, Знач Поля) Экспорт

    МассивОтсутствующихПолей = Новый Массив;

    Для Каждого Поле Из Поля Цикл

        Существует = ПолеКоллекцииСуществует(Коллекция, Поле);

        Если Не Существует Тогда
            МассивОтсутствующихПолей.Добавить(Поле);
        КонецЕсли;

    КонецЦикла;

    Возврат МассивОтсутствующихПолей;

КонецФункции

Функция ОчиститьКоллекциюРекурсивно(Знач Коллекция) Экспорт

    ТипЗначения = ТипЗнч(Коллекция);

    Если ТипЗначения = Тип("Структура") Тогда

        Для Каждого ЭлементКоллекции Из Коллекция Цикл

            ОчищенноеПоле = ОчиститьКоллекциюРекурсивно(ЭлементКоллекции.Значение);

            Коллекция[ЭлементКоллекции.Ключ] = ОчищенноеПоле;

        КонецЦикла;

    ИначеЕсли ТипЗначения = Тип("Соответствие") Тогда

        Коллекция_ = Новый Соответствие;

        Для Каждого ЭлементКоллекции Из Коллекция Цикл

            ОчищенноеПоле = ОчиститьКоллекциюРекурсивно(ЭлементКоллекции.Значение);

            Коллекция_.Вставить(ЭлементКоллекции.Ключ, ОчищенноеПоле);

        КонецЦикла;

        Коллекция = Коллекция_;

    ИначеЕсли ТипЗначения = Тип("Массив") Тогда

        Коллекция_ = Новый Массив;

        Для Каждого ЭлементКоллекции Из Коллекция Цикл

            ОчищенноеПоле = ОчиститьКоллекциюРекурсивно(ЭлементКоллекции);
            Коллекция_.Добавить(ОчищенноеПоле);

        КонецЦикла;

        Коллекция = Коллекция_;

    Иначе

        Коллекция = "";

    КонецЕсли;

    Возврат Коллекция;

КонецФункции

Функция КопироватьКоллекцию(Знач Коллекция) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьКоллекцию(Коллекция);

    ТипКоллекции    = ТипЗнч(Коллекция);
    ЭтоСтруктура    = ТипКоллекции = Тип("Структура");
    ЭтоСоответствие = ТипКоллекции = Тип("Соответствие");
    ЭтоМассив       = ТипКоллекции = Тип("Массив");

    Если ЭтоСтруктура Или ЭтоСоответствие Тогда

        Коллекция_ = ?(ЭтоСтруктура, Новый Структура, Новый Соответствие);

        Для Каждого ПолеКоллекции Из Коллекция Цикл
            Коллекция_.Вставить(ПолеКоллекции.Ключ, ПолеКоллекции.Значение);
        КонецЦикла;

    ИначеЕсли ЭтоМассив Тогда

        Коллекция_ = Новый Массив;

        Для Каждого ЭлементКоллекции Из Коллекция Цикл
            Коллекция_.Добавить(ЭлементКоллекции);
        КонецЦикла;

    Иначе

        Коллекция_ = Коллекция;

    КонецЕсли;

    Возврат Коллекция_;

КонецФункции

Функция ПолучитьИли(Знач Коллекция, Знач Поле, Знач ЗначениеИначе) Экспорт

    ЗначениеПоля = Неопределено;
    Существует   = ПолеКоллекцииСуществует(Коллекция, Поле, ЗначениеПоля);

    Если Не Существует Тогда
        ЗначениеПоля = ЗначениеИначе;
    КонецЕсли;

    Возврат ЗначениеПоля;

КонецФункции

#КонецОбласти

#Область OneScript

Функция ЭтоOneScript() Экспорт

    Попытка

        Ответ = Ложь;

        // BSLLS:UnusedLocalVariable-off

        //@skip-check module-unused-local-variable
        Проверка = Новый ЗащищенноеСоединениеOpenSSL;

        // BSLLS:UnusedLocalVariable-on

    Исключение

        Ответ = Истина;

    КонецПопытки;

    Возврат Ответ;

КонецФункции

Процедура ИнформацияОПрогрессе(Знач Текущее, Знач Всего, Знач ЕдИзм, Знач Делитель = 1) Экспорт

    Если Не ЭтоOneScript() Тогда
        Возврат;
    КонецЕсли;

    Целое   = 100;
    Текущее = Окр(Текущее / Делитель, 2);
    Всего   = Окр(Всего / Делитель, 2);
    Процент = Цел(Текущее / Всего * Целое);

    СтрТекущее = ЧислоВСтроку(Текущее);
    СтрВсего   = ЧислоВСтроку(Всего);
    СтрПроцент = ЧислоВСтроку(Процент);

    Прогресс   = "Прогресс [" + СтрПроцент + "%" + "] ▐";
    Информация = "▌ " + СтрТекущее + "/" + СтрВсего + " " + ЕдИзм;

    // Прогресс бар
    ДлинаПолоски = 30;
    Счетчик      = 0;
    Буфер        = "";

    Показатель = Цел(Текущее / Всего * ДлинаПолоски);

    Пока Счетчик < ДлинаПолоски Цикл
        Буфер   = Буфер + ?(Счетчик < Показатель, "█", " ");
        Счетчик = Счетчик + 1;
    КонецЦикла;

    ВывестиТекстВТекущуюСтроку(Прогресс, , Истина);
    ВывестиТекстВТекущуюСтроку(Буфер   , "Зеленый");
    ВывестиТекстВТекущуюСтроку(Информация);

    Если Процент = Целое Тогда
        ВывестиТекстВТекущуюСтроку(Символы.ПС, , Истина);
    КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область Служебные

Процедура ЗаменитьСпецСимволы(Текст, Разметка = "Markdown") Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Разметка);

    СоответствиеСимволов = Новый Соответствие;

    Если Разметка = "HTML" Тогда

        СоответствиеСимволов.Вставить("&", "&amp;");

    ИначеЕсли Разметка = "MarkdownV2" Тогда

        СоответствиеСимволов.Вставить("-", "\-");
        СоответствиеСимволов.Вставить("+", "\+");
        СоответствиеСимволов.Вставить("#", "\#");
        СоответствиеСимволов.Вставить("=", "\=");
        СоответствиеСимволов.Вставить("{", "\{");
        СоответствиеСимволов.Вставить("}", "\}");
        СоответствиеСимволов.Вставить(".", "\.");

    Иначе
        Возврат;
    КонецЕсли;

    Для Каждого СимволМассива Из СоответствиеСимволов Цикл
        Текст = СтрЗаменить(Текст, СимволМассива.Ключ, СимволМассива.Значение);
    КонецЦикла;

КонецПроцедуры

Процедура Пауза(Знач Секунды) Экспорт

    Соединение = Новый HTTPСоединение("1C.ru", 11111, , , , Секунды);
    Попытка
        Соединение.Получить(Новый HTTPЗапрос(""));
    Исключение
        Возврат;
    КонецПопытки;

КонецПроцедуры

Процедура ЗаменитьУправляющиеПоследовательности(Текст) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Текст);

    СоответствиеСимволов = ПолучитьСоответствиеУправляющихПоследовательностей();

    Для Каждого Символ Из СоответствиеСимволов Цикл

        Текст = СтрЗаменить(Текст, Символ.Ключ          , Символ.Значение);
        Текст = СтрЗаменить(Текст, "\" + Символ.Значение, Символ.Ключ);

    КонецЦикла;

КонецПроцедуры

Процедура ВернутьУправляющиеПоследовательности(Текст) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Текст);

    СоответствиеСимволов = ПолучитьСоответствиеУправляющихПоследовательностей();

    Для Каждого Символ Из СоответствиеСимволов Цикл

        Текст = СтрЗаменить(Текст, Символ.Значение, Символ.Ключ);

    КонецЦикла;

КонецПроцедуры

Функция ЧислоВСтроку(Знач Значение) Экспорт

    Если ТипЗнч(Значение) = Тип("Число") Тогда

        Если Значение = 0 Тогда
            Значение_ = "0";
        Иначе
            Значение_ = Формат(Значение, "ЧГ=0");
        КонецЕсли;

    Иначе
        Значение_ = Строка(Значение);
    КонецЕсли;

    Возврат Значение_;

КонецФункции

Функция ПолучитьТекущуюДату() Экспорт
    Возврат МестноеВремя(ТекущаяУниверсальнаяДата());
КонецФункции

Функция UNIXTime(Знач Дата) Экспорт

    ОТД  = Новый ОписаниеТипов("Дата");
    Дата = ОТД.ПривестиЗначение(Дата);

    UNIX = Формат(Дата - Дата(1970, 1, 1, 1, 0, 0), "ЧЦ=10; ЧДЦ=0; ЧГ=0");
    UNIX = СтрЗаменить(UNIX, ","        , "");
    UNIX = СтрЗаменить(UNIX, Символы.НПП, "");
    UNIX = СтрЗаменить(UNIX, " "        , "");
    UNIX = Лев(UNIX, 10);

    Возврат UNIX;

КонецФункции

Функция ДатаRFC3339(Знач Дата, Знач Смещение = "Z") Экспорт

    OPI_ПреобразованиеТипов.ПолучитьДату(Дата);
    OPI_ПреобразованиеТипов.ПолучитьСтроку(Смещение);

    Возврат XMLСтрока(Дата) + Смещение;

КонецФункции

Функция ПреобразоватьДанныеСПолучениемРазмера(Данные, Знач МинимальныйРазмерДляПотока = 0) Экспорт

    Размер = 0;

    Если ТипЗнч(Данные) = Тип("Строка") Тогда

        ФайлНаДиске = Новый Файл(Данные);

        Если ФайлНаДиске.Существует() Тогда
            Размер = ФайлНаДиске.Размер();
        Иначе
            OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Данные);
            Размер = Данные.Размер();
        КонецЕсли;

    Иначе
        OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Данные);
        Размер = Данные.Размер();
    КонецЕсли;

    Если ЗначениеЗаполнено(МинимальныйРазмерДляПотока) Тогда
        Если Размер < МинимальныйРазмерДляПотока Тогда
            OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Данные);
        Иначе
            OPI_ПреобразованиеТипов.ПолучитьДвоичныеИлиПоток(Данные);
        КонецЕсли;
    Иначе
        OPI_ПреобразованиеТипов.ПолучитьДвоичныеИлиПоток(Данные);
    КонецЕсли;

    Возврат Размер;

КонецФункции

Функция ВременнаяМеткаISO(Знач Дата) Экспорт

    Метка = Лев(XMLСтрока(Дата), 19) + "Z";
    Метка = СтрЗаменить(Метка, "-", "");
    Метка = СтрЗаменить(Метка, ":", "");

    Возврат Метка;

КонецФункции

Функция СоздатьПоток(Знач ПутьКФайлу = Неопределено) Экспорт

    Если ЗначениеЗаполнено(ПутьКФайлу) Тогда
        ПотокФайла = Новый ФайловыйПоток(ПутьКФайлу, РежимОткрытияФайла.Создать);
    Иначе
        ПотокФайла = Новый ПотокВПамяти();
    КонецЕсли;

    Возврат ПотокФайла;

КонецФункции

Функция ЭтоWindows() Экспорт

    СистемнаяИнформация = Новый СистемнаяИнформация;
    ОперационнаяСистема = Строка(СистемнаяИнформация.ТипПлатформы);

    Ответ = СтрНайти(нРег(ОперационнаяСистема), "windows") > 0;

    Возврат Ответ;

КонецФункции

Функция СклеитьДанные(Знач Данные, Знач Дополнение) Экспорт

    Поток  = Новый ПотокВПамяти();
    Запись = Новый ЗаписьДанных(Поток);

    Запись.Записать(Данные);
    Запись.Записать(Дополнение);

    Запись.Закрыть();

    Результат = Поток.ЗакрытьИПолучитьДвоичныеДанные();

    Возврат Результат;

КонецФункции

Функция ЭтоПримитивныйТип(Знач Значение) Экспорт

    ТипЗначения = ТипЗнч(Значение);

    Возврат ТипЗначения = Тип("Строка")
        Или ТипЗначения = Тип("Число")
        Или ТипЗначения = Тип("Булево");

КонецФункции

Функция ЭтоКоллекция(Знач Значение, Знач КлючЗначение = Ложь) Экспорт

    ТипЗначения = ТипЗнч(Значение);

    Возврат (ТипЗначения = Тип("Массив") И Не КлючЗначение)
        Или ТипЗначения  = Тип("Структура")
        Или ТипЗначения  = Тип("Соответствие");

КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура УдалитьПустыеКлючиЗначения(Знач Коллекция, ВыходнаяКоллекция)

    Для Каждого ЭлементКоллекции Из Коллекция Цикл

        Если Не ЭлементКоллекции.Значение = Неопределено И Не ЭлементКоллекции.Значение = Null Тогда
            ВыходнаяКоллекция.Вставить(ЭлементКоллекции.Ключ, ЭлементКоллекции.Значение);
        КонецЕсли;

    КонецЦикла;

КонецПроцедуры

Процедура УдалитьПустыеЭлементыМассива(Знач Коллекция, ВыходнаяКоллекция)

    Для Каждого ЭлементКоллекции Из Коллекция Цикл

        Если Не ЭлементКоллекции = Неопределено И Не ЭлементКоллекции = Null Тогда
            ВыходнаяКоллекция.Добавить(ЭлементКоллекции);
        КонецЕсли;

    КонецЦикла;

КонецПроцедуры

Процедура НачалоОбработкиXML(XML)

    Если Не ТипЗнч(XML) = Тип("ЧтениеXML") Тогда
        XML_ = XML;
        XML  = Новый ЧтениеXML;
        XML.УстановитьСтроку(XML_);
    КонецЕсли;

КонецПроцедуры

Процедура ВывестиТекстВТекущуюСтроку(Знач Текст, Знач Цвет = "", Знач ВНачало = Ложь) Экспорт

    Если Не ЭтоOneScript() Тогда
        Консоль     = Неопределено;
        ЦветКонсоли = Новый Соответствие;
    КонецЕсли;

    Кодировка    = Консоль.КодировкаВыходногоПотока;
    ПотокВывода  = Консоль.ОткрытьСтандартныйПотокВывода();
    ЗаписьВывода = Новый ЗаписьДанных(ПотокВывода, Кодировка);

    Если Не ЗначениеЗаполнено(Цвет) Тогда
        Цвет = ЦветКонсоли.Белый;
    КонецЕсли;

    Если ТипЗнч(Цвет) = Тип("Строка") Тогда
        Консоль.ЦветТекста = ЦветКонсоли[Цвет];
    Иначе
        Консоль.ЦветТекста = Цвет;
    КонецЕсли;

    Если ВНачало Тогда
        Ескейп = Символы.ВК;
        ЗаписьВывода.ЗаписатьСимволы(Ескейп);
    КонецЕсли;

    ЗаписьВывода.ЗаписатьСимволы(Текст);

КонецПроцедуры

Функция ЭтоПереадресация(Знач Ответ)

    Переадресация = 300;
    Ошибка        = 400;

    ЭтоПереадресация = Ответ.КодСостояния >= Переадресация И Ответ.КодСостояния < Ошибка И ЗначениеЗаполнено(
        Ответ.Заголовки["Location"]);

    Возврат ЭтоПереадресация;

КонецФункции

Функция ПреобразоватьПараметрВСтроку(Знач Значение)

    Если ТипЗнч(Значение) = Тип("Массив") Тогда

        Для Н = 0 По Значение.ВГраница() Цикл
            Значение[Н] = ПреобразоватьПараметрВСтроку(Значение[Н]);
        КонецЦикла;

        Значение = СтрСоединить(Значение, ",");
        Значение = КодироватьСтроку(Значение, СпособКодированияСтроки.URLВКодировкеURL);
        Значение = "[" + Значение + "]";

    ИначеЕсли ТипЗнч(Значение) = Тип("Соответствие") Или ТипЗнч(Значение) = Тип("Структура") Тогда

        ПараметрыJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет, "");

        ЗаписьJSON = Новый ЗаписьJSON;
        ЗаписьJSON.УстановитьСтроку(ПараметрыJSON);

        ЗаписатьJSON(ЗаписьJSON, Значение);
        Значение = ЗаписьJSON.Закрыть();

    ИначеЕсли ТипЗнч(Значение) = Тип("Булево") Тогда

        Значение = ?(Значение, "true", "false");

    Иначе

        Значение = ЧислоВСтроку(Значение);
        Значение = КодироватьСтроку(Значение, СпособКодированияСтроки.URLВКодировкеURL);

    КонецЕсли;

    Возврат Значение;

КонецФункции

Функция РазделитьМассивНаПараметрыURL(Знач Ключ, Знач Значение)

    КлючМассив = Ключ + "=";

    Для Н = 0 По Значение.ВГраница() Цикл

        ТекущееЗначение = Значение[Н];

        OPI_ПреобразованиеТипов.ПолучитьСтроку(ТекущееЗначение);

        Значение.Установить(Н, КлючМассив + ТекущееЗначение);

    КонецЦикла;

    ПараметрСтрокой = СтрСоединить(Значение, "&");

    Возврат ПараметрСтрокой;

КонецФункции

Функция НачалоФормированияXML(Значение, ЗаписьXML)

    ЭтоВход = Ложь;

    Если ЗаписьXML = Неопределено Тогда

        ТекстОшибки = "Ошибка получения коллекции для формирования XML";
        OPI_ПреобразованиеТипов.ПолучитьКоллекциюКлючИЗначение(Значение, ТекстОшибки);

        ЗаписьXML = Новый ЗаписьXML;
        ЗаписьXML.УстановитьСтроку();
        ЗаписьXML.ЗаписатьОбъявлениеXML();

        ЭтоВход = Истина;

    КонецЕсли;

    Возврат ЭтоВход;

КонецФункции

Функция ПодходящийТипУзла(Знач ТипУзла)

    Возврат ТипУзла = ТипУзлаXML.НачалоЭлемента Или ТипУзла = ТипУзлаXML.КонецЭлемента Или ТипУзла = ТипУзлаXML.Текст;

КонецФункции

Функция ПолучитьСоответствиеУправляющихПоследовательностей()

    СоответствиеСимволов = Новый Соответствие;

    СоответствиеСимволов.Вставить("\n", Символы.ПС);
    СоответствиеСимволов.Вставить("\r", Символы.ВК);
    СоответствиеСимволов.Вставить("\f", Символы.ПФ);
    СоответствиеСимволов.Вставить("\v", Символы.ВТаб);

    Возврат СоответствиеСимволов;

КонецФункции

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

    ЧтениеДанных       = Новый ЧтениеДанных(СжатыеДанные);
    ЧтениеДанных.Пропустить(РазмерПрефиксаGZip);
    РазмерСжатыхДанных = ЧтениеДанных.ИсходныйПоток().Размер() - РазмерПрефиксаGZip - РазмерПостфиксаGZip;

    ПотокZip = Новый ПотокВПамяти(РазмерЛФХ + РазмерСжатыхДанных + РазмерДД + РазмерСДХ + РазмерЕСД);

    ЗаписьДанных = Новый ЗаписьДанных(ПотокZip);
    ЗаписьДанных.ЗаписатьБуферДвоичныхДанных(ZipLFH());
    ЧтениеДанных.КопироватьВ(ЗаписьДанных, РазмерСжатыхДанных);

    ЗаписьДанных.Закрыть();
    ЗаписьДанных = Новый ЗаписьДанных(ПотокZip);

    CRC32                = ЧтениеДанных.ПрочитатьЦелое32();
    РазмерНесжатыхДанных = ЧтениеДанных.ПрочитатьЦелое32();
    ЧтениеДанных.Закрыть();

    ЗаписьДанных.ЗаписатьБуферДвоичныхДанных(ZipDD(CRC32 , РазмерСжатыхДанных, РазмерНесжатыхДанных));
    ЗаписьДанных.ЗаписатьБуферДвоичныхДанных(ZipCDH(CRC32, РазмерСжатыхДанных, РазмерНесжатыхДанных));
    ЗаписьДанных.ЗаписатьБуферДвоичныхДанных(ZipEOCD(РазмерСжатыхДанных));
    ЗаписьДанных.Закрыть();

    Возврат ПрочитатьZip(ПотокZip);

КонецФункции

Функция ПрочитатьZip(СжатыеДанные, ТекстОшибки = Неопределено)

    Каталог         = ПолучитьИмяВременногоФайла();
    ЧтениеZip       = Новый ЧтениеZipФайла(СжатыеДанные);
    ИмяФайла        = ЧтениеZip.Элементы[0].Имя;
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
