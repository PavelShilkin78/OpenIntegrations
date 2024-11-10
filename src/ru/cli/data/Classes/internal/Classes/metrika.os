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
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "СоздатьМетку";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬМЕТКУ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен авторизации";
    НоваяСтрока.Область     = "Управление метками";
    НоваяСтрока.ОписаниеМетода   = "Создает метку с указанным именем";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "СоздатьМетку";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬМЕТКУ";
    НоваяСтрока.Параметр    = "--title";
    НоваяСтрока.Описание    = "Наименование метки";
    НоваяСтрока.Область     = "Управление метками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "ИзменитьМетку";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬМЕТКУ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен авторизации";
    НоваяСтрока.Область     = "Управление метками";
    НоваяСтрока.ОписаниеМетода   = "Изменяет имя метки по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "ИзменитьМетку";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬМЕТКУ";
    НоваяСтрока.Параметр    = "--label";
    НоваяСтрока.Описание    = "ID метки для изменения";
    НоваяСтрока.Область     = "Управление метками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "ИзменитьМетку";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬМЕТКУ";
    НоваяСтрока.Параметр    = "--title";
    НоваяСтрока.Описание    = "Новое наименование";
    НоваяСтрока.Область     = "Управление метками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "ПолучитьМетку";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬМЕТКУ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен авторизации";
    НоваяСтрока.Область     = "Управление метками";
    НоваяСтрока.ОписаниеМетода   = "Получает метку по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "ПолучитьМетку";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬМЕТКУ";
    НоваяСтрока.Параметр    = "--label";
    НоваяСтрока.Описание    = "ID метки";
    НоваяСтрока.Область     = "Управление метками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "УдалитьМетку";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬМЕТКУ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен авторизации";
    НоваяСтрока.Область     = "Управление метками";
    НоваяСтрока.ОписаниеМетода   = "Удаляет метку по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "УдалитьМетку";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬМЕТКУ";
    НоваяСтрока.Параметр    = "--label";
    НоваяСтрока.Описание    = "ID метки для удаления";
    НоваяСтрока.Область     = "Управление метками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "ПолучитьСписокМеток";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСПИСОКМЕТОК";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен авторизации";
    НоваяСтрока.Область     = "Управление метками";
    НоваяСтрока.ОписаниеМетода   = "Получает список меток пользователя";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "СоздатьСчетчик";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬСЧЕТЧИК";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен авторизации";
    НоваяСтрока.Область     = "Управление счетчиками";
    НоваяСтрока.ОписаниеМетода   = "Создает счетчик по описанию полей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "СоздатьСчетчик";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬСЧЕТЧИК";
    НоваяСтрока.Параметр    = "--fields";
    НоваяСтрока.Описание    = "Структура счетчика. См. ПолучитьСтруктуруСчетчика";
    НоваяСтрока.Область     = "Управление счетчиками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "УдалитьСчетчик";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬСЧЕТЧИК";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен авторизации";
    НоваяСтрока.Область     = "Управление счетчиками";
    НоваяСтрока.ОписаниеМетода   = "Удаляет счетчик по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "УдалитьСчетчик";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬСЧЕТЧИК";
    НоваяСтрока.Параметр    = "--counter";
    НоваяСтрока.Описание    = "ID счетчика для удаления";
    НоваяСтрока.Область     = "Управление счетчиками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "metrika";
    НоваяСтрока.Модуль      = "OPI_YandexMetrika";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруСчетчика";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУСЧЕТЧИКА";
    НоваяСтрока.Параметр    = "--empty";
    НоваяСтрока.Описание    = "Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Управление счетчиками";
    НоваяСтрока.ОписаниеМетода   = "Получает структуру стандартных полей для создания счетчика";

    Возврат ТаблицаСостава;
КонецФункции

