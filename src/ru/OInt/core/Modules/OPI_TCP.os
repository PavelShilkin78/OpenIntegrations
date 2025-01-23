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

    TCPКлиент = ПодключитьКомпонентуНаСервере("OPI_TCPClient");

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

	Если ТипЗнч(Соединение) = Тип("Строка") Тогда
		Соединение = ОткрытьСоединение(Соединение);
	КонецЕсли;

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

	Если ТипЗнч(Соединение) = Тип("Строка") Тогда
		Соединение = ОткрытьСоединение(Соединение);
	КонецЕсли;
	
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

// Обработать запрос
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

#Область МетодыСервера

// Создать сервер !NOCLI
// Создает новый TCP сервер и устаналивает порт
//
// Параметры:
//  Порт      - Число  - Номер свободного порта для сервера         - port
//  Запустить - Булево - Истина > сразу запускает созданный сервер  - start
//
// Возвращаемое значение:
//  Произвольный -  Возвращает объект запущенного TCP сервера при успешном создании или структуру с описанием ошибки
Функция СоздатьСервер(Знач Порт, Запустить = Ложь) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьЧисло(Порт);
    OPI_ПреобразованиеТипов.ПолучитьБулево(Запустить);

    TCPСервер      = ПодключитьКомпонентуНаСервере("OPI_TCPServer", "Server");
    TCPСервер.Port = Порт;

    Если Запустить Тогда
        Результат = ЗапуститьСервер(TCPСервер);

        Успех       = Неопределено;
        ЕстьПризнак = OPI_Инструменты.ПолеКоллекцииСуществует(Результат, "result", Успех);
        Успех       = ?(ЕстьПризнак, Успех, Ложь);

        Возврат ?(Успех, TCPСервер, Результат);

    Иначе
        Возврат TCPСервер;
    КонецЕсли;

КонецФункции

// Запустить сервер !NOCLI
// Запускает ранее созданный сервер
//
// Параметры:
//  TCPСервер - Произвольный - TCP сервер. См. СоздатьСервер - srv
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение - Структура с информацией об успешности запуска
Функция ЗапуститьСервер(Знач TCPСервер) Экспорт

    Если Не ЭтоСервер(TCPСервер) Тогда
        ВызватьИсключение "Переданное значение не является TCP-сервером!";
    КонецЕсли;

    Результат = TCPСервер.Start();

    ОбработатьРезультат(Результат);

    //@skip-check constructor-function-return-section
    Возврат Результат;

КонецФункции

// Отключить сервер !NOCLI
// Останавливает запущенный сервер
//
// Параметры:
//  TCPСервер - Произвольный   - TCP сервер. См. СоздатьСервер - srv
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение - Информация о выполнении
Функция ОтключитьСервер(Знач TCPСервер) Экспорт

    Если Не ЭтоСервер(TCPСервер) Тогда
        ВызватьИсключение "Переданное значение не является TCP-сервером!";
    КонецЕсли;

    Результат = TCPСервер.Stop();

    ОбработатьРезультат(Результат);

    //@skip-check constructor-function-return-section
    Возврат Результат;

КонецФункции

// Ожидать входящие соединения !NOCLI
// Блокирует выполнение программы до появления нового подключения
//
// Параметры:
//  TCPСервер - Произвольный - TCP сервер. См. СоздатьСервер                           - srv
//  Таймаут   - Число        - Максимальное время ожидания подключений. 0 > бесконечно - timeout
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение - Структура с идентификатором нового подключения или ошибкой
Функция ОжидатьВходящиеСоединения(Знач TCPСервер, Знач Таймаут = 0) Экспорт

    Если Не ЭтоСервер(TCPСервер) Тогда
        ВызватьИсключение "Переданное значение не является TCP-сервером!";
    КонецЕсли;

    OPI_ПреобразованиеТипов.ПолучитьЧисло(Таймаут);

    Результат = TCPСервер.Wait(Таймаут);

    ОбработатьРезультат(Результат);

    Возврат Результат;

КонецФункции

// Получить входящие соединения !NOCLI
// Получает список соединений в пуле
//
// Примечание:
// Наличие соединения в пуле не гарантирует его активности.^^
// Для очистки пула от неактивных соединений используется функция АктуализироватьВходящиеСоединения
//
// Параметры:
//  TCPСервер - Произвольный - TCP сервер. См. СоздатьСервер - srv
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение - Информация о выполнении
Функция ПолучитьВходящиеСоединения(Знач TCPСервер) Экспорт

    Если Не ЭтоСервер(TCPСервер) Тогда
        ВызватьИсключение "Переданное значение не является TCP-сервером!";
    КонецЕсли;

    Результат = TCPСервер.ListConnections();

    ОбработатьРезультат(Результат);

    //@skip-check constructor-function-return-section
    Возврат Результат;

КонецФункции

// Актуализировать входящие соединения !NOCLI
// Удаляет неактивные соединения из пула
//
// Параметры:
//  TCPСервер - Произвольный - TCP сервер. См. СоздатьСервер - srv
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение - Информация о выполнении
Функция АктуализироватьВходящиеСоединения(Знач TCPСервер) Экспорт

    Если Не ЭтоСервер(TCPСервер) Тогда
        ВызватьИсключение "Переданное значение не является TCP-сервером!";
    КонецЕсли;

    Результат = TCPСервер.UpdateConnections();

    ОбработатьРезультат(Результат);

    //@skip-check constructor-function-return-section
    Возврат Результат;

КонецФункции

// Это сервер !NOCLI
// Определяет, является ли переданное значение объектом TCP сервера
//
// Параметры:
//  Значение - Произвольный - произвольное значение для проверки - value
//
// Возвращаемое значение:
//  Булево -  Это сервер
Функция ЭтоСервер(Знач Значение) Экспорт

    Возврат Строка(ТипЗнч(Значение)) = "AddIn.OPI_TCPServer.Server";

КонецФункции

#КонецОбласти

#Область МетодыОбработкиСоединений

// Получить запрос !NOCLI
// Получает данные из потока существующего соединения
//
// Параметры:
//  IDПодключения      - Строка, Число - ID активного подключения. См. ОжидатьПодключение           - conn
//  МаксимальныйРазмер - Число         - Максимальный размер данных. 0 > до конца потока            - maxsize
//  TCPОбработчик      - Произвольный  - TCP сервер или пустое значение при обособленной обоработке - hnd
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение, ДвоичныеДанные - Двоичные данные при успехе или структура с описанием ошибки
Функция ПолучитьЗапрос(Знач IDПодключения, Знач МаксимальныйРазмер = 0, Знач TCPОбработчик = "") Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDПодключения);
    OPI_ПреобразованиеТипов.ПолучитьЧисло(МаксимальныйРазмер);
    
    Если Не ЭтоСерверИлиОбработчик(TCPОбработчик) Тогда     
        TCPОбработчик = ПодключитьКомпонентуНаСервере("OPI_TCPServer", "Handler"); 
    КонецЕсли;

    Данные = TCPОбработчик.Receive(IDПодключения, МаксимальныйРазмер);

    Если ТипЗнч(Данные) = Тип("Строка") Тогда
        Попытка
            Результат = OPI_Инструменты.JsonВСтруктуру(Данные, Ложь);
        Исключение
            Результат = Новый Структура("result,error", Ложь, Данные);
        КонецПопытки;

    Иначе
        Результат = Данные;
    КонецЕсли;

    //@skip-check constructor-function-return-section
    Возврат Результат;

КонецФункции

// Отправить ответ !NOCLI
// Отправляет данные клиенту по идентификатору подключения
//
// Параметры:
//  IDПодключения - Строка, Число  - ID активного подключения. См. ОжидатьПодключение           - conn
//  Данные        - ДвоичныеДанные - Данные для отправки                                        - data
//  TCPОбработчик - Произвольный   - TCP сервер или пустое значение при обособленной обоработке - hnd
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение - Информация о выполнении
Функция ОтправитьОтвет(Знач IDПодключения, Знач Данные, Знач TCPОбработчик = "") Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDПодключения);
    OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Данные);
    
    Если Не ЭтоСерверИлиОбработчик(TCPОбработчик) Тогда     
        TCPОбработчик = ПодключитьКомпонентуНаСервере("OPI_TCPServer", "Handler"); 
    КонецЕсли;

    Результат = TCPОбработчик.Send(IDПодключения, Данные);

    ОбработатьРезультат(Результат);

    //@skip-check constructor-function-return-section
    Возврат Результат;

КонецФункции

// Закрыть входящее соединение !NOCLI
// Закрывает существующее соединение по идентификатору
//
// Параметры:
//  IDПодключения - Строка, Число  - ID активного подключения. См. ОжидатьПодключение           - conn
//  TCPОбработчик - Произвольный   - TCP сервер или пустое значение при обособленной обоработке - hnd
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение - Информация о выполнении
Функция ЗакрытьВходящееСоединение(Знач IDПодключения, Знач TCPОбработчик = "") Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDПодключения);
    
    Если Не ЭтоСерверИлиОбработчик(TCPОбработчик) Тогда     
        TCPОбработчик = ПодключитьКомпонентуНаСервере("OPI_TCPServer", "Handler"); 
    КонецЕсли;

    Результат = TCPОбработчик.Close(IDПодключения);

    ОбработатьРезультат(Результат);

    //@skip-check constructor-function-return-section
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

    Компонента = Новый("AddIn." + ИмяКомпоненты + "." + Класс);
    Возврат Компонента;

КонецФункции

Функция ЭтоСерверИлиОбработчик(Знач Значение)

    Возврат Строка(ТипЗнч(Значение)) = "AddIn.OPI_TCPServer.Server"
        Или Строка(ТипЗнч(Значение)) = "AddIn.OPI_TCPServer.Handler";

КонецФункции

Процедура ОбработатьРезультат(Результат)

    Попытка
        Результат = OPI_Инструменты.JsonВСтруктуру(Результат, Ложь);
    Исключение
        Результат = Новый Структура("result,error", Ложь, Результат);
    КонецПопытки;

КонецПроцедуры

#КонецОбласти
