﻿// OneScript: ./OInt/core/Modules/OPI_VKTeams.os
// Lib: VKTeams
// CLI: vkteams

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

// Проверить токен
// Проверяет работоспособность токена бота
//
// Примечание:
// Метод в документации API: [GET /self/get](@teams.vk.com/botapi/#/self/get_self_get)
//
// Параметры:
//  Токен - Строка - Токен бота - token
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ПроверитьТокен(Знач Токен) Экспорт

    URL       = "/self/get";
    Параметры = НормализоватьОснову(URL, Токен);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Получить события
// Получает события бота в Polling режиме
//
// Примечание:
// Метод в документации API: [GET /events/get](@teams.vk.com/botapi/#/events/get_events_get)
//
// Параметры:
//  Токен        - Строка        - Токен бота                                   - token
//  IDПоследнего - Строка, Число - ID последнего обработанного до этого события - last
//  Таймаут      - Строка, Число - Время удержания соединения для Long Polling  - timeout
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ПолучитьСобытия(Знач Токен, Знач IDПоследнего, Знач Таймаут = 0) Экспорт

    URL             = "/events/get";
    Параметры       = НормализоватьОснову(URL, Токен);
    IDПоследнего    = OPI_Инструменты.ЧислоВСтроку(IDПоследнего);

    OPI_Инструменты.ДобавитьПоле("lastEventId", IDПоследнего, "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("pollTime"   , Таймаут     , "Строка", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Получить информацию о файле
// Получает информацию о файле по его ID
//
// Примечание:
// Метод в документации API: [GET /files/getInfo](@teams.vk.com/botapi/#/files/get_files_getInfo)
//
// Параметры:
//  Токен    - Строка        - Токен бота - token
//  IDФайла  - Строка, Число - ID Файла   - fileid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ПолучитьИнформациюОФайле(Знач Токен, Знач IDФайла) Экспорт

    URL       = "/files/getInfo";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("fileId", IDФайла , "Строка", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

#КонецОбласти

#Область ОтправкаСообщений

// Отправить текстовое сообщение
// Отправляет текстовое сообщение в чат
//
// Примечание:
// Можно упомянуть пользователя, добавив в текст его userId в следующем формате @[userId]
// Метод в документации API: [GET /messages/sendText](@teams.vk.com/botapi/#/messages/get_messages_sendText)
//
// Параметры:
//  Токен         - Строка           - Токен бота                                             - token
//  IDЧата        - Строка, Число    - ID чата для отправки сообщения                         - chatid
//  Текст         - Строка           - Текст сообщения                                        - text
//  IDЦитируемого - Строка, Число    - ID цитируемого сообщения, если необходимо              - reply
//  Клавиатура    - Массив Из Строка - Кнопки к сообщению, если необходимо                    - keyboard
//  Разметка      - Строка           - Вид разметки для текста сообщения: MarkdownV2 или HTML - parsemod
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ОтправитьТекстовоеСообщение(Знач Токен
    , Знач IDЧата
    , Знач Текст
    , Знач IDЦитируемого = 0
    , Знач Клавиатура = ""
    , Знач Разметка = "MarkdownV2") Экспорт

    Строка_ = "Строка";

    URL       = "/messages/sendText";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId"              , IDЧата       , Строка_    , Параметры);
    OPI_Инструменты.ДобавитьПоле("text"                , Текст        , Строка_    , Параметры);
    OPI_Инструменты.ДобавитьПоле("replyMsgId"          , IDЦитируемого, Строка_    , Параметры);
    OPI_Инструменты.ДобавитьПоле("inlineKeyboardMarkup", Клавиатура   , "Коллекция", Параметры);
    OPI_Инструменты.ДобавитьПоле("parseMode"           , Разметка     , Строка_    , Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Отправить файл
// Отправляет файл в чат
//
// Примечание:
// Метод в документации API: [POST /messages/sendFile](@teams.vk.com/botapi/#/messages/post_messages_sendFile)
//
// Параметры:
//  Токен    - Строка                 - Токен бота                                             - token
//  IDЧата   - Строка, Число          - ID чата для отправки файла                             - chatid
//  Файл     - ДвоичныеДанные, Строка - Файл для отправки                                      - file
//  Текст    - Строка                 - Подпись к файлу                                        - text
//  ИмяФайла - Строка                 - Отображаемое имя файла                                 - filename
//  Разметка - Строка                 - Вид разметки для текста сообщения: MarkdownV2 или HTML - parsemod
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ОтправитьФайл(Знач Токен
    , Знач IDЧата
    , Знач Файл
    , Знач Текст = ""
    , Знач ИмяФайла = ""
    , Знач Разметка = "MarkdownV2") Экспорт

    Строка_ = "Строка";

    URL       = "/messages/sendFile";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId"   , IDЧата  , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("caption"  , Текст   , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("parseMode", Разметка, Строка_, Параметры);

    Если ТипЗнч(Файл)   = Тип(Строка_) Тогда
        ФайлОбъект      = Новый Файл(Файл);
        ИспользуемоеИмя = ФайлОбъект.Имя;
    Иначе
        ИспользуемоеИмя = "file";
    КонецЕсли;

    OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Файл);
    ИспользуемоеИмя = ?(ЗначениеЗаполнено(ИмяФайла), ИмяФайла, ИспользуемоеИмя);

    Файлы = Новый Соответствие;
    Файлы.Вставить("file|" + ИспользуемоеИмя, Файл);

    Ответ = OPI_Инструменты.PostMultipart(URL, Параметры, Файлы, "");

    Возврат Ответ;

КонецФункции

// Отправить голосовое сообщение
// Отправляет аудиофайл в качестве голосового сообщения
//
// Примечание:
// Если вы хотите, чтобы клиент отображал этот файл как воспроизводимое голосовое сообщение, он должен быть в формате aac, ogg или m4a
// Метод в документации API: [POST /messages/sendVoice](@teams.vk.com/botapi/#/messages/post_messages_sendVoice)
//
// Параметры:
//  Токен         - Строка                 - Токен бота                                - token
//  IDЧата        - Строка, Число          - ID чата для отправки файла                - chatid
//  Файл          - ДвоичныеДанные, Строка - Файл для отправки                         - file
//  ТипФайла      - Строка                 - Тип аудиофайла: aac, ogg или m4a          - type
//  IDЦитируемого - Строка, Число          - ID цитируемого сообщения, если необходимо - reply
//  Клавиатура    - Массив Из Строка       - Кнопки к сообщению, если необходимо       - keyboard
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ОтправитьГолосовоеСообщение(Знач Токен
    , Знач IDЧата
    , Знач Файл
    , Знач ТипФайла = "m4a"
    , Знач IDЦитируемого = 0
    , Знач Клавиатура = "") Экспорт

    URL       = "/messages/sendVoice";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_ПреобразованиеТипов.ПолучитьСтроку(ТипФайла);

    СоответствиеMIME = Новый Соответствие;
    СоответствиеMIME.Вставить("m4a", "audio/mp4");
    СоответствиеMIME.Вставить("ogg", "audio/ogg");
    СоответствиеMIME.Вставить("aac", "audio/aac");

    OPI_Инструменты.ДобавитьПоле("chatId"              , IDЧата       , "Строка"   , Параметры);
    OPI_Инструменты.ДобавитьПоле("inlineKeyboardMarkup", Клавиатура   , "Коллекция", Параметры);
    OPI_Инструменты.ДобавитьПоле("replyMsgId"          , IDЦитируемого, "Строка"   , Параметры);

    OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Файл);

    Файлы = Новый Соответствие;
    Файлы.Вставить("file|voice", Файл);

    Ответ = OPI_Инструменты.PostMultipart(URL, Параметры, Файлы, СоответствиеMIME[ТипФайла]);

    Возврат Ответ;

КонецФункции

// Изменить текст сообщения
// Изменяет текст сущесствующего сообщения
//
// Примечание:
// Можно упомянуть пользователя, добавив в текст его userId в следующем формате @[userId]
// Метод в документации API: [GET /messages/editText](@teams.vk.com/botapi/#/messages/get_messages_editText)
//
// Параметры:
//  Токен       - Строка         - Токен бота                                             - token
//  IDЧата      - Строка, Число  - ID чата для отправки сообщения                         - chatid
//  IDСообщения - Строка, Число  - ID сообщения для редактирования                        - messageid
//  Текст       - Строка         - Новый текст сообщения                                  - text
//  Разметка    - Строка         - Вид разметки для текста сообщения: MarkdownV2 или HTML - parsemod
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ИзменитьТекстСообщения(Знач Токен
    , Знач IDЧата
    , Знач IDСообщения
    , Знач Текст
    , Знач Разметка = "MarkdownV2") Экспорт

    Строка_ = "Строка";

    URL       = "/messages/editText";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId"   , IDЧата     , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("text"     , Текст      , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("msgId"    , IDСообщения, Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("parseMode", Разметка   , Строка_, Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Удалить сообщение
// Удаляет сообщение по ID
//
// Примечание:
// Метод в документации API: [GET /messages/deleteMessages](@teams.vk.com/botapi/#/messages/get_messages_deleteMessages)
//
// Параметры:
//  Токен       - Строка         - Токен бота                      - token
//  IDЧата      - Строка, Число  - ID чата для отправки сообщения  - chatid
//  IDСообщения - Строка, Число  - ID сообщения для редактирования - messageid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция УдалитьСообщение(Знач Токен, Знач IDЧата, Знач IDСообщения) Экспорт

    URL       = "/messages/deleteMessages";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId", IDЧата     , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("msgId" , IDСообщения, "Строка", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Переслать файл
// Отправляет ранее загруженный файл по его ID
//
// Примечание:
// Метод в документации API: [GET /messages/sendFile](@teams.vk.com/botapi/#/messages/get_messages_sendFile)
//
// Параметры:
//  Токен    - Строка        - Токен бота                                             - token
//  IDЧата   - Строка, Число - ID чата для отправки файла                             - chatid
//  IDФайла  - Строка, Число - ID Файла для отправки                                  - fileid
//  Текст    - Строка        - Подпись к файлу                                        - text
//  Разметка - Строка        - Вид разметки для текста сообщения: MarkdownV2 или HTML - parsemod
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ПереслатьФайл(Знач Токен
    , Знач IDЧата
    , Знач IDФайла
    , Знач Текст = ""
    , Знач Разметка = "MarkdownV2") Экспорт

    Строка_ = "Строка";

    URL       = "/messages/sendFile";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId"    , IDЧата  , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("caption"   , Текст   , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("parseMode" , Разметка, Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("fileId"    , IDФайла , Строка_, Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Переслать голосовое сообщение
// Отправляет ранее загруженное голосовое сообщение по ID
//
// Примечание:
// Метод в документации API: [GET /messages/sendVoice](@teams.vk.com/botapi/#/messages/get_messages_sendVoice)
//
// Параметры:
//  Токен    - Строка        - Токен бота                    - token
//  IDЧата   - Строка, Число - ID чата для отправки файла    - chatid
//  IDФайла  - Строка, Число - ID Файла голосового сообщения - fileid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ПереслатьГолосовоеСообщение(Знач Токен, Знач IDЧата, Знач IDФайла) Экспорт

    URL       = "/messages/sendVoice";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId", IDЧата  , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("fileId", IDФайла , "Строка", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Переслать сообщение
// Переслыает существующее сообщение в текущий диалог
//
// Примечание:
// В IDЧатаИсточника можно передавать только chatId из событий (код из ссылки на чат не подходит)
// Метод в документации API: [GET /messages/sendText](@teams.vk.com/botapi/#/messages/get_messages_sendText)
//
// Параметры:
//  Токен           - Строка        - Токен бота                                - token
//  IDСообщения     - Строка, Число - ID оригинального сообщения                - messageid
//  IDЧатаИсточника - Строка, Число - ID чата источника оригинального сообщения - fromid
//  IDЧата          - Строка, Число - ID чата для отправки сообщения            - chatid
//  Текст           - Строка        - Дополнительный текст сообщения            - text
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ПереслатьСообщение(Знач Токен, Знач IDСообщения, Знач IDЧатаИсточника, Знач IDЧата, Знач Текст = "") Экспорт

    Строка_ = "Строка";

    URL       = "/messages/sendText";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId"       , IDЧата         , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("text"         , Текст          , Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("forwardChatId", IDЧатаИсточника, Строка_, Параметры);
    OPI_Инструменты.ДобавитьПоле("forwardMsgId" , IDСообщения    , Строка_, Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Закрепить сообщение
// Закрепляет выбранное сообщение в чате
//
// Примечание:
// Для вызова этого метода бот должен быть администратором в чате
// Метод в документации API: [GET /chats/pinMessage](@teams.vk.com/botapi/#/chats/get_chats_pinMessage)
//
// Параметры:
//  Токен       - Строка        - Токен бота                   - token
//  IDЧата      - Строка, Число - ID чата                      - chatid
//  IDСообщения - Строка, Число - ID сообщения для закрепления - messageid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ЗакрепитьСообщение(Знач Токен, Знач IDЧата, Знач IDСообщения) Экспорт

    URL       = "/chats/pinMessage";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId", IDЧата     , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("msgId" , IDСообщения, "Строка", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Открепить сообщение
// Открепляет ранее закрепленное сообщение в чате
//
// Примечание:
// Для вызова этого метода бот должен быть администратором в чате
// Метод в документации API: [GET /chats/unpinMessage](@teams.vk.com/botapi/#/chats/get_chats_unpinMessage)
//
// Параметры:
//  Токен       - Строка        - Токен бота                   - token
//  IDЧата      - Строка, Число - ID чата                      - chatid
//  IDСообщения - Строка, Число - ID сообщения для открепления - messageid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ОткрепитьСообщение(Знач Токен, Знач IDЧата, Знач IDСообщения) Экспорт

    URL       = "/chats/unpinMessage";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId", IDЧата     , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("msgId" , IDСообщения, "Строка", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Ответить на событие клавиатуры
// Возвращает ответ пользователю при нажатии на кнопку клавиатуры
//
// Примечание:
// Вызов данного метода должен использоваться в ответ на получение события callbackQuery
// Метод в документации API: [GET /messages/answerCallbackQuery](@teams.vk.com/botapi/#/messages/get_messages_answerCallbackQuery)
//
// Параметры:
//  Токен             - Строка - Токен бота                                       - token
//  IDСобытия         - Строка - Идентификатор callback query полученного ботом   - queryid
//  Текст             - Строка - Текст ответа                                     - text
//  URL               - Строка - URL, который будет открыт клиентским приложением - url
//  ЭтоПредупреждение - Булево - Отображать ответ как предупреждение (alert)      - showalert
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ОтветитьНаСобытиеКлавиатуры(Знач Токен
    , Знач IDСобытия
    , Знач Текст = ""
    , Знач URL = ""
    , Знач ЭтоПредупреждение = Ложь) Экспорт

    Строка_ = "Строка";

    URL       = "/messages/answerCallbackQuery";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("queryId"  , IDСобытия         , Строка_ , Параметры);
    OPI_Инструменты.ДобавитьПоле("text"     , Текст             , Строка_ , Параметры);
    OPI_Инструменты.ДобавитьПоле("url"      , URL               , Строка_ , Параметры);
    OPI_Инструменты.ДобавитьПоле("showAlert", ЭтоПредупреждение , "Булево", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Сформировать кнопку действия
// Формирует кнопку действия для клавиатуры сообщения (см. ОтправитьТекстовоеСообщение)
//
// Параметры:
//  Текст    - Строка - Текст кнопки                                                                 - text
//  Значение - Строка - Значение, возвращаемое в событии нажатия. Только если не заполнено URL       - data
//  URL      - Строка - URL для создания кнопки открытия страницы. Только если не заполнено Значение - url
//  Стиль    - Строка - Стиль кнопки: primary, attention или base                                    - style
//
// Возвращаемое значение:
//  Структура - Кнопка для клавиатуры
Функция СформироватьКнопкуДействия(Знач Текст, Знач Значение = "", Знач URL = "", Знач Стиль = "base") Экспорт

    Строка_ = "Строка";

    СтруктураКнопки = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("text"        , Текст   , Строка_, СтруктураКнопки);
    OPI_Инструменты.ДобавитьПоле("callbackData", Значение, Строка_, СтруктураКнопки);
    OPI_Инструменты.ДобавитьПоле("url"         , URL     , Строка_, СтруктураКнопки);
    OPI_Инструменты.ДобавитьПоле("style"       , Стиль   , Строка_, СтруктураКнопки);

    Возврат СтруктураКнопки;

КонецФункции

#КонецОбласти

#Область УправлениеЧатами

// Исключить пользователей чата
// Исключает пользователей из чата
//
// Примечание:
// Метод в документации API: [GET /chats/members/delete](@teams.vk.com/botapi/#/chats/get_chats_members_delete)
//
// Параметры:
//  Токен        - Строка                                 - Токен бота                                      - token
//  IDЧата       - Строка, Число                          - ID чата                                         - chatid
//  Пользователи - Строка, Число, Массив Из Строка, Число - Пользователь или пользователи чата для удаления - members
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ИсключитьПользователейЧата(Знач Токен, Знач IDЧата, Знач Пользователи) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьМассив(Пользователи);

    URL       = "/chats/members/delete";
    Параметры = НормализоватьОснову(URL, Токен);

    СтрокаПользователей = "";

    Для Каждого ПользовательЧата Из Пользователи Цикл

        ТекущийПользователь = OPI_Инструменты.ЧислоВСтроку(ПользовательЧата);
        СтрокаПользователей = ?(ЗначениеЗаполнено(СтрокаПользователей), СтрокаПользователей + ",", "[");

        СтрокаПользователей = СтрокаПользователей
            + "{""sn"":"""
            + ТекущийПользователь
            + """}";

    КонецЦикла;

    СтрокаПользователей = СтрокаПользователей + "]";

    OPI_Инструменты.ДобавитьПоле("chatId" , IDЧата             , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("members", СтрокаПользователей, "Строка", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Изменить аватар чата
// Изменяет картинку аватар чата
//
// Примечание:
// Метод в документации API: [POST ​/chats​/avatar​/set](@teams.vk.com/botapi/#/chats/post_chats_avatar_set)
//
// Параметры:
//  Токен  - Строка                 - Токен бота    - token
//  IDЧата - Строка, Число          - ID чата       - chatid
//  Файл   - ДвоичныеДанные, Строка - Файл картинки - file
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ИзменитьАватарЧата(Знач Токен, Знач IDЧата, Знач Файл) Экспорт

    URL       = "/chats/avatar/set";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId", IDЧата, "Строка", Параметры);

    OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Файл);

    Файлы = Новый Соответствие;
    Файлы.Вставить("image|image", Файл);

    Ответ = OPI_Инструменты.PostMultipart(URL, Параметры, Файлы, "image/xyz");

    Возврат Ответ;

КонецФункции

// Получить информацию о чате
// Получает основную информацию о чате
//
// Примечание:
// Метод в документации API: [GET /chats/getInfo](@teams.vk.com/botapi/#/chats/get_chats_getInfo)
//
// Параметры:
//  Токен  - Строка        - Токен бота    - token
//  IDЧата - Строка, Число - ID чата       - chatid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ПолучитьИнформациюОЧате(Знач Токен, Знач IDЧата) Экспорт

    Метод = "/chats/getInfo";
    Ответ = ПолучитьДанныеЧата(Токен, IDЧата, Метод);

    Возврат Ответ;

КонецФункции

// Получить администраторов чата
// Получает список администраторов чата
//
// Примечание:
// Метод в документации API: [GET /chats/getAdmins](@teams.vk.com/botapi/#/chats/get_chats_getAdmins)
//
// Параметры:
//  Токен  - Строка        - Токен бота    - token
//  IDЧата - Строка, Число - ID чата       - chatid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ПолучитьАдминистраторовЧата(Знач Токен, Знач IDЧата) Экспорт

    Метод = "/chats/getAdmins";
    Ответ = ПолучитьДанныеЧата(Токен, IDЧата, Метод);

    Возврат Ответ;

КонецФункции

// Получить пользователей чата
// Получает список пользователей чата
//
// Примечание:
// Метод в документации API: [GET /chats/getMembers](@teams.vk.com/botapi/#/chats/get_chats_getMembers)
//
// Параметры:
//  Токен  - Строка        - Токен бота                                       - token
//  IDЧата - Строка, Число - ID чата                                          - chatid
//  Курсор - Строка        - Маркер продолжения списка из предыдущего запроса - cursor
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ПолучитьПользователейЧата(Знач Токен, Знач IDЧата, Знач Курсор = "") Экспорт

    Метод = "/chats/getMembers";
    Ответ = ПолучитьДанныеЧата(Токен, IDЧата, Метод, Курсор);

    Возврат Ответ;

КонецФункции

// Получить заблокированных пользователей чата
// Получает список заблокированных пользователей чата
//
// Примечание:
// Для вызова этого метода бот должен быть администратором в чате.
// Метод в документации API: [GET ​/chats​/getBlockedUsers](@teams.vk.com/botapi/#/chats/get_chats_getBlockedUsers)
//
// Параметры:
//  Токен  - Строка        - Токен бота - token
//  IDЧата - Строка, Число - ID чата    - chatid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ПолучитьЗаблокированныхПользователейЧата(Знач Токен, Знач IDЧата) Экспорт

    Метод = "/chats/getBlockedUsers";
    Ответ = ПолучитьДанныеЧата(Токен, IDЧата, Метод);

    Возврат Ответ;

КонецФункции

// Получить запросы вступления чата
// Получает список запросов на вступление в чат
//
// Примечание:
// Для вызова этого метода бот должен быть администратором в чате.
// Метод в документации API: [GET ​​/chats​/getPendingUsers](@teams.vk.com/botapi/#/chats/get_chats_getPendingUsers)
//
// Параметры:
//  Токен  - Строка        - Токен бота - token
//  IDЧата - Строка, Число - ID чата    - chatid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ПолучитьЗапросыВступленияЧата(Знач Токен, Знач IDЧата) Экспорт

    Метод = "/chats/getPendingUsers";
    Ответ = ПолучитьДанныеЧата(Токен, IDЧата, Метод);

    Возврат Ответ;

КонецФункции

// Заблокировать пользователя чата
// Блокирует выбранного пользователя в чате
//
// Примечание:
// Для вызова этого метода бот должен быть администратором в чате.
// Метод в документации API: [GET ​​/chats​/blockUser](@teams.vk.com/botapi/#/chats/get_chats_blockUser)
//
// Параметры:
//  Токен                     - Строка        - Токен бота                                    - token
//  IDЧата                    - Строка, Число - ID чата                                       - chatid
//  IDПользователя            - Строка, Число - ID пользователя для блокировки                - userid
//  УдалитьПоследниеСообщения - Булево        - Удалить последние сообщения перед блокировкой - dellast
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ЗаблокироватьПользователяЧата(Знач Токен
    , Знач IDЧата
    , Знач IDПользователя
    , Знач УдалитьПоследниеСообщения = Ложь) Экспорт

    URL       = "/chats/blockUser";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId"         , IDЧата                   , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("userId"         , IDПользователя           , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("delLastMessages", УдалитьПоследниеСообщения, "Булево", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Разблокировать пользователя чата
// Разблокирует ранее заблокированного пользователя в чате
//
// Примечание:
// Для вызова этого метода бот должен быть администратором в чате.
// Метод в документации API: [GET ​​/chats/unblockUser](@teams.vk.com/botapi/#/chats/get_chats_unblockUser)
//
// Параметры:
//  Токен          - Строка        - Токен бота      - token
//  IDЧата         - Строка, Число - ID чата         - chatid
//  IDПользователя - Строка, Число - ID пользователя - userid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция РазблокироватьПользователяЧата(Знач Токен, Знач IDЧата, Знач IDПользователя) Экспорт

    URL       = "/chats/unblockUser";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId", IDЧата        , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("userId", IDПользователя, "Строка", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

// Одобрить заявку на вступление
// Подтверждает вступление пользователя в закрытый чат
//
// Примечание:
// Для вызова этого метода бот должен быть администратором в чате.
// Метод в документации API: [GET ​​/chats/resolvePending](@teams.vk.com/botapi/#/chats/get_chats_resolvePending)
//
// Параметры:
//  Токен          - Строка        - Токен бота                                              - token
//  IDЧата         - Строка, Число - ID чата                                                 - chatid
//  IDПользователя - Строка, Число - ID пользователя. Ответ на все заявки, если не заполнено - userid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ОдобритьЗаявкуНаВступление(Знач Токен, Знач IDЧата, Знач IDПользователя = "") Экспорт

    Ответ = ОтветитьНаЗаявкуНаВступление(Токен, IDЧата, Истина, IDПользователя);

    Возврат Ответ;

КонецФункции

// Отклонить заявку на вступление
// Отклоняет вступление пользователя в закрытый чат
//
// Примечание:
// Для вызова этого метода бот должен быть администратором в чате.
// Метод в документации API: [GET ​​/chats/resolvePending](@teams.vk.com/botapi/#/chats/get_chats_resolvePending)
//
// Параметры:
//  Токен          - Строка        - Токен бота                                              - token
//  IDЧата         - Строка, Число - ID чата                                                 - chatid
//  IDПользователя - Строка, Число - ID пользователя. Ответ на все заявки, если не заполнено - userid
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция ОтклонитьЗаявкуНаВступление(Знач Токен, Знач IDЧата, Знач IDПользователя = "") Экспорт

    Ответ = ОтветитьНаЗаявкуНаВступление(Токен, IDЧата, Ложь, IDПользователя);

    Возврат Ответ;

КонецФункции

// Установить заголовок чата
// Устанавливает новый заголовок чата
//
// Примечание:
// Для вызова этого метода бот должен быть администратором в чате.
// Метод в документации API: [GET ​​/chats/setTitle](@teams.vk.com/botapi/#/chats/get_chats_setTitle)
//
// Параметры:
//  Токен   - Строка        - Токен бота      - token
//  IDЧата  - Строка, Число - ID чата         - chatid
//  Текст   - Строка        - Текст заголовка - text
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция УстановитьЗаголовокЧата(Знач Токен, Знач IDЧата, Знач Текст) Экспорт

    Ответ = ИзменитьПараметрыЧата(Токен, IDЧата, "title", Текст);

    Возврат Ответ;

КонецФункции

// Установить описание чата
// Устанавливает новое описание чата
//
// Примечание:
// Для вызова этого метода бот должен быть администратором в чате.
// Метод в документации API: [GET ​​/chats/setAbout](@teams.vk.com/botapi/#/chats/get_chats_setAbout)
//
// Параметры:
//  Токен   - Строка        - Токен бота     - token
//  IDЧата  - Строка, Число - ID чата        - chatid
//  Текст   - Строка        - Текст описания - text
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция УстановитьОписаниеЧата(Знач Токен, Знач IDЧата, Знач Текст) Экспорт

    Ответ = ИзменитьПараметрыЧата(Токен, IDЧата, "about", Текст);

    Возврат Ответ;

КонецФункции

// Установить правила чата
// Устанавливает новые правила чата
//
// Примечание:
// Для вызова этого метода бот должен быть администратором в чате.
// Метод в документации API: [GET /chats/setRules](@teams.vk.com/botapi/#/chats/get_chats_setRules)
//
// Параметры:
//  Токен   - Строка        - Токен бота     - token
//  IDЧата  - Строка, Число - ID чата        - chatid
//  Текст   - Строка        - Текст правил   - text
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от VK Teams
Функция УстановитьПравилаЧата(Знач Токен, Знач IDЧата, Знач Текст) Экспорт

    Ответ = ИзменитьПараметрыЧата(Токен, IDЧата, "rules", Текст);

    Возврат Ответ;

КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция НормализоватьОснову(URL, Знач Токен)

    URL       = "https://myteam.mail.ru/bot/v1" + URL;
    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("token", Токен, "Строка", Параметры);

    Возврат Параметры;

КонецФункции

Функция ПолучитьДанныеЧата(Знач Токен, Знач IDЧата, Знач Метод, Знач Курсор = "")

    URL       = Метод;
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId", IDЧата, "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("cursor", Курсор, "Строка", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

Функция ОтветитьНаЗаявкуНаВступление(Знач Токен, Знач IDЧата, Знач Ответ, Знач IDПользователя = "")

    URL       = "/chats/resolvePending";
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId" , IDЧата, "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("approve", Ответ , "Булево", Параметры);

    Если ЗначениеЗаполнено(IDПользователя) Тогда
        OPI_Инструменты.ДобавитьПоле("userId"  , IDПользователя, "Строка", Параметры);
    Иначе
        OPI_Инструменты.ДобавитьПоле("everyone", Истина        , "Булево", Параметры);
    КонецЕсли;

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

Функция ИзменитьПараметрыЧата(Знач Токен, Знач IDЧата, Знач Параметр, Знач Значение)

    URL       = "/chats/set" + ТРег(Параметр);
    Параметры = НормализоватьОснову(URL, Токен);

    OPI_Инструменты.ДобавитьПоле("chatId", IDЧата  , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле(Параметр, Значение, "Строка", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры);

    Возврат Ответ;

КонецФункции

#КонецОбласти
