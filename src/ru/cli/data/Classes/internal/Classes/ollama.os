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
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтвет";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Генерирует ответ по заданному текстовому запросу";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтвет";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТ";
    НоваяСтрока.Параметр    = "--model";
    НоваяСтрока.Описание    = "Имя модели";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтвет";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТ";
    НоваяСтрока.Параметр    = "--prompt";
    НоваяСтрока.Описание    = "Текст запроса";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтвет";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТ";
    НоваяСтрока.Параметр    = "--options";
    НоваяСтрока.Описание    = "Доп. параметры. См. ПолучитьСтруктуруПараметровЗапроса (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтвет";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтветВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Получает очередной ответ от модели в соответствии с историей сообщений
    |
    |    Пример указания параметра типа массив:
    |    --param ""['Val1','Val2','Val3']""
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтветВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--model";
    НоваяСтрока.Описание    = "Имя модели";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтветВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--msgs";
    НоваяСтрока.Описание    = "История сообщений. См. ПолучитьСтруктуруСообщенияКонтекста";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтветВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--options";
    НоваяСтрока.Описание    = "Доп. параметры. См. ПолучитьСтруктуруПараметровЗапроса (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтветВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруПараметровЗапроса";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУПАРАМЕТРОВЗАПРОСА";
    НоваяСтрока.Параметр    = "--empty";
    НоваяСтрока.Описание    = "Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Получает структуру дополнительных параметров для обработки запроса";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруПараметровВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУПАРАМЕТРОВВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--empty";
    НоваяСтрока.Описание    = "Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Получает структуру дополнительных параметров для обработки запроса в контексте";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруСообщенияКонтекста";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУСООБЩЕНИЯКОНТЕКСТА";
    НоваяСтрока.Параметр    = "--empty";
    НоваяСтрока.Описание    = "Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Получает структуру сообщения для списка сообщений запроса в контексте";

    Возврат ТаблицаСостава;
КонецФункции

