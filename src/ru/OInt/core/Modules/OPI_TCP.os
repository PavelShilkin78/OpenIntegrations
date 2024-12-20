﻿// OneScript: ./OInt/core/Modules/OPI_TCP.os
// Lib: TCP
// CLI: tcp

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

// Раскомментировать, если выполняется OneScript
#Использовать "../../tools"

#Область ПрограммныйИнтерфейс

#Область МетодыКлиента

// Открыть соединение !NOCLI
// Создает TCP соединение
//
// Параметры:
//  Адрес - Строка - Адрес и порт для подключения - address
//
// Возвращаемое значение:
//  Неопределено, Произвольный -  Возвращает объект TCP клиента при успешном подключении или неопределено
Функция ОткрытьСоединение(Знач Адрес) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Адрес);

    TCPКлиент = OPI_Инструменты.ПолучитьКомпоненту("TCPClient");

    TCPКлиент.Address = Адрес;

    Успех = TCPКлиент.Connect();

    Возврат ?(Успех, TCPКлиент, Неопределено);

КонецФункции

// Закрыть соединение !NOCLI
// Явно закрывает созданное ранее соединение
//
// Параметры:
//  Соединение - Произвольный - Соединение, см. ОткрытьСоединение - tcp
//
// Возвращаемое значение:
//  Булево - всегда возвращает Истина
Функция ЗакрытьСоединение(Знач Соединение) Экспорт

    Возврат Соединение.Disconnect();

КонецФункции

// Прочитать двоичные данные !NOCLI
// Читает данные из указанного соединения
//
// Примечание:
// При работе с бесконечным потоком входящих данных обязательно указание параметра МаксимальныйРазмер, так как^^
// бесконечное получение данных может привести к зависанию
// При закрытии соединения, ошибке или обнаружении EOF чтение завершается в любом случае
//
// Параметры:
//  Соединение          - Произвольный           - Соединение, см. ОткрытьСоединение                      - tcp
//  МаксимальныйРазмер  - Число                  - Максимальный размер данных (байт). 0 > без ограничений - size
//  Маркер              - Строка, ДвоичныеДанные - Маркер конца сообщения. Пусто > без маркера            - marker
//  Таймаут             - Число                  - Таймаут ожидания данных (мс). 0 > без ограничений      - timeout
//
// Возвращаемое значение:
//  ДвоичныеДанные - Полученные данные
Функция ПрочитатьДвоичныеДанные(Знач Соединение
    , Знач МаксимальныйРазмер = 0
    , Знач Маркер = ""
    , Знач Таймаут = 5000) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьЧисло(Таймаут);
    OPI_ПреобразованиеТипов.ПолучитьЧисло(МаксимальныйРазмер);

    Если ТипЗнч(Маркер) = Тип("Строка") Тогда
        Маркер = ПолучитьДвоичныеДанныеИзСтроки(Маркер);
    Иначе
        OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Маркер);
    КонецЕсли;

    Данные = Соединение.Read(МаксимальныйРазмер, Маркер, Таймаут);

    Возврат Данные;

КонецФункции

// Прочитать строку !NOCLI
// Читает данные из указанного соединения в виде строки
//
// Примечание:
// При закрытии соединения, ошибке или обнаружении EOF чтение завершается в любом случае
//
// Параметры:
//  Соединение  - Произвольный            - Соединение, см. ОткрытьСоединение                 - tcp
//  Кодировка   - Строка                  - Кодировка преобразования данных в строку          - enc
//  Маркер      - Строка, ДвоичныеДанные - Маркер конца сообщения. Пусто > без маркера        - marker
//  Таймаут     - Число                   - Таймаут ожидания данных (мс). 0 > без ограничений - timeout
//
// Возвращаемое значение:
//  Строка - Полученные данные в виде строки
Функция ПрочитатьСтроку(Знач Соединение
    , Знач Кодировка = "UTF-8"
    , Знач Маркер = ""
    , Знач Таймаут = 5000) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Кодировка);

    Данные = ПрочитатьДвоичныеДанные(Соединение, , Маркер, Таймаут);
    Данные = ПолучитьСтрокуИзДвоичныхДанных(Данные, Кодировка);

    Возврат Данные;

КонецФункции

// Отправить двоичные данные !NOCLI
// Отправляет двоичные данные через указанное соединение
//
// Параметры:
//  Соединение - Произвольный   - Соединение, см. ОткрытьСоединение                 - tcp
//  Данные     - ДвоичныеДанные - Данные для отправки                               - data
//  Таймаут    - Число          - Таймаут ожидания записи (мс). 0 > без ограничений - timeout
//
// Возвращаемое значение:
//  Булево - Признак успешного выполнения
Функция ОтправитьДвоичныеДанные(Знач Соединение, Знач Данные, Знач Таймаут = 5000) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Данные);
    OPI_ПреобразованиеТипов.ПолучитьЧисло(Таймаут);

    Результат = Соединение.Send(Данные, Таймаут);

    Возврат Результат;

КонецФункции

// Отправить строку !NOCLI
// Отправляет данные в виде строки через указанное соединение
//
// Параметры:
//  Соединение - Произвольный  - Соединение, см. ОткрытьСоединение                  - tcp
//  Данные     - Строка        - Данные для отправки в виде строки                  - data
//  Кодировка  - Строка        - Кодировка для записи исходящей строки в поток      - enc
//  Таймаут    - Число         - Таймаут ожидания записи (мс). 0 > без ограничений  - timeout
//
// Возвращаемое значение:
//  Булево - Признак успешного выполнения
Функция ОтправитьСтроку(Знач Соединение, Знач Данные, Знач Кодировка = "UTF-8", Знач Таймаут = 5000) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Данные);
    OPI_ПреобразованиеТипов.ПолучитьСтроку(Кодировка);

    ДанныеДД = ПолучитьДвоичныеДанныеИзСтроки(Данные, Кодировка);

    Результат = ОтправитьДвоичныеДанные(Соединение, ДанныеДД, Таймаут);

    Возврат Результат;

КонецФункции

// ОбработатьЗапрос
// Отправляет одиночный запрос на указанный адрес и получает ответ, используя стандартные настройки
//
// Параметры:
//  Адрес        - Строка                 - Адрес и порт для подключения        - address
//  Данные       - Строка, ДвоичныеДанные - Данные или текст для отправки       - data
//  ОтветСтрокой - Булево                 - Признак получения ответа как строки - string
//
// Возвращаемое значение:
//  ДвоичныеДанные, Строка - Ответ на запрос
Функция ОбработатьЗапрос(Знач Адрес, Знач Данные = "", Знач ОтветСтрокой = Истина) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Данные, Истина, Ложь);
    OPI_ПреобразованиеТипов.ПолучитьБулево(ОтветСтрокой);

    Соединение = ОткрытьСоединение(Адрес);
    Результат  = ОтправитьДвоичныеДанные(Соединение, Данные);

    Если Результат Тогда

        Ответ = ПрочитатьДвоичныеДанные(Соединение, , Символы.ПС);
        Ответ = ?(ОтветСтрокой, ПолучитьСтрокуИзДвоичныхДанных(Ответ), Ответ);

    Иначе

        Ответ = "OPI: Не удалось отправить сообщение";
        Ответ = ?(ОтветСтрокой, Ответ, ПолучитьДвоичныеДанныеИзСтроки(Ответ));

    КонецЕсли;

    ЗакрытьСоединение(Соединение);

    Возврат Ответ;

КонецФункции

#КонецОбласти

#КонецОбласти
