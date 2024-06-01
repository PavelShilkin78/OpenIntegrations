﻿Функция ПолучитьСостав() Экспорт

    ТаблицаСостава = Новый ТаблицаЗначений();
    ТаблицаСостава.Колонки.Добавить("Библиотека");
    ТаблицаСостава.Колонки.Добавить("Модуль");
    ТаблицаСостава.Колонки.Добавить("Метод");
    ТаблицаСостава.Колонки.Добавить("МетодПоиска");
    ТаблицаСостава.Колонки.Добавить("Параметр");
    ТаблицаСостава.Колонки.Добавить("Описание");
    ТаблицаСостава.Колонки.Добавить("ОписаниеМетода");
    ТаблицаСостава.Колонки.Добавить("Область");

    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "CreateCalendar";
    НоваяСтрока.МетодПоиска = "CREATECALENDAR";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Calendar metadata management";
    НоваяСтрока.ОписаниеМетода   = "Creates an empty calendar";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "CreateCalendar";
    НоваяСтрока.МетодПоиска = "CREATECALENDAR";
    НоваяСтрока.Параметр    = "--title";
    НоваяСтрока.Описание    = "Name of the created calendar";
    НоваяСтрока.Область     = "Calendar metadata management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "GetCalendarMetadata";
    НоваяСтрока.МетодПоиска = "GETCALENDARMETADATA";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Calendar metadata management";
    НоваяСтрока.ОписаниеМетода   = "Gets calendar information by ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "GetCalendarMetadata";
    НоваяСтрока.МетодПоиска = "GETCALENDARMETADATA";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Calendar metadata management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditCalendarMetadata";
    НоваяСтрока.МетодПоиска = "EDITCALENDARMETADATA";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Calendar metadata management";
    НоваяСтрока.ОписаниеМетода   = "Edits properties of an existing calendar";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditCalendarMetadata";
    НоваяСтрока.МетодПоиска = "EDITCALENDARMETADATA";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Calendar metadata management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditCalendarMetadata";
    НоваяСтрока.МетодПоиска = "EDITCALENDARMETADATA";
    НоваяСтрока.Параметр    = "--title";
    НоваяСтрока.Описание    = "New name (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Calendar metadata management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditCalendarMetadata";
    НоваяСтрока.МетодПоиска = "EDITCALENDARMETADATA";
    НоваяСтрока.Параметр    = "--description";
    НоваяСтрока.Описание    = "New calendar description (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Calendar metadata management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ClearMainCalendar";
    НоваяСтрока.МетодПоиска = "CLEARMAINCALENDAR";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Calendar metadata management";
    НоваяСтрока.ОписаниеМетода   = "Clears the event list of the primary calendar";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "DeleteCalendar";
    НоваяСтрока.МетодПоиска = "DELETECALENDAR";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Calendar metadata management";
    НоваяСтрока.ОписаниеМетода   = "Deletes a calendar by ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "DeleteCalendar";
    НоваяСтрока.МетодПоиска = "DELETECALENDAR";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Calendar metadata management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "GetCalendarList";
    НоваяСтрока.МетодПоиска = "GETCALENDARLIST";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Calendar list management";
    НоваяСтрока.ОписаниеМетода   = "Gets an array of account calendars";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "AddCalendarToList";
    НоваяСтрока.МетодПоиска = "ADDCALENDARTOLIST";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Calendar list management";
    НоваяСтрока.ОписаниеМетода   = "Adds an existing calendar to the user's list";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "AddCalendarToList";
    НоваяСтрока.МетодПоиска = "ADDCALENDARTOLIST";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Calendar list management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "GetListCalendar";
    НоваяСтрока.МетодПоиска = "GETLISTCALENDAR";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Calendar list management";
    НоваяСтрока.ОписаниеМетода   = "Gets a calendar from the user's list by ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "GetListCalendar";
    НоваяСтрока.МетодПоиска = "GETLISTCALENDAR";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Calendar list management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "DeleteCalendarFromList";
    НоваяСтрока.МетодПоиска = "DELETECALENDARFROMLIST";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Calendar list management";
    НоваяСтрока.ОписаниеМетода   = "Removes a calendar from the user's list";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "DeleteCalendarFromList";
    НоваяСтрока.МетодПоиска = "DELETECALENDARFROMLIST";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Calendar list management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditListCalendar";
    НоваяСтрока.МетодПоиска = "EDITLISTCALENDAR";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Calendar list management";
    НоваяСтрока.ОписаниеМетода   = "Edits the properties of a calendar from the user's list";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditListCalendar";
    НоваяСтрока.МетодПоиска = "EDITLISTCALENDAR";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Calendar list management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditListCalendar";
    НоваяСтрока.МетодПоиска = "EDITLISTCALENDAR";
    НоваяСтрока.Параметр    = "--primary";
    НоваяСтрока.Описание    = "HEX primary color (#ffffff)";
    НоваяСтрока.Область     = "Calendar list management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditListCalendar";
    НоваяСтрока.МетодПоиска = "EDITLISTCALENDAR";
    НоваяСтрока.Параметр    = "--secondary";
    НоваяСтрока.Описание    = "HEX secondary color (#ffffff)";
    НоваяСтрока.Область     = "Calendar list management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditListCalendar";
    НоваяСтрока.МетодПоиска = "EDITLISTCALENDAR";
    НоваяСтрока.Параметр    = "--hidden";
    НоваяСтрока.Описание    = "Hidden calendar (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Calendar list management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "GetEventList";
    НоваяСтрока.МетодПоиска = "GETEVENTLIST";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Event management";
    НоваяСтрока.ОписаниеМетода   = "Gets the list of all calendar events";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "GetEventList";
    НоваяСтрока.МетодПоиска = "GETEVENTLIST";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "GetEvent";
    НоваяСтрока.МетодПоиска = "GETEVENT";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Event management";
    НоваяСтрока.ОписаниеМетода   = "Gets an event by ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "GetEvent";
    НоваяСтрока.МетодПоиска = "GETEVENT";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "GetEvent";
    НоваяСтрока.МетодПоиска = "GETEVENT";
    НоваяСтрока.Параметр    = "--event";
    НоваяСтрока.Описание    = "Event ID";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "CreateEvent";
    НоваяСтрока.МетодПоиска = "CREATEEVENT";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Event management";
    НоваяСтрока.ОписаниеМетода   = "Creates a new event";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "CreateEvent";
    НоваяСтрока.МетодПоиска = "CREATEEVENT";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "CreateEvent";
    НоваяСтрока.МетодПоиска = "CREATEEVENT";
    НоваяСтрока.Параметр    = "--Event description";
    НоваяСтрока.Описание    = "props";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "MoveEvent";
    НоваяСтрока.МетодПоиска = "MOVEEVENT";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Event management";
    НоваяСтрока.ОписаниеМетода   = "Moves an event to another calendar";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "MoveEvent";
    НоваяСтрока.МетодПоиска = "MOVEEVENT";
    НоваяСтрока.Параметр    = "--from";
    НоваяСтрока.Описание    = "ID of the source calendar";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "MoveEvent";
    НоваяСтрока.МетодПоиска = "MOVEEVENT";
    НоваяСтрока.Параметр    = "--to";
    НоваяСтрока.Описание    = "ID of the target calendar";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "MoveEvent";
    НоваяСтрока.МетодПоиска = "MOVEEVENT";
    НоваяСтрока.Параметр    = "--event";
    НоваяСтрока.Описание    = "ID of the source calendar event";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditEvent";
    НоваяСтрока.МетодПоиска = "EDITEVENT";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Event management";
    НоваяСтрока.ОписаниеМетода   = "Edits an existing event
    |
    |    Структура JSON данных события (параметр --props):
    |    {
    |     ""Описание""                : """", 
    |     ""Заголовок""               : """", 
    |     ""МестоПроведения""         : """", 
    |     ""ДатаНачала""              : """",
    |     ""ДатаОкончания""           : """",      
    |     ""МассивURLФайловВложений"" :           
    |         {
    |          ""НазваниеФайла1"" : ""URLФайла1"",
    |          ""НазваниеФайла2"" : ""URLФайла2"",
    |          ...
    |         },
    |     ""ОтправлятьУведомления""   : true       
    |    }
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditEvent";
    НоваяСтрока.МетодПоиска = "EDITEVENT";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditEvent";
    НоваяСтрока.МетодПоиска = "EDITEVENT";
    НоваяСтрока.Параметр    = "--props";
    НоваяСтрока.Описание    = "New event description";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "EditEvent";
    НоваяСтрока.МетодПоиска = "EDITEVENT";
    НоваяСтрока.Параметр    = "--event";
    НоваяСтрока.Описание    = "Event ID";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "DeleteEvent";
    НоваяСтрока.МетодПоиска = "DELETEEVENT";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Token";
    НоваяСтрока.Область     = "Event management";
    НоваяСтрока.ОписаниеМетода   = "Deletes an event by ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "DeleteEvent";
    НоваяСтрока.МетодПоиска = "DELETEEVENT";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "Calendar ID";
    НоваяСтрока.Область     = "Event management";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "DeleteEvent";
    НоваяСтрока.МетодПоиска = "DELETEEVENT";
    НоваяСтрока.Параметр    = "--event";
    НоваяСтрока.Описание    = "Event ID";
    НоваяСтрока.Область     = "Event management";

    Возврат ТаблицаСостава;
КонецФункции

