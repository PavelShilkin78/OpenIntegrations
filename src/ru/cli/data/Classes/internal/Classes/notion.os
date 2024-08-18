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
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьСтраницу";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬСТРАНИЦУ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа со страницами";
    НоваяСтрока.ОписаниеМетода   = "Создает дочернюю страницу над другой страницей-родителем";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьСтраницу";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬСТРАНИЦУ";
    НоваяСтрока.Параметр    = "--page";
    НоваяСтрока.Описание    = "ID Родителя";
    НоваяСтрока.Область     = "Работа со страницами";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьСтраницу";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬСТРАНИЦУ";
    НоваяСтрока.Параметр    = "--title";
    НоваяСтрока.Описание    = "Заголовок страницы";
    НоваяСтрока.Область     = "Работа со страницами";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьСтраницуВБазу";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬСТРАНИЦУВБАЗУ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа со страницами";
    НоваяСтрока.ОписаниеМетода   = "Создает страницу в базе-родителе
    |    Структура заполнения опции --data:
    |    {
    |     ""Имя поля БД 1""  : ""Значение1"",
    |     ""Имя поля БД 2""  : ""Значение2"",
    |     ...
    |    }
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьСтраницуВБазу";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬСТРАНИЦУВБАЗУ";
    НоваяСтрока.Параметр    = "--base";
    НоваяСтрока.Описание    = "ID родительской базы";
    НоваяСтрока.Область     = "Работа со страницами";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьСтраницуВБазу";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬСТРАНИЦУВБАЗУ";
    НоваяСтрока.Параметр    = "--data";
    НоваяСтрока.Описание    = "Соответствие свойств";
    НоваяСтрока.Область     = "Работа со страницами";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ПолучитьСтраницу";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРАНИЦУ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа со страницами";
    НоваяСтрока.ОписаниеМетода   = "Получает информацию о странице по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ПолучитьСтраницу";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРАНИЦУ";
    НоваяСтрока.Параметр    = "--page";
    НоваяСтрока.Описание    = "ID страницы";
    НоваяСтрока.Область     = "Работа со страницами";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ИзменитьСвойстваСтраницы";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСВОЙСТВАСТРАНИЦЫ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа со страницами";
    НоваяСтрока.ОписаниеМетода   = "Изменяет свойства существующей страницы
    |    Структура заполнения опции --data:
    |    {
    |     ""Имя поля БД 1""  : ""Значение1"",
    |     ""Имя поля БД 2""  : ""Значение2"",
    |     ...
    |    }
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ИзменитьСвойстваСтраницы";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСВОЙСТВАСТРАНИЦЫ";
    НоваяСтрока.Параметр    = "--page";
    НоваяСтрока.Описание    = "ID изменяемой страницы";
    НоваяСтрока.Область     = "Работа со страницами";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ИзменитьСвойстваСтраницы";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСВОЙСТВАСТРАНИЦЫ";
    НоваяСтрока.Параметр    = "--data";
    НоваяСтрока.Описание    = "Соответствие изменяемых параметров (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа со страницами";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ИзменитьСвойстваСтраницы";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСВОЙСТВАСТРАНИЦЫ";
    НоваяСтрока.Параметр    = "--icon";
    НоваяСтрока.Описание    = "URL картинки иконки страницы (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа со страницами";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ИзменитьСвойстваСтраницы";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСВОЙСТВАСТРАНИЦЫ";
    НоваяСтрока.Параметр    = "--cover";
    НоваяСтрока.Описание    = "URL картинки обложки страницы (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа со страницами";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ИзменитьСвойстваСтраницы";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСВОЙСТВАСТРАНИЦЫ";
    НоваяСтрока.Параметр    = "--archive";
    НоваяСтрока.Описание    = "Архивировать страницу или нет (булево) (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Работа со страницами";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьБазуДанных";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬБАЗУДАННЫХ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с базами данных";
    НоваяСтрока.ОписаниеМетода   = "Создает базу данных
    |    Структура заполнения опции --props:
    |    {
    |     ""Имя поля БД c обычным типом""     : ""Тип данных 1"",
    |     ""Имя поля БД с выбором значения""  : 
    |        {
    |         ""Вариант1""  : ""green"",
    |         ""Вариант2""  : ""red"",
    |         ...
    |        },
    |     ...
    |    }
    |    
    |    Доуступные типы: title(ключевой), rich_text, number, status,
    |    date, files, checkbox, url, email, phone_number, people
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьБазуДанных";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬБАЗУДАННЫХ";
    НоваяСтрока.Параметр    = "--page";
    НоваяСтрока.Описание    = "ID страницы родителя";
    НоваяСтрока.Область     = "Работа с базами данных";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьБазуДанных";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬБАЗУДАННЫХ";
    НоваяСтрока.Параметр    = "--title";
    НоваяСтрока.Описание    = "Заголовок базы данных";
    НоваяСтрока.Область     = "Работа с базами данных";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьБазуДанных";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬБАЗУДАННЫХ";
    НоваяСтрока.Параметр    = "--props";
    НоваяСтрока.Описание    = "Свойства базы данных (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с базами данных";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ПолучитьБазуДанных";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬБАЗУДАННЫХ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с базами данных";
    НоваяСтрока.ОписаниеМетода   = "Получить данные о базе данных";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ПолучитьБазуДанных";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬБАЗУДАННЫХ";
    НоваяСтрока.Параметр    = "--base";
    НоваяСтрока.Описание    = "ID базы данных";
    НоваяСтрока.Область     = "Работа с базами данных";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ИзменитьСвойстваБазы";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСВОЙСТВАБАЗЫ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с базами данных";
    НоваяСтрока.ОписаниеМетода   = "Изменяет свойства существующей базы
    |    Структура заполнения опции --props:
    |    {
    |     ""Имя поля БД c обычным типом""     : ""Тип данных 1"",
    |     ""Имя поля БД с выбором значения""  : 
    |        {
    |         ""Вариант1""  : ""green"",
    |         ""Вариант2""  : ""red"",
    |         ...
    |        },
    |     ...
    |    }
    |    
    |    Доуступные типы: title(ключевой), rich_text, number, status,
    |    date, files, checkbox, url, email, phone_number, people
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ИзменитьСвойстваБазы";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСВОЙСТВАБАЗЫ";
    НоваяСтрока.Параметр    = "--base";
    НоваяСтрока.Описание    = "ID целевой базы";
    НоваяСтрока.Область     = "Работа с базами данных";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ИзменитьСвойстваБазы";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСВОЙСТВАБАЗЫ";
    НоваяСтрока.Параметр    = "--props";
    НоваяСтрока.Описание    = "Новые или изменяемые свойства базы данных (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с базами данных";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ИзменитьСвойстваБазы";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСВОЙСТВАБАЗЫ";
    НоваяСтрока.Параметр    = "--title";
    НоваяСтрока.Описание    = "Новый заголовок базы (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с базами данных";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ИзменитьСвойстваБазы";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСВОЙСТВАБАЗЫ";
    НоваяСтрока.Параметр    = "--description";
    НоваяСтрока.Описание    = "Новое описание базы (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с базами данных";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьБлок";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬБЛОК";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с блоками";
    НоваяСтрока.ОписаниеМетода   = "Создает новый блок на основе существующего блока";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьБлок";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬБЛОК";
    НоваяСтрока.Параметр    = "--page";
    НоваяСтрока.Описание    = "ID родительского блока или страницы";
    НоваяСтрока.Область     = "Работа с блоками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьБлок";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬБЛОК";
    НоваяСтрока.Параметр    = "--block";
    НоваяСтрока.Описание    = "ID блока или сам блок образец";
    НоваяСтрока.Область     = "Работа с блоками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СоздатьБлок";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬБЛОК";
    НоваяСтрока.Параметр    = "--prev";
    НоваяСтрока.Описание    = "ID блока, после которого необходимо встаивть новый (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с блоками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ВернутьБлок";
    НоваяСтрока.МетодПоиска = "ВЕРНУТЬБЛОК";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с блоками";
    НоваяСтрока.ОписаниеМетода   = "Возвращает структуру блока по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ВернутьБлок";
    НоваяСтрока.МетодПоиска = "ВЕРНУТЬБЛОК";
    НоваяСтрока.Параметр    = "--block";
    НоваяСтрока.Описание    = "ID блока";
    НоваяСтрока.Область     = "Работа с блоками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ВернутьБлок";
    НоваяСтрока.МетодПоиска = "ВЕРНУТЬБЛОК";
    НоваяСтрока.Параметр    = "--core";
    НоваяСтрока.Описание    = "Истина > служебные поля удаляются, остается только сам блок (необяз. по ум. - Да)";
    НоваяСтрока.Область     = "Работа с блоками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ВернутьДочерниеБлоки";
    НоваяСтрока.МетодПоиска = "ВЕРНУТЬДОЧЕРНИЕБЛОКИ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с блоками";
    НоваяСтрока.ОписаниеМетода   = "Созвращает список дочерних блоков блока-родителя";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ВернутьДочерниеБлоки";
    НоваяСтрока.МетодПоиска = "ВЕРНУТЬДОЧЕРНИЕБЛОКИ";
    НоваяСтрока.Параметр    = "--block";
    НоваяСтрока.Описание    = "ID блока родителя";
    НоваяСтрока.Область     = "Работа с блоками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "УдалитьБлок";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬБЛОК";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с блоками";
    НоваяСтрока.ОписаниеМетода   = "Удаляет блок по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "УдалитьБлок";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬБЛОК";
    НоваяСтрока.Параметр    = "--block";
    НоваяСтрока.Описание    = "ID блока";
    НоваяСтрока.Область     = "Работа с блоками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "СписокПользователей";
    НоваяСтрока.МетодПоиска = "СПИСОКПОЛЬЗОВАТЕЛЕЙ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Пользователи";
    НоваяСтрока.ОписаниеМетода   = "Возвращает список пользователей рабочего пространства";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ПолучитьДанныеПользователя";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬДАННЫЕПОЛЬЗОВАТЕЛЯ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Пользователи";
    НоваяСтрока.ОписаниеМетода   = "Получает данные пользователя по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "notion";
    НоваяСтрока.Модуль      = "OPI_Notion";
    НоваяСтрока.Метод       = "ПолучитьДанныеПользователя";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬДАННЫЕПОЛЬЗОВАТЕЛЯ";
    НоваяСтрока.Параметр    = "--user";
    НоваяСтрока.Описание    = "ID целевого пользователя";
    НоваяСтрока.Область     = "Пользователи";

    Возврат ТаблицаСостава;
КонецФункции

