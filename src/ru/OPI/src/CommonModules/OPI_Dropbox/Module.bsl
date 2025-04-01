﻿// OneScript: ./OInt/core/Modules/OPI_Dropbox.os
// Lib: Dropbox
// CLI: dropbox
// Keywords: dropbox

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

// BSLLS:IncorrectLineBreak-off
// BSLLS:UsingServiceTag-off

//@skip-check module-structure-top-region
//@skip-check module-structure-method-in-regions
//@skip-check wrong-string-literal-content

// Раскомментировать, если выполняется OneScript
// #Использовать "../../tools"

#Область ПрограммныйИнтерфейс

#Область АккаунтИАвторизация

// Получить ссылку авторизации
// Генерирует ссылку авторизации для перехода в браузере
//
// Параметры:
//  КлючПриложения - Строка - Ключ приложения - appkey
//
// Возвращаемое значение:
//  Строка - URL для перехода в браузере
Функция ПолучитьСсылкуАвторизации(Знач КлючПриложения) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(КлючПриложения);
    Возврат "https://www.dropbox.com/oauth2/authorize?client_id="
        + КлючПриложения
        + "&response_type=code&token_access_type=offline";

КонецФункции

// Получить токен
// Полеучает токен на основе кода со страницы ПолучитьСсылкуАвторизации
//
// Параметры:
//  КлючПриложения   - Строка - Ключ приложения             - appkey
//  СекретПриложения - Строка - Секрет приложения           - appsecret
//  Код              - Строка - Код со страницы авторизации - code
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ПолучитьТокен(Знач КлючПриложения, Знач СекретПриложения, Знач Код) Экспорт

    URL = "https://api.dropbox.com/oauth2/token";
    ТипДанных = "application/x-www-form-urlencoded; charset=utf-8";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("code"      , Код                 , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("grant_type", "authorization_code", "Строка", Параметры);

    СтруктураURL = OPI_Инструменты.РазбитьURL(URL);
    Сервер       = СтруктураURL["Сервер"];
    Адрес        = СтруктураURL["Адрес"];

    Запрос     = OPI_Инструменты.СоздатьЗапрос(Адрес, , ТипДанных);
    Соединение = OPI_Инструменты.СоздатьСоединение(Сервер, Истина, КлючПриложения, СекретПриложения);

    СтрокаПараметров = OPI_Инструменты.ПараметрыЗапросаВСтроку(Параметры);
    Данные           = Прав(СтрокаПараметров, СтрДлина(СтрокаПараметров) - 1);

    Запрос.УстановитьТелоИзСтроки(Данные);

    Ответ = Соединение.ВызватьHTTPМетод("POST", Запрос);
    OPI_Инструменты.ОбработатьОтвет(Ответ);

    Возврат Ответ;

КонецФункции

// Обновить токен
// Получает новый токен на основе рефреш токена
//
// Параметры:
//  КлючПриложения   - Строка - Ключ приложения   - appkey
//  СекретПриложения - Строка - Секрет приложения - appsecret
//  РефрешТокен      - Строка - Рефреш токен      - refresh
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ОбновитьТокен(Знач КлючПриложения, Знач СекретПриложения, Знач РефрешТокен) Экспорт

    Строка_ = "Строка";
    URL     = "https://api.dropbox.com/oauth2/token";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("refresh_token", РефрешТокен     , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("grant_type"   , "refresh_token" , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("client_id"    , КлючПриложения  , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("client_secret", СекретПриложения, Строка_, Параметры);

    Ответ = OPI_Инструменты.Post(URL, Параметры, , Ложь);

    Возврат Ответ;

КонецФункции

// Получить информацию об аккаунте
// Получает информацию об аккаунте
//
// Параметры:
//  Токен   - Строка - Токен                                                  - token
//  Аккаунт - Строка - ID аккаунта. Текущий аккаунт токена, если не заполнено - account
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ПолучитьИнформациюОбАккаунте(Знач Токен, Знач Аккаунт = "") Экспорт

    Если ЗначениеЗаполнено(Аккаунт) Тогда
        Результат = ПолучитьАккаунт(Токен, Аккаунт);
    Иначе
        Результат = ПолучитьСвойАккаунт(Токен);
    КонецЕсли;

    Возврат Результат;

КонецФункции

// Получить данные использования пространства
// Получает информацию о количестве использованного дискового пространства
//
// Параметры:
//  Токен - Строка - Токен - token
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ПолучитьДанныеИспользованияПространства(Знач Токен) Экспорт

    URL       = "https://api.dropboxapi.com/2/users/get_space_usage";
    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.PostBinary(URL
        , ПолучитьДвоичныеДанныеИзСтроки("null")
        , Заголовки
        ,
        , "text/plain; charset=dropbox-cors-hack");

    Возврат Ответ;

КонецФункции

#КонецОбласти

#Область РаботаСФайламиИКаталогами

// Получить информацию об объекте
// Получает информацию о файле или каталоге
//
// Параметры:
//  Токен    - Строка - Токен                                                    - token
//  Путь     - Строка - Путь к объекту                                           - path
//  Подробно - Булево - Добавляет дополнительные поля информации для медиафайлов - detail
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ПолучитьИнформациюОбОбъекте(Знач Токен, Знач Путь, Знач Подробно = Ложь) Экспорт

    URL = "https://api.dropboxapi.com/2/files/get_metadata";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("path"              , Путь    , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("include_media_info", Подробно, "Булево", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);
    Ответ     = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Получить список файлов папки
// Получает список первых файлов каталога или продолжает получение следующих при указании курсора
//
// Параметры:
//  Токен    - Строка - Токен                                                                - token
//  Путь     - Строка - Путь к каталогу. Необязателен, если указан курсор                    - path
//  Подробно - Булево - Добавляет дополнительные поля информации для медиафайлов             - detail
//  Курсор   - Строка - Курсор из предыдущего запроса для получения следующего набора файлов - cursor
//
// Возвращаемое значение:
//  HTTPОтвет - Получить список файлов папки
Функция ПолучитьСписокФайловПапки(Знач Токен, Знач Путь = "", Знач Подробно = Ложь, Знач Курсор = "") Экспорт

    Если Не ЗначениеЗаполнено(Курсор) Тогда

        URL = "https://api.dropboxapi.com/2/files/list_folder";

        Параметры = Новый Структура;
        OPI_Инструменты.ДобавитьПоле("path"              , Путь      , "Строка", Параметры);
        OPI_Инструменты.ДобавитьПоле("include_media_info", Подробно  , "Булево", Параметры);

    Иначе

        URL = "https://api.dropboxapi.com/2/files/list_folder/continue";

        Параметры = Новый Структура;
        OPI_Инструменты.ДобавитьПоле("cursor", Курсор, "Строка", Параметры);

    КонецЕсли;

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Получить превью
// Получает PDF или HTML превью объекта (только для токументов)
//
// Параметры:
//  Токен - Строка - Токен          - token
//  Путь  - Строка - Путь к объекту - path
//
// Возвращаемое значение:
//  ДвоичныеДанные - превью документа
Функция ПолучитьПревью(Знач Токен, Знач Путь) Экспорт

    URL   = "https://content.dropboxapi.com/2/files/get_preview";
    Ответ = ОбработатьОбъект(Токен, URL, Путь, Истина);

    Возврат Ответ;

КонецФункции

// Загрузить файл
// Загружает файл на облачный диск
//
// Параметры:
//  Токен          - Строка                 - Токен                                   - token
//  Файл           - Строка, ДвоичныеДанные - Данные файл для загрузки                - file
//  Путь           - Строка                 - Путь сохранения на Dropbox              - path
//  Перезаписывать - Булево                 - Перезаписывать файл при конфликте путей - overwrite
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ЗагрузитьФайл(Знач Токен, Знач Файл, Знач Путь, Знач Перезаписывать = Ложь) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Файл);
    OPI_ПреобразованиеТипов.ПолучитьБулево(Перезаписывать);
    OPI_ПреобразованиеТипов.ПолучитьСтроку(Путь);

    Режим   = ?(Перезаписывать, "overwrite", "add");
    Размер  = Файл.Размер();
    Граница = 100000000;

    Если Размер > Граница Тогда
        Ответ = ЗагрузитьБольшойФайл(Токен, Файл, Путь, Режим);
    Иначе
        Ответ = ЗагрузитьМалыйФайл(Токен, Файл, Путь, Режим);
    КонецЕсли;

    Возврат Ответ;

КонецФункции

// Загрузить файл по URL
// Загружает файл на облачный диск, получая его по указанному URL
//
// Параметры:
//  Токен    - Строка - Токен                      - token
//  URLФайла - Строка - URL источник файла         - url
//  Путь     - Строка - Путь сохранения на Dropbox - path
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ЗагрузитьФайлПоURL(Знач Токен, Знач URLФайла, Знач Путь) Экспорт

    URL = "https://api.dropboxapi.com/2/files/save_url";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("path", Путь     , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("url" , URLФайла , "Строка", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);
    Ответ     = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Получить статус загрузки по URL
// Получает статус загрузки файла по URL
//
// Параметры:
//  Токен    - Строка - Токен                                              - token
//  IDРаботы - Строка - ID асинхронной работы из ответа ЗагрузитьФайлПоURL - job
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ПолучитьСтатусЗагрузкиПоURL(Знач Токен, Знач IDРаботы) Экспорт

    URL = "https://api.dropboxapi.com/2/files/save_url/check_job_status";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("async_job_id", IDРаботы, "Строка", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);
    Ответ     = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Удалить объект
// Удаляет объект с облачного диска
//
// Параметры:
//  Токен        - Строка - Токен                                        - token
//  Путь         - Строка - Путь к объекту удаления                      - path
//  БезВозвратно - Строка - Удалить объект без возможности востановления - permanently
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция УдалитьОбъект(Знач Токен, Знач Путь, Знач Безвозвратно = Ложь) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьБулево(Безвозвратно);

    Если Безвозвратно Тогда
        URL = "https://api.dropboxapi.com/2/files/permanently_delete";
    Иначе
        URL = "https://api.dropboxapi.com/2/files/delete_v2";
    КонецЕсли;

    Ответ = ОбработатьОбъект(Токен, URL, Путь);

    Возврат Ответ;

КонецФункции

// Копировать объект
// Копирует файл или каталог по выбранному пути
//
// Параметры:
//  Токен  - Строка - Токен                           - token
//  Откуда - Строка - Путь к объекту оригинала        - from
//  Куда   - Строка - Целевой путь для нового объекта - to
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция КопироватьОбъект(Знач Токен, Знач Откуда, Знач Куда) Экспорт

    URL = "https://api.dropboxapi.com/2/files/copy_v2";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("from_path", Откуда, "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("to_path"  , Куда  , "Строка", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Переместить объект
// Перемещает объект по выбранному пути
//
// Параметры:
//  Токен  - Строка - Токен                           - token
//  Откуда - Строка - Путь к объекту оригинала        - from
//  Куда   - Строка - Целевой путь для нового объекта - to
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ПереместитьОбъект(Знач Токен, Знач Откуда, Знач Куда) Экспорт

    URL = "https://api.dropboxapi.com/2/files/move_v2";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("from_path", Откуда, "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("to_path"  , Куда  , "Строка", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Создать папку
// Создает пустой каталог по выбранному пути
//
// Параметры:
//  Токен - Строка - Токен                          - token
//  Путь  - Строка - Целевой путь создания каталога - path
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция СоздатьПапку(Знач Токен, Знач Путь) Экспорт

    URL   = "https://api.dropboxapi.com/2/files/create_folder_v2";
    Ответ = ОбработатьОбъект(Токен, URL, Путь);

    Возврат Ответ;

КонецФункции

// Скачать файл
// Скачивает файл по указанному пути или ID
//
// Параметры:
//  Токен - Строка - Токен             - token
//  Путь  - Строка - Путь или ID файла - path
//
// Возвращаемое значение:
//  ДвоичныеДанные - двоичные данные файла
Функция СкачатьФайл(Знач Токен, Знач Путь) Экспорт

    URL   = "https://content.dropboxapi.com/2/files/download";
    Ответ = ОбработатьОбъект(Токен, URL, Путь, Истина);

    Возврат Ответ;

КонецФункции

// Скачать папку
// Скачивает zip архив с содержимым указанного каталога
//
// Параметры:
//  Токен - Строка - Токен                - token
//  Путь  - Строка - Путь или ID каталога - path
//
// Возвращаемое значение:
//  ДвоичныеДанные - двоичные данные zip архива с содержимым каталога
Функция СкачатьПапку(Знач Токен, Знач Путь) Экспорт

    URL   = "https://content.dropboxapi.com/2/files/download_zip";
    Ответ = ОбработатьОбъект(Токен, URL, Путь, Истина);

    Возврат Ответ;

КонецФункции

// Получить список версий объекта
// Получает список версий (ревизий) объекта
//
// Параметры:
//  Токен      - Строка        - Токен                                          - token
//  Путь       - Строка        - Путь к объекту                                 - path
//  Количество - Строка, Число - Число последних версий объекта для отображения - amount
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ПолучитьСписокВерсийОбъекта(Знач Токен, Знач Путь, Знач Количество = 10) Экспорт

    URL = "https://api.dropboxapi.com/2/files/list_revisions";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("path" , Путь      , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("limit", Количество, "Число" , Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);
    Ответ     = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Восстановить объект к версии
// Восстанавливает состояние объекта к необходимой версии (ревизии)
//
// Параметры:
//  Токен  - Строка - Токен                                 - token
//  Путь   - Строка - Путь к объекту                        - path
//  Версия - Строка - ID версии (ревизии) для востановления - rev
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ВосстановитьОбъектКВерсии(Знач Токен, Знач Путь, Знач Версия) Экспорт

    URL = "https://api.dropboxapi.com/2/files/restore";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("path", Путь  , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("rev" , Версия, "Строка", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);
    Ответ     = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

#КонецОбласти

#Область РаботаСТегами

// Получить список тегов
// Получает список тегов выбранных файлов
//
// Параметры:
//  Токен - Строка                   - Токен                          - token
//  Пути  - Строка, Массив Из Строка - Путь или набору путей к файлам - paths
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ПолучитьСписокТегов(Знач Токен, Знач Пути) Экспорт

    URL = "https://api.dropboxapi.com/2/files/tags/get";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("paths", Пути, "Массив", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Добавить тег
// Добавляет новый текстовый тег к файлу или каталогу
//
// Параметры:
//  Токен - Строка - Токен                                               - token
//  Путь  - Строка - Путь к объекту, для которого необходимо создать тег - path
//  Тег   - Строка - Текст тега                                          - tag
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ДобавитьТег(Знач Токен, Знач Путь, Знач Тег) Экспорт

    Возврат ОбработатьТег(Токен, Путь, Тег);

КонецФункции

// Удалить тег
// Удаляет текстовый тег файла или каталога
//
// Параметры:
//  Токен - Строка - Токен                                           - token
//  Путь  - Строка - Путь к объекту, тег которого необходимо удалить - path
//  Тег   - Строка - Текст тега                                      - tag
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция УдалитьТег(Знач Токен, Знач Путь, Знач Тег) Экспорт

    Возврат ОбработатьТег(Токен, Путь, Тег, Истина);

КонецФункции

#КонецОбласти

#Область НастройкиСовместногоДоступа

// Опубликовать папку
// Переводит каталог в режим публичного доступа
//
// Параметры:
//  Токен - Строка - Токен                    - token
//  Путь  - Строка - Путь к целевому каталогу - path
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ОпубликоватьПапку(Знач Токен, Знач Путь) Экспорт

    URL   = "https://api.dropboxapi.com/2/sharing/share_folder";
    Ответ = ОбработатьОбъект(Токен, URL, Путь);

    Возврат Ответ;

КонецФункции

// Отменить публикацию папки
// Отменяет режим общего доступа для каталога
//
// Параметры:
//  Токен   - Строка - Токен                                     - token
//  IDПапки - Строка - ID публичного каталога (shared folder ID) - folder
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ОтменитьПубликациюПапки(Знач Токен, Знач IDПапки) Экспорт

    URL = "https://api.dropboxapi.com/2/sharing/unshare_folder";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("shared_folder_id", IDПапки, "Строка", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);
    Ответ     = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Добавить пользователей к файлу
// Определяет доступ к файлу для сторонних пользователей
//
// Параметры:
//  Токен          - Строка                   - Токен                                                      - token
//  IDФайла        - Строка                   - ID файла, к которому предоставляется доступ                - fileid
//  АдресаПочты    - Строка, Массив Из Строка - Список адресов почты добавляемых пользователей             - emails
//  ТолькоПросмотр - Булево                   - Запрещает редактирование файла для стороннего пользователя - readonly
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ДобавитьПользователейКФайлу(Знач Токен, Знач IDФайла, Знач АдресаПочты, Знач ТолькоПросмотр = Истина) Экспорт

    Строка_ = "Строка";

    OPI_ПреобразованиеТипов.ПолучитьМассив(АдресаПочты);
    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDФайла);
    OPI_ПреобразованиеТипов.ПолучитьБулево(ТолькоПросмотр);

    Если Не СтрНачинаетсяС(IDФайла, "id:") Тогда
        IDФайла = "id:" + IDФайла;
    КонецЕсли;

    URL = "https://api.dropboxapi.com/2/sharing/add_file_member";

    МассивПользователей = Новый Массив;

    Для Каждого Адрес Из АдресаПочты Цикл

        ДанныеПользователя = Новый Соответствие;
        OPI_Инструменты.ДобавитьПоле(".tag" , "email", Строка_, ДанныеПользователя);
        OPI_Инструменты.ДобавитьПоле("email", Адрес  , Строка_, ДанныеПользователя);

        МассивПользователей.Добавить(ДанныеПользователя);

    КонецЦикла;

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("file"   , IDФайла            , Строка_ , Параметры);
    OPI_Инструменты.ДобавитьПоле("members", МассивПользователей, "Массив", Параметры);

    Режим = ?(ТолькоПросмотр, "viewer", "editor");

    OPI_Инструменты.ДобавитьПоле("access_level", Режим , Строка_, Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Добавить пользователей к папке
// Предоставляет стороннии пользователям доступ к каталогу
//
// Параметры:
//  Токен          - Строка - Токен                                                            - token
//  IDПапки        - Строка - ID публичного каталога (shared folder ID)                        - folder
//  АдресаПочты    - Строка, Массив Из Строка - Список адресов почты добавляемых пользователей - emails
//  ТолькоПросмотр - Булево - Запрещает редактирование файла для стороннего пользователя       - readonly
//
// Возвращаемое значение:
//  Неопределено - пустой ответ
Функция ДобавитьПользователейКПапке(Знач Токен, Знач IDПапки, Знач АдресаПочты, Знач ТолькоПросмотр = Истина) Экспорт

    Строка_ = "Строка";

    OPI_ПреобразованиеТипов.ПолучитьМассив(АдресаПочты);
    OPI_ПреобразованиеТипов.ПолучитьБулево(ТолькоПросмотр);
    Режим = ?(ТолькоПросмотр, "viewer", "editor");

    URL = "https://api.dropboxapi.com/2/sharing/add_folder_member";

    МассивПользователей = Новый Массив;

    Для Каждого Адрес Из АдресаПочты Цикл

        ДанныеПользователя = Новый Соответствие;
        OPI_Инструменты.ДобавитьПоле(".tag" , "email", Строка_, ДанныеПользователя);
        OPI_Инструменты.ДобавитьПоле("email", Адрес  , Строка_, ДанныеПользователя);

        СтруктураПользователя = Новый Структура("member,access_level", ДанныеПользователя, Режим);

        МассивПользователей.Добавить(СтруктураПользователя);

    КонецЦикла;

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("shared_folder_id", IDПапки             , Строка_ , Параметры);
    OPI_Инструменты.ДобавитьПоле("members"         , МассивПользователей , "Массив", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Получить статус асинхронного изменения
// Получает статус асинхронной работы по изменению доступов
//
// Параметры:
//  Токен    - Строка - Токен                 - token
//  IDРаботы - Строка - ID асинхронной работы - job
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ПолучитьСтатусАсинхронногоИзменения(Знач Токен, Знач IDРаботы) Экспорт

    URL = "https://api.dropboxapi.com/2/sharing/check_job_status";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("async_job_id", IDРаботы, "Строка", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);
    Ответ     = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Отменить публикацию файла
// Запрещает доступ к файлу для внешних пользователей
//
// Параметры:
//  Токен    - Строка - Токен                                       - token
//  IDФайла  - Строка - ID файла, к которому предоставляется доступ - fileid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Dropbox
Функция ОтменитьПубликациюФайла(Знач Токен, Знач IDФайла) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDФайла);

    Если Не СтрНачинаетсяС(IDФайла, "id:") Тогда
        IDФайла = "id:" + IDФайла;
    КонецЕсли;

    URL = "https://api.dropboxapi.com/2/sharing/unshare_file";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("file", IDФайла, "Строка", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);
    Ответ     = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОбработатьОбъект(Знач Токен, Знач URL, Знач Путь, Знач ВЗаголовках = Ложь)

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("path", Путь, "Строка", Параметры);

    Если ВЗаголовках Тогда
        Заголовки = ПолучитьЗаголовкиЗапроса(Токен, Параметры);
        Ответ     = OPI_Инструменты.PostBinary(URL, ПолучитьДвоичныеДанныеИзСтроки(""), Заголовки);
    Иначе
        Заголовки = ПолучитьЗаголовкиЗапроса(Токен);
        Ответ     = OPI_Инструменты.Post(URL, Параметры, Заголовки);
    КонецЕсли;

    Возврат Ответ;

КонецФункции

Функция ОбработатьТег(Знач Токен, Знач Путь, Знач Тег, Знач ЭтоУдаление = Ложь)

    Если ЭтоУдаление Тогда
        URL = "https://api.dropboxapi.com/2/files/tags/remove";
    Иначе
        URL = "https://api.dropboxapi.com/2/files/tags/add";
    КонецЕсли;

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("path"     , Путь, "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("tag_text" , Тег , "Строка", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

Функция ПолучитьЗаголовкиЗапроса(Знач Токен, Знач Параметры = "")

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Токен);

    Заголовки = Новый Соответствие;
    Заголовки.Вставить("Authorization"  , "Bearer " + Токен);

    Если ЗначениеЗаполнено(Параметры) Тогда

        JSON = OPI_Инструменты.JSONСтрокой(Параметры, "Нет");
        JSON = СтрЗаменить(JSON, Символы.ВК + Символы.ПС, "");

        Заголовки.Вставить("Dropbox-API-Arg", JSON);

    КонецЕсли;

    Возврат Заголовки;

КонецФункции

Функция ЗагрузитьБольшойФайл(Знач Токен, Знач Файл, Знач Путь, Знач Режим)

    URL = "https://content.dropboxapi.com/2/files/upload_session/append_v2";

    РазмерЧасти    = 100000000;
    ТекущаяПозиция = 0;
    ПрочитаноБайт  = 0;
    ОбщийРазмер    = Файл.Размер();
    Сессия         = ОткрытьСессию(Токен);

    Пока ПрочитаноБайт < ОбщийРазмер Цикл

        Отступ = ТекущаяПозиция;
        Курсор = Новый Структура("offset,session_id", Отступ, Сессия);

        Параметры = Новый Структура("cursor", Курсор);
        Заголовки = ПолучитьЗаголовкиЗапроса(Токен, Параметры);

        ЧтениеДанных     = Новый ЧтениеДанных(Файл);
        ПрочитаноБайт    = ЧтениеДанных.Пропустить(ТекущаяПозиция);
        Результат        = ЧтениеДанных.Прочитать(РазмерЧасти);
        ТекущиеДанные    = Результат.ПолучитьДвоичныеДанные();
        РазмерТекущих    = ТекущиеДанные.Размер();
        СледующаяПозиция = ТекущаяПозиция + РазмерТекущих;

        Если Не ЗначениеЗаполнено(ТекущиеДанные) Тогда
            Прервать;
        КонецЕсли;

        Ответ = OPI_Инструменты.PostBinary(URL, ТекущиеДанные, Заголовки);

        ТекущаяПозиция = СледующаяПозиция;

        КБайт = 1024;
        МБайт = КБайт * КБайт;
        OPI_Инструменты.ИнформацияОПрогрессе(ТекущаяПозиция, ОбщийРазмер, "МБ", МБайт);

        // !OInt ВыполнитьСборкуМусора();
        // !OInt ОсвободитьОбъект(ТекущиеДанные);

    КонецЦикла;

    Ответ = ЗакрытьСессию(Токен, Путь, Режим, ОбщийРазмер, Сессия);

    Возврат Ответ;

КонецФункции

Функция ЗагрузитьМалыйФайл(Знач Токен, Знач Файл, Знач Путь, Знач Режим)

    Булево_ = "Булево";
    Строка_ = "Строка";
    URL     = "https://content.dropboxapi.com/2/files/upload";

    Параметры = Новый Структура;

    OPI_Инструменты.ДобавитьПоле("autorename"     , Ложь , Булево_, Параметры);
    OPI_Инструменты.ДобавитьПоле("mode"           , Режим, Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("mute"           , Ложь , Булево_, Параметры);
    OPI_Инструменты.ДобавитьПоле("path"           , Путь , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("strict_conflict", Ложь , Булево_, Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен, Параметры);

    Ответ = OPI_Инструменты.PostBinary(URL, Файл, Заголовки);

    Возврат Ответ;

КонецФункции

Функция ОткрытьСессию(Знач Токен)

    SessionId = "session_id";
    URL       = "https://content.dropboxapi.com/2/files/upload_session/start";
    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.PostBinary(URL, ПолучитьДвоичныеДанныеИзСтроки(""), Заголовки);

    Возврат Ответ[SessionId];

КонецФункции

Функция ЗакрытьСессию(Знач Токен, Знач Путь, Знач Режим, Знач ОбщийРазмер, Знач Сессия)

    URL = "https://content.dropboxapi.com/2/files/upload_session/finish";

    Коммит = Новый Структура();
    OPI_Инструменты.ДобавитьПоле("mode", Режим, "Строка", Коммит);
    OPI_Инструменты.ДобавитьПоле("path", Путь , "Строка", Коммит);

    Курсор = Новый Структура("offset,session_id", ОбщийРазмер, Сессия);

    Параметры = Новый Структура("commit,cursor", Коммит, Курсор);
    Заголовки = ПолучитьЗаголовкиЗапроса(Токен, Параметры);

    Ответ = OPI_Инструменты.PostBinary(URL, ПолучитьДвоичныеДанныеИзСтроки(""), Заголовки);

    Возврат Ответ;

КонецФункции

Функция ПолучитьАккаунт(Знач Токен, Знач Аккаунт)

    URL = "https://api.dropboxapi.com/2/users/get_account";

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("account_id", Аккаунт, "Строка", Параметры);

    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

Функция ПолучитьСвойАккаунт(Знач Токен)

    URL       = "https://api.dropboxapi.com/2/users/get_current_account";
    Заголовки = ПолучитьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.PostBinary(URL
        , ПолучитьДвоичныеДанныеИзСтроки("null")
        , Заголовки
        ,
        , "text/plain; charset=dropbox-cors-hack");

    Возврат Ответ;

КонецФункции

#КонецОбласти
