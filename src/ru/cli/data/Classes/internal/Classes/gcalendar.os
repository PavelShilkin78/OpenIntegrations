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
    НоваяСтрока.Метод       = "СоздатьКалендарь";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬКАЛЕНДАРЬ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с метаданными календарей";
    НоваяСтрока.ОписаниеМетода   = "Создает пустой календарь";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "СоздатьКалендарь";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬКАЛЕНДАРЬ";
    НоваяСтрока.Параметр    = "--title";
    НоваяСтрока.Описание    = "Наименование создаваемого календаря";
    НоваяСтрока.Область     = "Работа с метаданными календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПолучитьМетаданныеКалендаря";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬМЕТАДАННЫЕКАЛЕНДАРЯ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с метаданными календарей";
    НоваяСтрока.ОписаниеМетода   = "Получает информацию о календаре по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПолучитьМетаданныеКалендаря";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬМЕТАДАННЫЕКАЛЕНДАРЯ";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа с метаданными календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьМетаданныеКалендаря";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬМЕТАДАННЫЕКАЛЕНДАРЯ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с метаданными календарей";
    НоваяСтрока.ОписаниеМетода   = "Изменяет свойства существуещего календаря";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьМетаданныеКалендаря";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬМЕТАДАННЫЕКАЛЕНДАРЯ";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа с метаданными календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьМетаданныеКалендаря";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬМЕТАДАННЫЕКАЛЕНДАРЯ";
    НоваяСтрока.Параметр    = "--title";
    НоваяСтрока.Описание    = "Новое наименование (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с метаданными календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьМетаданныеКалендаря";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬМЕТАДАННЫЕКАЛЕНДАРЯ";
    НоваяСтрока.Параметр    = "--description";
    НоваяСтрока.Описание    = "Новое описание календаря (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с метаданными календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ОчиститьОсновнойКалендарь";
    НоваяСтрока.МетодПоиска = "ОЧИСТИТЬОСНОВНОЙКАЛЕНДАРЬ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с метаданными календарей";
    НоваяСтрока.ОписаниеМетода   = "Очищает список событий основного календаря";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "УдалитьКалендарь";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬКАЛЕНДАРЬ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с метаданными календарей";
    НоваяСтрока.ОписаниеМетода   = "Удаляет календарь по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "УдалитьКалендарь";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬКАЛЕНДАРЬ";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа с метаданными календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПолучитьСписокКалендарей";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСПИСОККАЛЕНДАРЕЙ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа со списком календарей";
    НоваяСтрока.ОписаниеМетода   = "Получает массив календарей аккаунта";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ДобавитьКалендарьВСписок";
    НоваяСтрока.МетодПоиска = "ДОБАВИТЬКАЛЕНДАРЬВСПИСОК";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа со списком календарей";
    НоваяСтрока.ОписаниеМетода   = "Добавляет существующий календарь в список пользователя";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ДобавитьКалендарьВСписок";
    НоваяСтрока.МетодПоиска = "ДОБАВИТЬКАЛЕНДАРЬВСПИСОК";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа со списком календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПолучитьКалендарьСписка";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬКАЛЕНДАРЬСПИСКА";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа со списком календарей";
    НоваяСтрока.ОписаниеМетода   = "Получает календарь из списка пользователя по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПолучитьКалендарьСписка";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬКАЛЕНДАРЬСПИСКА";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа со списком календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "УдалитьКалендарьИзСписка";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬКАЛЕНДАРЬИЗСПИСКА";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа со списком календарей";
    НоваяСтрока.ОписаниеМетода   = "Удаляет календарь из списка пользователя";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "УдалитьКалендарьИзСписка";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬКАЛЕНДАРЬИЗСПИСКА";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа со списком календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьКалендарьСписка";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬКАЛЕНДАРЬСПИСКА";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа со списком календарей";
    НоваяСтрока.ОписаниеМетода   = "Изменяет свойства календаря из списка пользователей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьКалендарьСписка";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬКАЛЕНДАРЬСПИСКА";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа со списком календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьКалендарьСписка";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬКАЛЕНДАРЬСПИСКА";
    НоваяСтрока.Параметр    = "--primary";
    НоваяСтрока.Описание    = "HEX основного цвета (#ffffff)";
    НоваяСтрока.Область     = "Работа со списком календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьКалендарьСписка";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬКАЛЕНДАРЬСПИСКА";
    НоваяСтрока.Параметр    = "--secondary";
    НоваяСтрока.Описание    = "HEX дополнительного цвета (#ffffff)";
    НоваяСтрока.Область     = "Работа со списком календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьКалендарьСписка";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬКАЛЕНДАРЬСПИСКА";
    НоваяСтрока.Параметр    = "--hidden";
    НоваяСтрока.Описание    = "Скрытый календарь (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Работа со списком календарей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПолучитьОписаниеСобытия";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОПИСАНИЕСОБЫТИЯ";
    НоваяСтрока.Параметр    = "--empty";
    НоваяСтрока.Описание    = "Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Работа с событиями";
    НоваяСтрока.ОписаниеМетода   = "Получает пустой макет для создания события";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПолучитьСписокСобытий";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСПИСОКСОБЫТИЙ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с событиями";
    НоваяСтрока.ОписаниеМетода   = "Получает список всех событий календаря";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПолучитьСписокСобытий";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСПИСОКСОБЫТИЙ";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПолучитьСобытие";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с событиями";
    НоваяСтрока.ОписаниеМетода   = "Получает событие по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПолучитьСобытие";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПолучитьСобытие";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--event";
    НоваяСтрока.Описание    = "ID события";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "СоздатьСобытие";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с событиями";
    НоваяСтрока.ОписаниеМетода   = "Создает новое событие
    |    Структура заполнения опции --props:
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
    НоваяСтрока.Метод       = "СоздатьСобытие";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "СоздатьСобытие";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--props";
    НоваяСтрока.Описание    = "Описание события";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПереместитьСобытие";
    НоваяСтрока.МетодПоиска = "ПЕРЕМЕСТИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с событиями";
    НоваяСтрока.ОписаниеМетода   = "Перемещает событие в другой календарь";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПереместитьСобытие";
    НоваяСтрока.МетодПоиска = "ПЕРЕМЕСТИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--from";
    НоваяСтрока.Описание    = "ID календаря источника";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПереместитьСобытие";
    НоваяСтрока.МетодПоиска = "ПЕРЕМЕСТИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--to";
    НоваяСтрока.Описание    = "ID календаря приемника";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ПереместитьСобытие";
    НоваяСтрока.МетодПоиска = "ПЕРЕМЕСТИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--event";
    НоваяСтрока.Описание    = "ID события календаря источника";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьСобытие";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с событиями";
    НоваяСтрока.ОписаниеМетода   = "Изменяет существующее событие
    |    Структура заполнения опции --props:
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
    НоваяСтрока.Метод       = "ИзменитьСобытие";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьСобытие";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--props";
    НоваяСтрока.Описание    = "Новое описание события";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "ИзменитьСобытие";
    НоваяСтрока.МетодПоиска = "ИЗМЕНИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--event";
    НоваяСтрока.Описание    = "ID события";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "УдалитьСобытие";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--token";
    НоваяСтрока.Описание    = "Токен";
    НоваяСтрока.Область     = "Работа с событиями";
    НоваяСтрока.ОписаниеМетода   = "Удаляет событие по ID";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "УдалитьСобытие";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--calendar";
    НоваяСтрока.Описание    = "ID календаря";
    НоваяСтрока.Область     = "Работа с событиями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "gcalendar";
    НоваяСтрока.Модуль      = "OPI_GoogleCalendar";
    НоваяСтрока.Метод       = "УдалитьСобытие";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬСОБЫТИЕ";
    НоваяСтрока.Параметр    = "--event";
    НоваяСтрока.Описание    = "ID события";
    НоваяСтрока.Область     = "Работа с событиями";

    Возврат ТаблицаСостава;
КонецФункции

