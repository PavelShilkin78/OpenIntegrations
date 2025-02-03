﻿// OneScript: ./OInt/tools/Classes/OPI_ОбработчикЗапросовПрокси.os

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
// BSLLS:NumberOfOptionalParams-off

//@skip-check module-unused-local-variable
//@skip-check method-too-many-params
//@skip-check module-structure-top-region
//@skip-check module-structure-method-in-regions
//@skip-check wrong-string-literal-content
//@skip-check use-non-recommended-method
//@skip-check module-accessibility-at-client
//@skip-check object-module-export-variable

#Область ОписаниеПеременных

Перем ПутьПроекта Экспорт;
Перем МодульПрокси Экспорт;
Перем ОбъектОПИ Экспорт;

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ОсновнаяОбработка(Контекст, СледующийОбработчик) Экспорт

    #Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

    Попытка
        Результат = ОбработатьЗапрос(Контекст);
    Исключение

        Ошибка = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());

        Контекст.Ответ.КодСостояния = 500;

        Результат = Новый Структура("result,error", Ложь, "Исключение OneScript: " + Ошибка);

    КонецПопытки;

    JSON = OPI_Инструменты.JSONСтрокой(Результат);

    Контекст.Ответ.ТипКонтента = "application/json;charset=UTF8";
    Контекст.Ответ.Записать(JSON);

    #Иначе
    ВызватьИсключение "Метод недоступен на клиенте!";
    #КонецЕсли

КонецПроцедуры

Функция ОбработатьЗапрос(Контекст)

    Путь = Контекст.Запрос.Путь;

    Путь = ?(СтрНачинаетсяС(Путь    , "/")    , Прав(Путь, СтрДлина(Путь) - 1) , Путь);
    Путь = ?(СтрЗаканчиваетсяНа(Путь, "/")    , Лев(Путь , СтрДлина(Путь) - 1) , Путь);

    ОписаниеОбработчика = МодульПрокси.ПолучитьОбработчикЗапросов(ПутьПроекта, Путь);

    Если ОписаниеОбработчика["result"] Тогда

        Обработчик = ОписаниеОбработчика["data"];
        Обработчик = ?(ТипЗнч(Обработчик) = Тип("Массив"), Обработчик[0], Обработчик);

        Результат = ВыполнитьОбработку(Контекст, Обработчик);

    Иначе
        Результат = ОшибкаОбработки(Контекст, 404, "Обработчик не найден!");
    КонецЕсли;

    Возврат Результат;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ВыполнитьОбработку(Контекст, Обработчик)

    Метод            = вРег(Контекст.Запрос.Метод);
    МетодОбработчика = вРег(Обработчик["method"]);
    МетодПроверки    = ?(МетодОбработчика = "MULTIPART", "POST", МетодОбработчика);

    Если Не Метод = МетодПроверки Тогда
        Возврат ОшибкаОбработки(Контекст, 405, "Метод " + Метод + " недоступен для этого обработчика!");
    КонецЕсли;

    Если МетодОбработчика = "GET" Тогда
        
        Результат = ВыполнитьОбработкуGet(Контекст, Обработчик);
        
    ИначеЕсли МетодОбработчика = "POST" Тогда
        
        Результат = ВыполнитьОбработкуPost(Контекст, Обработчик);
        
    Иначе
        
        Результат = ОшибкаОбработки(Контекст, 405, "Метод " + Метод + " недоступен для этого обработчика!");
        
    КонецЕсли;

    Возврат Результат;

КонецФункции

Функция ВыполнитьОбработкуGet(Контекст, Обработчик)

    Запрос    = Контекст.Запрос;
    Параметры = Запрос.Параметры;

    Возврат ВыполнитьУниверсальнуюОбработку(Контекст, Обработчик, Параметры);

КонецФункции

Функция ВыполнитьОбработкуPost(Контекст, Обработчик)
    
    Запрос = Контекст.Запрос;
        
    Тело = Запрос.Тело;
    ЧтениеJSON = Новый ЧтениеJSON();
    ЧтениеJSON.ОткрытьПоток(Тело);

    Параметры = ПрочитатьJSON(ЧтениеJSON, Истина);
    ЧтениеJSON.Закрыть();

    Возврат ВыполнитьУниверсальнуюОбработку(Контекст, Обработчик, Параметры);
        
КонецФункции

Функция ВыполнитьУниверсальнуюОбработку(Контекст, Обработчик, Параметры)

    Аргументы = Обработчик["args"];
    Команда   = Обработчик["library"];
    Метод     = Обработчик["function"];
    
    КотелПараметров     = СформироватьКотелПараметров(Аргументы, Параметры);
    СтруктураВыполнения = ОбъектОПИ.СформироватьСтрокуВызоваМетода(КотелПараметров, Команда, Метод);

    Ответ = Неопределено;

    Если СтруктураВыполнения["Ошибка"] Тогда
        Ответ = Новый Структура("result,error", Ложь, "Ошибка в названии команды или функции обработчика!");
    Иначе

        ТекстВыполнения = СтруктураВыполнения["Результат"];
        УстановитьБезопасныйРежим(Истина);
        Выполнить(ТекстВыполнения);
        УстановитьБезопасныйРежим(Ложь);

        Ответ = Новый Структура("result,data", Истина, Ответ);

    КонецЕсли;

    Возврат Ответ;

КонецФункции

Функция СформироватьКотелПараметров(Аргументы, Параметры)

    АргументыСтрогие   = Новый Соответствие;
    АргументыНестрогие = Новый Соответствие;

    Для Каждого Аргумент Из Аргументы Цикл

        Ключ     = "--" + Аргумент["arg"];
        Значение = Аргумент["value"];
        Значение = ?(СтрНачинаетсяС(Значение    , """"), Прав(Значение, СтрДлина(Значение) - 1), Значение);
        Значение = ?(СтрЗаканчиваетсяНа(Значение, """"), Лев(Значение , СтрДлина(Значение) - 1), Значение);

        Если Аргумент["strict"] = 1 Тогда
            АргументыСтрогие.Вставить(Ключ, Значение);
        Иначе
            АргументыНестрогие.Вставить(Ключ, Значение);
        КонецЕсли;

    КонецЦикла;

    КотелПараметров = АргументыНестрогие;

    Для Каждого Параметр Из Параметры Цикл

        Значение = Параметр.Значение;
        Значение = ?(СтрНачинаетсяС(Значение    , """"), Прав(Значение, СтрДлина(Значение) - 1), Значение);
        Значение = ?(СтрЗаканчиваетсяНа(Значение, """"), Лев(Значение , СтрДлина(Значение) - 1), Значение);

        КотелПараметров.Вставить("--" + Параметр.Ключ, Значение);

    КонецЦикла;

    Для Каждого Аргумент Из АргументыСтрогие Цикл
        КотелПараметров.Вставить(Аргумент.Ключ, Аргумент.Значение);
    КонецЦикла;

    Возврат КотелПараметров;

КонецФункции

Функция ОшибкаОбработки(Контекст, Код, Текст)

    Контекст.Ответ.КодСостояния = Код;

    Возврат Новый Структура("result,error", Ложь, Текст);

КонецФункции

#КонецОбласти
