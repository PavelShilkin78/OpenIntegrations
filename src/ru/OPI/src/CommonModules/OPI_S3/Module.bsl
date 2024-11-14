﻿// OneScript: ./OInt/core/Modules/OPI_S3.os
// Lib: S3
// CLI: s3

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
// #Использовать "../../tools"

#Область ПрограммныйИнтерфейс

#Область ОбщиеМетоды

// Получить структуру данных
// Возвращает основные данные запроса в структурированном виде
//
// Параметры:
//  URL       - Строка - URL: домен для обычных методов или полный URL с параметрами для методов прямой отправки запросов - url
//  AccessKey - Строка - Access key для авторизации       - access
//  SecretKey - Строка - Secret key для авторизации       - secret
//  Region    - Строка - Регион сервиса                   - region
//  Service   - Строка - Вид сервиса, если отличен от s3  - service
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение -  Структура основных данных запроса
Функция ПолучитьСтруктуруДанных(Знач URL, Знач AccessKey, Знач SecretKey, Знач Region, Знач Service = "s3") Экспорт

    СтруктураАвторизации = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("URL"      , URL      , "Строка", СтруктураАвторизации);
    OPI_Инструменты.ДобавитьПоле("AccessKey", AccessKey, "Строка", СтруктураАвторизации);
    OPI_Инструменты.ДобавитьПоле("SecretKey", SecretKey, "Строка", СтруктураАвторизации);
    OPI_Инструменты.ДобавитьПоле("Region"   , Region   , "Строка", СтруктураАвторизации);
    OPI_Инструменты.ДобавитьПоле("Service"  , Service  , "Строка", СтруктураАвторизации);

    Возврат СтруктураАвторизации;

КонецФункции

// Отправить запрос без тела
// Отправляет простой http запрос без тела
//
// Параметры:
//  Метод          - Строка                        - HTTP метод                                                           - method
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса (c полным URL). См. ПолучитьСтруктуруДанных  - data
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо                    - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция ОтправитьЗапросБезТела(Знач Метод, Знач ОсновныеДанные, Знач Заголовки = Неопределено) Экспорт

    Ответ = ОтправитьЗапрос(Метод, ОсновныеДанные, , Заголовки);
    Возврат Ответ;

КонецФункции

// Отправить запрос с телом
// Отправляет http запрос с телом
//
// Параметры:
//  Метод          - Строка                        - HTTP метод                                                           - method
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса (c полным URL). См. ПолучитьСтруктуруДанных  - data
//  Тело           - Строка, ДвоичныеДанные        - Двоичное тело запроса или путь к файлу                               - body
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо                    - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция ОтправитьЗапросСТелом(Знач Метод, Знач ОсновныеДанные, Знач Тело, Знач Заголовки = Неопределено) Экспорт

    Ответ = ОтправитьЗапрос(Метод, ОсновныеДанные, Тело, Заголовки);
    Возврат Ответ;

КонецФункции

#КонецОбласти

#Область РаботаСБакетами

// Создать бакет
// Создает новый бакет с выбранным именем
//
// Примечание:
// Метод в документации AWS: [CreateBucket](@docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html)
//
// Параметры:
//  Наименование   - Строка                        - Наименование бакета                                      - name
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса. См. ПолучитьСтруктуруДанных     - data
//  Каталог        - Булево                        - Истина > Directory Bucket, Ложь > General Purpose Bucket - dir
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо        - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция СоздатьБакет(Знач Наименование, Знач ОсновныеДанные, Знач Каталог = Истина, Знач Заголовки = Неопределено) Экспорт

    Ответ = УправлениеБакетом(Наименование, ОсновныеДанные, Каталог, "PUT", Заголовки);
    Возврат Ответ;

КонецФункции

// Удалить бакет
// Удаляет бакет с выбранным именем
//
// Примечание:
// Метод в документации AWS: [DeleteBucket](@docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html)
//
// Параметры:
//  Наименование   - Строка                        - Наименование бакета                                      - name
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса. См. ПолучитьСтруктуруДанных     - data
//  Каталог        - Булево                        - Истина > Directory Bucket, Ложь > General Purpose Bucket - dir
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо        - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция УдалитьБакет(Знач Наименование, Знач ОсновныеДанные, Знач Каталог = Истина, Знач Заголовки = Неопределено) Экспорт

    Ответ = УправлениеБакетом(Наименование, ОсновныеДанные, Каталог, "DELETE", Заголовки);
    Возврат Ответ;

КонецФункции

// Проверить доступность бакета
// Проверяет доступность бакета для текущего аккаунта или аккаунта по ID
//
// Примечание:
// Метод в документации AWS: [HeadBucket](@docs.aws.amazon.com/AmazonS3/latest/API/API_HeadBucket.html)
//
// Параметры:
//  Наименование   - Строка                        - Наименование бакета                                      - name
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса. См. ПолучитьСтруктуруДанных     - data
//  Каталог        - Булево                        - Истина > Directory Bucket, Ложь > General Purpose Bucket - dir
//  IDАккаунта     - Строка                        - ID аккаунта для проверки, что бакет принадлежит ему      - account
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо        - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция ПроверитьДоступностьБакета(Знач Наименование
    , Знач ОсновныеДанные
    , Знач Каталог = Истина
    , Знач IDАккаунта = ""
    , Знач Заголовки = Неопределено) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDАккаунта);

    Если ЗначениеЗаполнено(IDАккаунта) Тогда
        ЗаголовокАккаунта = Новый Соответствие();
        ЗаголовокАккаунта.Вставить("x-amz-expected-bucket-owner", IDАккаунта);
        ДобавитьДополнительныеЗаголовки(Заголовки, ЗаголовокАккаунта);
    КонецЕсли;

    Ответ = УправлениеБакетом(Наименование, ОсновныеДанные, Каталог, "HEAD", Заголовки);
    Возврат Ответ;

КонецФункции

// Установить шифрование бакета
// Устанавлиает шифрование бакета по XML конфигурации
//
// Примечание:
// Метод в документации AWS: [PutBucketEncryption](@docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketEncryption.html)
//
// Параметры:
//  Наименование    - Строка                        - Наименование бакета                                      - name
//  ОсновныеДанные  - Структура Из КлючИЗначение    - Основные данные запроса. См. ПолучитьСтруктуруДанных     - data
//  XMLКонфигурация - Строка                        - XML строка или файл конфигурации шифрования              - conf
//  Каталог         - Булево                        - Истина > Directory Bucket, Ложь > General Purpose Bucket - dir
//  Заголовки       - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо        - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция УстановитьШифрованиеБакета(Знач Наименование
    , Знач ОсновныеДанные
    , Знач XMLКонфигурация
    , Знач Каталог = Истина
    , Знач Заголовки = Неопределено) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(XMLКонфигурация, Истина);
    XMLКонфигурация = ПолучитьДвоичныеДанныеИзСтроки(XMLКонфигурация);

    URL = ПолучитьURLСервиса(ОсновныеДанные);
    URL = СформироватьURLБакета(URL, Наименование, Каталог);
    URL = URL + "?encryption";

    ОсновныеДанные.Вставить("URL", URL);

    Ответ = ОтправитьЗапросСТелом("PUT", ОсновныеДанные, XMLКонфигурация, Заголовки);

    Возврат Ответ;

КонецФункции

// Получить шифрование бакета
// Получает установленную ранее конфигурацию шифрования бакета
//
// Примечание:
// Метод в документации AWS: [GetBucketEncryption](@docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketEncryption.html)
//
// Параметры:
//  Наименование   - Строка                        - Наименование бакета                                      - name
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса. См. ПолучитьСтруктуруДанных     - data
//  Каталог        - Булево                        - Истина > Directory Bucket, Ложь > General Purpose Bucket - dir
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо        - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция ПолучитьШифрованиеБакета(Знач Наименование
    , Знач ОсновныеДанные
    , Знач Каталог = Истина
    , Знач Заголовки = Неопределено) Экспорт

    URL = ПолучитьURLСервиса(ОсновныеДанные);
    URL = СформироватьURLБакета(URL, Наименование, Каталог);

    URL = URL + "?encryption";

    ОсновныеДанные.Вставить("URL", URL);

    Ответ = ОтправитьЗапросБезТела("GET", ОсновныеДанные, Заголовки);

    Возврат Ответ;

КонецФункции

// Удалить шифрование бакета
// Удаляет конфигурацию шифрования бакета
//
// Примечание:
// Метод в документации AWS: [DeleteBucketEncryption](@docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketEncryption.html)
//
// Параметры:
//  Наименование   - Строка                        - Наименование бакета                                      - name
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса. См. ПолучитьСтруктуруДанных     - data
//  Каталог        - Булево                        - Истина > Directory Bucket, Ложь > General Purpose Bucket - dir
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо        - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция УдалитьШифрованиеБакета(Знач Наименование
    , Знач ОсновныеДанные
    , Знач Каталог = Истина
    , Знач Заголовки = Неопределено) Экспорт

    URL = ПолучитьURLСервиса(ОсновныеДанные);
    URL = СформироватьURLБакета(URL, Наименование, Каталог);

    URL = URL + "?encryption";

    ОсновныеДанные.Вставить("URL", URL);

    Ответ = ОтправитьЗапросБезТела("DELETE", ОсновныеДанные, Заголовки);

    Возврат Ответ;

КонецФункции

// Установить теги бакета
// Устанавливает набор тегов для бакета
//
// Примечание:
// Установка нового набора удаляет все существующие теги бакета
// Метод в документации AWS: [PutBucketTagging](@docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketTagging.html)
//
// Параметры:
//  Наименование   - Строка                      - Наименование бакета                                        - name
//  ОсновныеДанные - Структура Из КлючИЗначение  - Основные данные запроса. См. ПолучитьСтруктуруДанных       - data
//  Теги           - Структура Из КлючИЗначение  - Набор тегов (ключ и значение) для установки                - tagset
//  Каталог        - Булево                        - Истина > Directory Bucket, Ложь > General Purpose Bucket - dir
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо        - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция УстановитьТегиБакета(Знач Наименование
    , Знач ОсновныеДанные
    , Знач Теги
    , Знач Каталог = Истина
    , Знач Заголовки = Неопределено) Экспорт

    Теги    = СформироватьСтруктуруТегов(Теги);
    ТегиXML = OPI_Инструменты.ПолучитьXML(Теги, "http://s3.amazonaws.com/doc/2006-03-01/");
    ТегиXML = ПолучитьДвоичныеДанныеИзСтроки(ТегиXML);

    URL = ПолучитьURLСервиса(ОсновныеДанные);
    URL = СформироватьURLБакета(URL, Наименование, Каталог);
    URL = URL + "?tagging";

    ОсновныеДанные.Вставить("URL", URL);

    Ответ = ОтправитьЗапросСТелом("PUT", ОсновныеДанные, ТегиXML, Заголовки);

    Возврат Ответ;

КонецФункции

// Получить теги бакета
// Получает набор тегов бакета
//
// Примечание:
// Метод в документации AWS: [GetBucketTagging](@docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketTagging.html)
//
// Параметры:
//  Наименование   - Строка                        - Наименование бакета                                      - name
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса. См. ПолучитьСтруктуруДанных     - data
//  Каталог        - Булево                        - Истина > Directory Bucket, Ложь > General Purpose Bucket - dir
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо        - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция ПолучитьТегиБакета(Знач Наименование
    , Знач ОсновныеДанные
    , Знач Каталог = Истина
    , Знач Заголовки = Неопределено) Экспорт

    URL = ПолучитьURLСервиса(ОсновныеДанные);
    URL = СформироватьURLБакета(URL, Наименование, Каталог);
    URL = URL + "?tagging";

    ОсновныеДанные.Вставить("URL", URL);

    Ответ = ОтправитьЗапросБезТела("GET", ОсновныеДанные, Заголовки);

    Возврат Ответ;

КонецФункции

// Удалить теги бакета
// Удаляет набор тегов бакета
//
// Примечание:
// Метод в документации AWS: [DeleteBucketTagging](@docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketTagging.html)
//
// Параметры:
//  Наименование   - Строка                        - Наименование бакета                                      - name
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса. См. ПолучитьСтруктуруДанных     - data
//  Каталог        - Булево                        - Истина > Directory Bucket, Ложь > General Purpose Bucket - dir
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо        - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция УдалитьТегиБакета(Знач Наименование
    , Знач ОсновныеДанные
    , Знач Каталог = Истина
    , Знач Заголовки = Неопределено) Экспорт

    URL = ПолучитьURLСервиса(ОсновныеДанные);
    URL = СформироватьURLБакета(URL, Наименование, Каталог);
    URL = URL + "?tagging";

    ОсновныеДанные.Вставить("URL", URL);

    Ответ = ОтправитьЗапросБезТела("DELETE", ОсновныеДанные, Заголовки);

    Возврат Ответ;

КонецФункции

// Установить настройки версионирования бакета
// Устанавливает настройки версионирования объектов бакета
//
// Примечание:
// Метод в документации AWS: [PutBucketVersioning](@docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketVersioning.html)
//
// Параметры:
//  Наименование   - Строка                        - Наименование бакета                                      - name
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса. См. ПолучитьСтруктуруДанных     - data
//  Статус         - Булево                        - Включение и отключение версионирования, если необходимо  - status
//  УдалениеMFA    - Булево                        - Включение и отключение удаления MFA, если необходимо     - mfad
//  Каталог        - Булево                        - Истина > Directory Bucket, Ложь > General Purpose Bucket - dir
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо        - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция УстановитьНастройкиВерсионированияБакета(Знач Наименование
    , Знач ОсновныеДанные
    , Знач Статус = Неопределено
    , Знач УдалениеMFA = Неопределено
    , Знач Каталог = Истина
    , Знач Заголовки = Неопределено) Экспорт

    Теги    = СформироватьСтруктуруНастроекВерсионирования(Статус, УдалениеMFA);
    ТегиXML = OPI_Инструменты.ПолучитьXML(Теги, "http://s3.amazonaws.com/doc/2006-03-01/");
    ТегиXML = ПолучитьДвоичныеДанныеИзСтроки(ТегиXML);

    URL = ПолучитьURLСервиса(ОсновныеДанные);
    URL = СформироватьURLБакета(URL, Наименование, Каталог);
    URL = URL + "?versioning";

    ОсновныеДанные.Вставить("URL", URL);

    Ответ = ОтправитьЗапросСТелом("PUT", ОсновныеДанные, ТегиXML, Заголовки);

    Возврат Ответ;

КонецФункции

// Получить настройки версионирования бакета
// Получает значения настроек версионирования объектов в бакете
//
// Примечание:
// Метод в документации AWS: [GetBucketVersioning](@docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketVersioning.html)
//
// Параметры:
//  Наименование   - Строка                        - Наименование бакета                                      - name
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса. См. ПолучитьСтруктуруДанных     - data
//  Каталог        - Булево                        - Истина > Directory Bucket, Ложь > General Purpose Bucket - dir
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо        - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция ПолучитьНастройкийВерсионированияБакета(Знач Наименование
    , Знач ОсновныеДанные
    , Знач Каталог = Истина
    , Знач Заголовки = Неопределено) Экспорт

    URL = ПолучитьURLСервиса(ОсновныеДанные);
    URL = СформироватьURLБакета(URL, Наименование, Каталог);
    URL = URL + "?versioning";

    ОсновныеДанные.Вставить("URL", URL);

    Ответ = ОтправитьЗапросБезТела("GET", ОсновныеДанные, Заголовки);

    Возврат Ответ;

КонецФункции

// Получить список бакетов
// Получает список бакетов. Возможно использование отборов, если они поддерживаются сервисом
//
// Примечание:
// Метод в документации AWS: [ListBuckets](@docs.aws.amazon.com/AmazonS3/latest/API/API_ListBuckets.html)
//
// Параметры:
//  ОсновныеДанные - Структура Из КлючИЗначение    - Основные данные запроса. См. ПолучитьСтруктуруДанных - data
//  Префикс        - Строка                        - Отбор по началу имени, если необходимо               - prefix
//  Регион         - Строка                        - Отбор по региону бакета, если необходимо             - region
//  ТокенСтраницы  - Строка                        - Токен страницы, если используется пагинация          - ctoken
//  Заголовки      - Соответствие Из КлючИЗначение - Дополнительные заголовки запроса, если необходимо    - headers
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от хранилища
Функция ПолучитьСписокБакетов(Знач ОсновныеДанные
    , Знач Префикс = ""
    , Знач Регион = ""
    , Знач ТокенСтраницы = ""
    , Знач Заголовки = Неопределено) Экспорт

    Параметры = Новый Соответствие;
    OPI_Инструменты.ДобавитьПоле("bucket-region"     , Регион       , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("continuation-token", ТокенСтраницы, "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("max-buckets"       , 250          , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("prefix"            , Префикс      , "Строка", Параметры);

    URL = ПолучитьURLСервиса(ОсновныеДанные);
    URL = URL + OPI_Инструменты.ПараметрыЗапросаВСтроку(Параметры);

    ОсновныеДанные.Вставить("URL", URL);

    Ответ = ОтправитьЗапросБезТела("GET", ОсновныеДанные, Заголовки);

    Возврат Ответ;

КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Авторизация

Функция СоздатьЗаголовокАвторизации(Знач СтруктураДанных, Знач Запрос, Знач Соединение, Знач Метод)

    AccessKey = СтруктураДанных["AccessKey"];
    SecretKey = СтруктураДанных["SecretKey"];
    Region    = СтруктураДанных["Region"];
    Service   = СтруктураДанных["Service"];

    ТекущаяДата = ТекущаяУниверсальнаяДата();

    Запрос.Заголовки.Вставить("x-amz-date", OPI_Инструменты.ВременнаяМеткаISO(ТекущаяДата));
    Запрос.Заголовки.Вставить("Host"      , Соединение.Сервер);

    КлючПодписи        = ПолучитьКлючПодписи(SecretKey, Region, Service, ТекущаяДата);
    КаноническийЗапрос = СоздатьКаноническийЗапрос(Запрос, Соединение, Метод);
    Скоуп              = СоздатьСкоуп(Region, Service, ТекущаяДата);
    СтрокаДляПодписи   = СоздатьСтрокуПодписи(КаноническийЗапрос, Скоуп, ТекущаяДата);

    Сигнатура = OPI_Криптография.HMACSHA256(КлючПодписи, СтрокаДляПодписи);
    Сигнатура = нРег(ПолучитьHexСтрокуИзДвоичныхДанных(Сигнатура));

    КлючиЗаголовков      = ПолучитьСтрокуКлючейЗаголовков(Запрос);
    ЗаголовокАвторизации = СформироватьЗаголовокАвторизации(AccessKey, Скоуп, Сигнатура, КлючиЗаголовков);

    Возврат ЗаголовокАвторизации;

КонецФункции

Функция ПолучитьКлючПодписи(Знач СекретныйКлюч, Знач Регион, Знач Сервис, Знач ТекущаяДата)

    СекретныйКлюч = ПолучитьДвоичныеДанныеИзСтроки("AWS4" + СекретныйКлюч);
    ДанныеДата    = ПолучитьДвоичныеДанныеИзСтроки(Формат(ТекущаяДата, "ДФ=yyyyMMdd;"));
    Регион        = ПолучитьДвоичныеДанныеИзСтроки(Регион);
    Сервис        = ПолучитьДвоичныеДанныеИзСтроки(Сервис);
    AWSЗапрос     = ПолучитьДвоичныеДанныеИзСтроки("aws4_request");

    КлючДанных  = OPI_Криптография.HMACSHA256(СекретныйКлюч, ДанныеДата);
    КлючРегиона = OPI_Криптография.HMACSHA256(КлючДанных, Регион);
    КлючСервиса = OPI_Криптография.HMACSHA256(КлючРегиона, Сервис);

    ФинальныйКлюч = OPI_Криптография.HMACSHA256(КлючСервиса, AWSЗапрос);

    Возврат ФинальныйКлюч;

КонецФункции

Функция СоздатьКаноническийЗапрос(Знач Запрос, Знач Соединение, Знач Метод)

    ТелоЗапроса  = Запрос.ПолучитьТелоКакДвоичныеДанные();

    Если Не ЗначениеЗаполнено(ТелоЗапроса) Тогда
        ТелоЗапроса = ПолучитьДвоичныеДанныеИзСтроки("");
    КонецЕсли;

    ХешСумма = OPI_Криптография.Хеш(ТелоЗапроса, ХешФункция.SHA256);
    Запрос.Заголовки.Вставить("x-amz-content-sha256", нРег(ПолучитьHexСтрокуИзДвоичныхДанных(ХешСумма)));

    ШаблонЗапроса = "";

    Для Н = 1 По 6 Цикл

        ШаблонЗапроса = ШаблонЗапроса + "%" + Строка(Н) + ?(Н = 6, "", Символы.ПС);

    КонецЦикла;

    Метод            = вРег(Метод);
    СтрокаURI        = ПолучитьСтрокуURI(Запрос);
    СтрокаПараметров = ПолучитьСтрокуПараметров(Запрос);
    СтрокаЗаголовков = ПолучитьСтрокуЗаголовков(Запрос);
    СтрокаКлючей     = ПолучитьСтрокуКлючейЗаголовков(Запрос);

    СтрокаХэша = нРег(ПолучитьHexСтрокуИзДвоичныхДанных(ХешСумма));

    КаноническийЗапрос = СтрШаблон(ШаблонЗапроса
        , Метод
        , СтрокаURI
        , СтрокаПараметров
        , СтрокаЗаголовков
        , СтрокаКлючей
        , СтрокаХэша);

    Возврат КаноническийЗапрос;

КонецФункции

Функция СоздатьСкоуп(Знач Регион, Знач Сервис, Знач ТекущаяДата)

    ДатаОбычная = Формат(ТекущаяДата, "ДФ=yyyyMMdd;");

    Скоуп = Новый Массив;
    Скоуп.Добавить(ДатаОбычная);
    Скоуп.Добавить(Регион);
    Скоуп.Добавить(Сервис);
    Скоуп.Добавить("aws4_request");

    СкоупСтрокой = СтрСоединить(Скоуп, "/");

    Возврат СкоупСтрокой;

КонецФункции

Функция СоздатьСтрокуПодписи(Знач КаноническийЗапрос, Знач Скоуп, Знач ТекущаяДата)

    ШаблонСтроки       = "";
    Алгоритм           = "AWS4-HMAC-SHA256";
    ДатаISO            = OPI_Инструменты.ВременнаяМеткаISO(ТекущаяДата);

    КаноническийЗапрос = ПолучитьДвоичныеДанныеИзСтроки(КаноническийЗапрос);
    КаноническийЗапрос = OPI_Криптография.Хеш(КаноническийЗапрос, ХешФункция.SHA256);
    КаноническийЗапрос = нРег(ПолучитьHexСтрокуИзДвоичныхДанных(КаноническийЗапрос));

    Для Н = 1 По 4 Цикл

        ШаблонСтроки = ШаблонСтроки + "%" + Строка(Н) + ?(Н = 4, "", Символы.ПС);

    КонецЦикла;

    СтрокаПодписи    = СтрШаблон(ШаблонСтроки, Алгоритм, ДатаISO, Скоуп, КаноническийЗапрос);
    СтрокаПодписи    = ПолучитьДвоичныеДанныеИзСтроки(СтрокаПодписи);

    Возврат СтрокаПодписи;

КонецФункции

Функция ПолучитьСтрокуURI(Знач Запрос)

    URI   = Запрос.АдресРесурса;
    URI   = ?(СтрНачинаетсяС(URI, "/"), URI, "/" + URI);

    НачалоПараметров = СтрНайти(URI, "?");

    Если НачалоПараметров <> 0 Тогда
        URI = Лев(URI, НачалоПараметров - 1);
    КонецЕсли;

    Возврат URI;

КонецФункции

Функция ПолучитьСтрокуПараметров(Запрос)

    URI              = Запрос.АдресРесурса;
    НачалоПараметров = СтрНайти(URI, "?");

    Если НачалоПараметров = 0 Тогда

        СтрокаПараметров     = "";

    Иначе

        ДлинаURI          = СтрДлина(URI);
        СтрокаПараметров  = Прав(URI, ДлинаURI - НачалоПараметров);
        ОбработатьСтрокуПараметровЗапроса(СтрокаПараметров);

    КонецЕсли;

    Возврат СтрокаПараметров;

КонецФункции

Функция ПолучитьСтрокуЗаголовков(Знач Запрос)

    СписокЗаголовков = Новый СписокЗначений;
    Заголовки        = Запрос.Заголовки;

    Для Каждого Заголовок Из Заголовки Цикл

        ТекущийКлюч  = Заголовок.Ключ;
        ТекущийКлючН = нРег(ТекущийКлюч);

        Если Не СтрНачинаетсяС(ТекущийКлючН, "host") И Не СтрНачинаетсяС(ТекущийКлючН, "x-amz") Тогда
            Продолжить;
        КонецЕсли;

        СтрокаЗаголовка = нРег(ТекущийКлюч) + ":" + Заголовок.Значение;
        СписокЗаголовков.Добавить(СтрокаЗаголовка);

    КонецЦикла;

    СписокЗаголовков.СортироватьПоЗначению();

    СтрокаЗаголовков = СтрСоединить(СписокЗаголовков.ВыгрузитьЗначения(), Символы.ПС);
    СтрокаЗаголовков = СтрокаЗаголовков + Символы.ПС;

    Возврат СтрокаЗаголовков;

КонецФункции

Функция ПолучитьСтрокуКлючейЗаголовков(Знач Запрос)

    СписокЗаголовков = Новый СписокЗначений;
    Заголовки        = Запрос.Заголовки;

    Для Каждого Заголовок Из Заголовки Цикл

        ТекущийКлюч  = Заголовок.Ключ;
        ТекущийКлючН = нРег(ТекущийКлюч);

        Если Не СтрНачинаетсяС(ТекущийКлючН, "host") И Не СтрНачинаетсяС(ТекущийКлючН, "x-amz") Тогда
            Продолжить;
        КонецЕсли;

        СтрокаЗаголовка = нРег(ТекущийКлюч);
        СписокЗаголовков.Добавить(СтрокаЗаголовка);

    КонецЦикла;

    СписокЗаголовков.СортироватьПоЗначению();

    СтрокаЗаголовков = СтрСоединить(СписокЗаголовков.ВыгрузитьЗначения(), ";");

    Возврат СтрокаЗаголовков;

КонецФункции

Функция ПолучитьURLСервиса(Знач ОсновныеДанные)

    OPI_ПреобразованиеТипов.ПолучитьКоллекцию(ОсновныеДанные);

    Если ТипЗнч(ОсновныеДанные) = Тип("Массив") Тогда
        ВызватьИсключение "Ошибка получения авторизационных данных из структуры";
    КонецЕсли;

    URL = ОсновныеДанные["URL"];

    OPI_ПреобразованиеТипов.ПолучитьСтроку(URL);

    Если Не СтрЗаканчиваетсяНа(URL, "/") Тогда
        URL = URL + "/";
    КонецЕсли;

    Возврат URL;

КонецФункции

Функция СформироватьЗаголовокАвторизации(Знач AccessKey, Знач Скоуп, Знач Сигнатура, Знач КлючиЗаголовков)

    ШаблонЗаголовка = "AWS4-HMAC-SHA256 "
        + "Credential=%1/%2, "
        + "SignedHeaders=%3, "
        + "Signature=%4";

    ЗаголовокАвторизации = СтрШаблон(ШаблонЗаголовка, AccessKey, Скоуп, КлючиЗаголовков, Сигнатура);

    Возврат ЗаголовокАвторизации;

КонецФункции

Процедура ОбработатьСтрокуПараметровЗапроса(СтрокаПараметров)

    МассивПараметров = СтрРазделить(СтрокаПараметров, "&");
    СписокПараметров = Новый СписокЗначений();
    СписокПараметров.ЗагрузитьЗначения(МассивПараметров);

    СписокПараметров.СортироватьПоЗначению();
    МассивПараметров = СписокПараметров.ВыгрузитьЗначения();

    КонечныйМассивПараметров     = Новый Массив;

    Для Н = 0 По МассивПараметров.ВГраница() Цикл

        ПараметрЗапроса = МассивПараметров[Н];

        Если СтрНайти(ПараметрЗапроса, "=") = 0 Тогда
            МассивПараметров[Н] = ПараметрЗапроса + "=";
        КонецЕсли;

    КонецЦикла;

    СтрокаПараметров = СтрСоединить(МассивПараметров, "&");

КонецПроцедуры

#КонецОбласти

#Область Прочее

Функция ОтправитьЗапрос(Знач Метод, Знач ОсновныеДанные, Знач Тело = Неопределено, Знач Заголовки = Неопределено)

    ПроверитьОсновныеДанные(ОсновныеДанные);

    URL = ОсновныеДанные["URL"];

    СтруктураURL = OPI_Инструменты.РазбитьURL(URL);
    Сервер       = СтруктураURL["Сервер"];
    Адрес        = СтруктураURL["Адрес"];
    Защищенное   = СтруктураURL["Защищенное"];

    Запрос     = OPI_Инструменты.СоздатьЗапрос(Адрес);
    Соединение = OPI_Инструменты.СоздатьСоединение(Сервер, Защищенное);

    Если ЗначениеЗаполнено(Тело) Тогда
        УстановитьТелоЗапроса(Запрос, Тело);
    КонецЕсли;

    ДобавитьДополнительныеЗаголовки(Запрос, Заголовки);

    ЗаголовокАвторизации = СоздатьЗаголовокАвторизации(ОсновныеДанные, Запрос, Соединение, Метод);
    Запрос.Заголовки.Вставить("Authorization", ЗаголовокАвторизации);

    Ответ  = OPI_Инструменты.ВыполнитьЗапрос(Запрос, Соединение, Метод, , Истина);
    Ответ  = ОформитьОтвет(Ответ);

    Возврат Ответ;

КонецФункции

Функция УправлениеБакетом(Знач Имя, Знач ОсновныеДанные, Знач Каталог, Знач Метод, Знач Заголовки)

    URL    = ПолучитьURLСервиса(ОсновныеДанные);
    URL    = СформироватьURLБакета(URL, Имя, Каталог);

    ОсновныеДанные.Вставить("URL", URL);

    Ответ = ОтправитьЗапросБезТела(Метод, ОсновныеДанные, Заголовки);

    Возврат Ответ;

КонецФункции

Функция ОформитьОтвет(Знач Ответ, Знач ОжидаютсяДвоичные = Ложь)

    Статус = Ответ.КодСостояния;

    Если Не ОжидаютсяДвоичные Или Статус > 299 Тогда

        ДанныеОтвета = Новый Соответствие;
        ДанныеТела   = Новый Соответствие;

        ТелоОтвета = Ответ.ПолучитьТелоКакСтроку();
        ТелоОтвета = СокрЛП(ТелоОтвета);

        Если ЗначениеЗаполнено(ТелоОтвета) Тогда

            Попытка
                ДанныеТела = OPI_Инструменты.ОбработатьXML(ТелоОтвета);
            Исключение
                ДанныеТела.Вставить("notValidXMLMessage", ТелоОтвета);
            КонецПопытки;

        КонецЕсли;

        ДанныеОтвета = Новый Соответствие;
        ДанныеОтвета.Вставить("status"  , Статус);
        ДанныеОтвета.Вставить("response", ДанныеТела);

    Иначе
        ДанныеОтвета = Ответ.ПолучитьТелоКакДвоичныеДанные();
    КонецЕсли;

    Возврат ДанныеОтвета;

КонецФункции

Функция СформироватьURLБакета(Знач URL, Знач Имя, Знач Каталог)

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Имя);
    OPI_ПреобразованиеТипов.ПолучитьБулево(Каталог);

    Если Каталог Тогда
        URL = URL + Имя;
    Иначе

        Если СтрНайти(URL, "://") Тогда
            URL = СтрЗаменить(URL, "://", "://" + Имя + ".");
        Иначе
            URL = Имя + "." + URL;
        КонецЕсли;

    КонецЕсли;

    Если Не СтрЗаканчиваетсяНа(URL, "/") Тогда
        URL = URL + "/";
    КонецЕсли;

    Возврат URL;

КонецФункции

Функция СформироватьСтруктуруТегов(Знач Теги)

    ТекстОшибки = "Некорректный формат тегов. Ожидается коллекция ключ-значение";
    OPI_ПреобразованиеТипов.ПолучитьКоллекциюКлючИЗначение(Теги, ТекстОшибки);

    МассивТегов = Новый Массив;

    Для Каждого Тег Из Теги Цикл

        СтруктураТега = Новый Структура;
        СтруктураТега.Вставить("Key"  , Строка(Тег.Ключ));
        СтруктураТега.Вставить("Value", Строка(Тег.Значение));

        МассивТегов.Добавить(Новый Структура("Tag", СтруктураТега));

    КонецЦикла;

    ФинальнаяСтруктура = Новый Структура;
    НаборТегов         = Новый Структура;

    НаборТегов.Вставить("TagSet", МассивТегов);
    ФинальнаяСтруктура.Вставить("Tagging", НаборТегов);

    Возврат ФинальнаяСтруктура;

КонецФункции

Функция СформироватьСтруктуруНастроекВерсионирования(Знач Статус, Знач УдалениеMFA)

    СтруктураНастроек = Новый Структура;

    Если ЗначениеЗаполнено(Статус) Тогда

        OPI_ПреобразованиеТипов.ПолучитьБулево(Статус);
        СтруктураНастроек.Вставить("Status", ?(Статус, "Enabled", "Suspended"));

    КонецЕсли;

    Если ЗначениеЗаполнено(УдалениеMFA) Тогда

        OPI_ПреобразованиеТипов.ПолучитьБулево(УдалениеMFA);
        СтруктураНастроек.Вставить("MfaDelete", ?(УдалениеMFA, "Enabled", "Disabled"));

    КонецЕсли;

    ФинальнаяСтруктура = Новый Структура("VersioningConfiguration", СтруктураНастроек);

    Возврат ФинальнаяСтруктура;

КонецФункции

Процедура ПроверитьОсновныеДанные(ОсновныеДанные)

    ТекстОшибки  = "Ошибка получения авторизационных данных из структуры";
    OPI_ПреобразованиеТипов.ПолучитьКоллекциюКлючИЗначение(ОсновныеДанные, ТекстОшибки);

    МассивНеобходимыхПолей = Новый Массив;
    МассивНеобходимыхПолей.Добавить("AccessKey");
    МассивНеобходимыхПолей.Добавить("SecretKey");
    МассивНеобходимыхПолей.Добавить("Region");
    МассивНеобходимыхПолей.Добавить("Service");
    МассивНеобходимыхПолей.Добавить("URL");

    ОтсутствующиеПоля = OPI_Инструменты.НайтиОтсутствующиеПоляКоллекции(ОсновныеДанные, МассивНеобходимыхПолей);

    Если ОтсутствующиеПоля.Количество() > 0 Тогда
        ВызватьИсключение "Отсутствуют необходимые данные авторизации: " + СтрСоединить(ОтсутствующиеПоля, ", ");
    КонецЕсли;

КонецПроцедуры

Процедура ДобавитьДополнительныеЗаголовки(Приемник, Знач Заголовки)

    Если Не ЗначениеЗаполнено(Заголовки) Тогда
        Возврат;
    КонецЕсли;

    ТипПриемника = ТипЗнч(Приемник);
    ТекстОшибки  = "Ошибка установки дополнительных заголовков";
    OPI_ПреобразованиеТипов.ПолучитьКоллекциюКлючИЗначение(Заголовки, ТекстОшибки);

    Если ТипПриемника = Тип("HTTPЗапрос") Тогда

        Для Каждого Заголовок Из Заголовки Цикл
            Приемник.Заголовки.Вставить(Заголовок.Ключ, Заголовок.Значение);
        КонецЦикла;

    Иначе

        Если Не ЗначениеЗаполнено(Приемник) Тогда
            Приемник = Новый Соответствие;
        Иначе
            OPI_ПреобразованиеТипов.ПолучитьКоллекциюКлючИЗначение(Заголовки, ТекстОшибки);
        КонецЕсли;

        Для Каждого Заголовок Из Заголовки Цикл
            Приемник.Вставить(Заголовок.Ключ, Заголовок.Значение);
        КонецЦикла;

    КонецЕсли;

КонецПроцедуры

Процедура УстановитьТелоЗапроса(Запрос, Тело)

    OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Тело);
    Запрос.УстановитьТелоИзДвоичныхДанных(Тело);

КонецПроцедуры

#КонецОбласти

#КонецОбласти
