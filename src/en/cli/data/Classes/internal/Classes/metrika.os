﻿Function ПолучитьСостав() Export

    CompositionTable = New ValueTable();
    CompositionTable.Columns.Add("Библиотека");
    CompositionTable.Columns.Add("Модуль");
    CompositionTable.Columns.Add("Метод");
    CompositionTable.Columns.Add("МетодПоиска");
    CompositionTable.Columns.Add("Параметр");
    CompositionTable.Columns.Add("Описание");
    CompositionTable.Columns.Add("ОписаниеМетода");
    CompositionTable.Columns.Add("Область");

    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "CreateTag";
    NewLine.МетодПоиска = "CREATETAG";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Tags management";
    NewLine.ОписаниеМетода   = "Creates a tag with the specified name";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "CreateTag";
    NewLine.МетодПоиска = "CREATETAG";
    NewLine.Параметр    = "--title";
    NewLine.Описание    = "Tag title";
    NewLine.Область     = "Tags management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "UpdateTag";
    NewLine.МетодПоиска = "UPDATETAG";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Tags management";
    NewLine.ОписаниеМетода   = "Changes the tag name by ID";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "UpdateTag";
    NewLine.МетодПоиска = "UPDATETAG";
    NewLine.Параметр    = "--label";
    NewLine.Описание    = "Tag ID to change";
    NewLine.Область     = "Tags management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "UpdateTag";
    NewLine.МетодПоиска = "UPDATETAG";
    NewLine.Параметр    = "--title";
    NewLine.Описание    = "New name";
    NewLine.Область     = "Tags management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "GetTag";
    NewLine.МетодПоиска = "GETTAG";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Tags management";
    NewLine.ОписаниеМетода   = "Gets the tag by ID";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "GetTag";
    NewLine.МетодПоиска = "GETTAG";
    NewLine.Параметр    = "--label";
    NewLine.Описание    = "Tag ID";
    NewLine.Область     = "Tags management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "DeleteTag";
    NewLine.МетодПоиска = "DELETETAG";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Tags management";
    NewLine.ОписаниеМетода   = "Deletes a tag by ID";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "DeleteTag";
    NewLine.МетодПоиска = "DELETETAG";
    NewLine.Параметр    = "--label";
    NewLine.Описание    = "ID of the tag to be deleted";
    NewLine.Область     = "Tags management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "GetTagsList";
    NewLine.МетодПоиска = "GETTAGSLIST";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Tags management";
    NewLine.ОписаниеМетода   = "Gets a list of the users tags";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "CreateCounter";
    NewLine.МетодПоиска = "CREATECOUNTER";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Counters management";
    NewLine.ОписаниеМетода   = "Creates a counter by field description";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "CreateCounter";
    NewLine.МетодПоиска = "CREATECOUNTER";
    NewLine.Параметр    = "--fields";
    NewLine.Описание    = "Counter structure. See GetCounterStructure";
    NewLine.Область     = "Counters management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "UpdateCounter";
    NewLine.МетодПоиска = "UPDATECOUNTER";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Counters management";
    NewLine.ОписаниеМетода   = "Changes counter field values by ID";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "UpdateCounter";
    NewLine.МетодПоиска = "UPDATECOUNTER";
    NewLine.Параметр    = "--counter";
    NewLine.Описание    = "Counter ID to change";
    NewLine.Область     = "Counters management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "UpdateCounter";
    NewLine.МетодПоиска = "UPDATECOUNTER";
    NewLine.Параметр    = "--fields";
    NewLine.Описание    = "Structure of fields to be changed. See GetCounterStructure";
    NewLine.Область     = "Counters management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "GetCounter";
    NewLine.МетодПоиска = "GETCOUNTER";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Counters management";
    NewLine.ОписаниеМетода   = "Gets information about the counter by ID";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "GetCounter";
    NewLine.МетодПоиска = "GETCOUNTER";
    NewLine.Параметр    = "--counter";
    NewLine.Описание    = "Counter ID";
    NewLine.Область     = "Counters management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "DeleteCounter";
    NewLine.МетодПоиска = "DELETECOUNTER";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Counters management";
    NewLine.ОписаниеМетода   = "Deletes a counter by ID";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "DeleteCounter";
    NewLine.МетодПоиска = "DELETECOUNTER";
    NewLine.Параметр    = "--counter";
    NewLine.Описание    = "Counter ID for deletion";
    NewLine.Область     = "Counters management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "RestoreCounter";
    NewLine.МетодПоиска = "RESTORECOUNTER";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Counters management";
    NewLine.ОписаниеМетода   = "Restores a previously deleted counter by ID";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "RestoreCounter";
    NewLine.МетодПоиска = "RESTORECOUNTER";
    NewLine.Параметр    = "--counter";
    NewLine.Описание    = "Counter ID for restoring";
    NewLine.Область     = "Counters management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "GetCountersList";
    NewLine.МетодПоиска = "GETCOUNTERSLIST";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Counters management";
    NewLine.ОписаниеМетода   = "Gets a list of available counters with or without filtering";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "GetCountersList";
    NewLine.МетодПоиска = "GETCOUNTERSLIST";
    NewLine.Параметр    = "--filter";
    NewLine.Описание    = "List filter. See GetCounterFilterStructure (optional, def. val. - Empty value)";
    NewLine.Область     = "Counters management";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "GetCounterStructure";
    NewLine.МетодПоиска = "GETCOUNTERSTRUCTURE";
    NewLine.Параметр    = "--empty";
    NewLine.Описание    = "True > structure with empty valuse, False > field descriptions at values (optional, def. val. - No)";
    NewLine.Область     = "Counters management";
    NewLine.ОписаниеМетода   = "Gets the structure of standard fields for counter creation";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "GetCounterFilterStructure";
    NewLine.МетодПоиска = "GETCOUNTERFILTERSTRUCTURE";
    NewLine.Параметр    = "--empty";
    NewLine.Описание    = "True > structure with empty valuse, False > field descriptions at values (optional, def. val. - No)";
    NewLine.Область     = "Counters management";
    NewLine.ОписаниеМетода   = "Gets the structure of filter fields to get the list of counters";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "GetActionsList";
    NewLine.МетодПоиска = "GETACTIONSLIST";
    NewLine.Параметр    = "--token";
    NewLine.Описание    = "Auth token";
    NewLine.Область     = "Actions management";
    NewLine.ОписаниеМетода   = "Gets the list of actions of the selected counter";


    NewLine = CompositionTable.Add();
    NewLine.Библиотека  = "metrika";
    NewLine.Модуль      = "OPI_YandexMetrika";
    NewLine.Метод       = "GetActionsList";
    NewLine.МетодПоиска = "GETACTIONSLIST";
    NewLine.Параметр    = "--counter";
    NewLine.Описание    = "Counter ID";
    NewLine.Область     = "Actions management";

    Return CompositionTable;
EndFunction

