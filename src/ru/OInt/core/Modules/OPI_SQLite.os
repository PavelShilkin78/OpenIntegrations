﻿// OneScript: ./OInt/core/Modules/OPI_SQLite.os
// Lib: SQLite
// CLI: sqlite

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

//@skip-check module-structure-top-region
//@skip-check module-structure-method-in-regions
//@skip-check wrong-string-literal-content
//@skip-check method-too-many-params
//@skip-check constructor-function-return-section

// Раскомментировать, если выполняется OneScript
#Использовать "../../tools"
#Область ПрограммныйИнтерфейс

#Область ОсновныеМетоды

// Создать подключение !NOCLI
// Создает подключение к указанной базе
//
// Параметры:
//  База - Строка - Путь к базе. In memory, если не заполнено - db
//
// Возвращаемое значение:
//  Произвольный - Объект коннектора или структура с информацией об ошибке
Функция СоздатьПодключение(Знач База = "") Экспорт

    Если ЭтоКоннектор(База) Тогда
        Возврат База;
    КонецЕсли;

    OPI_ПреобразованиеТипов.ПолучитьСтроку(База);

    Коннектор = ПодключитьКомпонентуНаСервере("OPI_SQLite");

    Коннектор.Database = База;

    Результат = Коннектор.Connect();
    Результат = OPI_Инструменты.JsonВСтруктуру(Результат, Ложь);

    Возврат ?(Результат["result"], Коннектор, Результат);

КонецФункции

// Закрыть подключение !NOCLI
// Явно закрывает переданное соединение
// 
// Параметры:
//  Соединение - Произвольный - Объект компоненты с открытым соединением - db
// 
// Возвращаемое значение:
//  Структура Из КлючИЗначение - Результат закрытия соединения 
Функция ЗакрытьПодключение(Знач Соединение) Экспорт
    
    Если ЭтоКоннектор(Соединение) Тогда
        
        Результат = Соединение.Close();
        Результат = OPI_Инструменты.JsonВСтруктуру(Результат, Ложь);
        
    Иначе
        
        Результат = Новый Структура("result,error", Ложь, "It's not a connection");
        
    КонецЕсли;
    
    Возврат Результат;
            
КонецФункции

// Выполнить запрос SQL
// Выполняет произвольный SQL запрос
//
// Примечание:
// Доступные типы параметров: Cтрока, Число, Дата, Булево, ДвоичныеДанные
// Без указания флага `ФорсироватьРезультат`, чтение результата осуществляется только для запросов, начинающихся с `SELECT`^^
// Для остальных запросов возвращается result:true или false с текстом ошибки
//
// Параметры:
//  ТекстЗапроса         - Строка                 - Текст запроса к базе                                                  - sql
//  Параметры            - Массив Из Произвольный - Массив позиционных параметров запроса                                 - params
//  ФорсироватьРезультат - Булево                 - Включает попытку получения результата, даже для не SELECT запросов    - force
//  Соединение           - Строка, Произвольный   - Существующее соединение или путь к базе. In memory, если не заполнено - db
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение - Результат выполнения запроса
Функция ВыполнитьЗапросSQL(Знач ТекстЗапроса
    , Знач Параметры = ""
    , Знач ФорсироватьРезультат = Ложь
    , Знач Соединение = "") Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(ТекстЗапроса);

    Параметры_ = ОбработатьПараметры(Параметры);
    Коннектор  = СоздатьПодключение(Соединение);

    Если ТипЗнч(Коннектор) <> Тип("AddIn.OPI_SQLite.Main") Тогда
        Возврат Коннектор;
    КонецЕсли;

    Результат = Коннектор.Execute(ТекстЗапроса, Параметры_, ФорсироватьРезультат);
    Результат = OPI_Инструменты.JsonВСтруктуру(Результат, Ложь);

    Возврат Результат;

КонецФункции

#КонецОбласти

#Область ORM

// Создать таблицу
// Создает пустую таблицу в базе
//
// Параметры:
//  Таблица          - Строка                     - Имя таблицы                                          - table
//  СтруктураКолонок - Структура Из КлючИЗначение - Структура колонок: Ключ > имя, Значение > Тип данных - cols
//  НеВыполнять      - Булево                     - Истина > Не выполняет запрос, а возвращает текст SQL - noex
//  Соединение       - Строка                     - Существующее соединение или путь к базе              - db
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение, Строка - Результат выполнения запроса или его текст
Функция СоздатьТаблицу(Знач Таблица, Знач СтруктураКолонок, Знач НеВыполнять = Ложь, Знач Соединение = "") Экспорт

    OPI_ПреобразованиеТипов.ПолучитьБулево(НеВыполнять);

    ТекстОшибки = "Структура колонок не является валидной структурой ключ-значение";
    OPI_ПреобразованиеТипов.ПолучитьКоллекциюКлючИЗначение(СтруктураКолонок, ТекстОшибки);

    Схема = OPI_ЗапросыSQL.ПустаяСхемаSQL("CREATE");

    OPI_ЗапросыSQL.УстановитьИмяТаблицы(Схема, Таблица);

    Для Каждого Колонка Из СтруктураКолонок Цикл
        OPI_ЗапросыSQL.ДобавитьКолонку(Схема, Колонка.Ключ, Колонка.Значение);
    КонецЦикла;

    Запрос = OPI_ЗапросыSQL.СформироватьТекстSQL(Схема);

    Если НеВыполнять Тогда
        Результат = Запрос;
    Иначе
        Результат = ВыполнитьЗапросSQL(Запрос, , , Соединение);
    КонецЕсли;

    Возврат Результат;

КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

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

Функция ОбработатьПараметры(Знач Параметры)

    Если ЗначениеЗаполнено(Параметры) Тогда

        OPI_ПреобразованиеТипов.ПолучитьМассив(Параметры);

        Для Н = 0 По Параметры.ВГраница() Цикл

            ТекущийПараметр = Параметры[Н];

            Если ТипЗнч(ТекущийПараметр) = Тип("ДвоичныеДанные") Тогда

                ТекущийПараметр = Новый Структура("blob", Base64Строка(ТекущийПараметр));

            ИначеЕсли OPI_Инструменты.ПолеКоллекцииСуществует(ТекущийПараметр, "blob") Тогда

                ЗначениеДанных = ТекущийПараметр["blob"];
                ФайлДанных     = Новый Файл(Строка(ЗначениеДанных));

                Если ФайлДанных.Существует() Тогда
                    ТекущиеДанные   = Новый ДвоичныеДанные(Строка(ЗначениеДанных));
                    ТекущийПараметр = Новый Структура("blob", Base64Строка(ТекущиеДанные));
                КонецЕсли;

            ИначеЕсли ТипЗнч(ТекущийПараметр) = Тип("Дата") Тогда

                ТекущийПараметр = Формат(ТекущийПараметр, "ДФ='yyyy-MM-dd HH:MM:ss'");

            ИначеЕсли Не OPI_Инструменты.ЭтоПримитивныйТип(ТекущийПараметр) Тогда

                OPI_ПреобразованиеТипов.ПолучитьСтроку(ТекущийПараметр);

            КонецЕсли;

            Параметры[Н] = ТекущийПараметр;

        КонецЦикла;

        Параметры_ = OPI_Инструменты.JSONСтрокой(Параметры, , Ложь);

    Иначе

        Параметры_ = "[]";

    КонецЕсли;

    Возврат Параметры_;

КонецФункции

Функция ЭтоКоннектор(Знач Значение)

    Возврат Строка(ТипЗнч(Значение)) = "AddIn.OPI_SQLite.Main";
        
КонецФункции

#КонецОбласти
