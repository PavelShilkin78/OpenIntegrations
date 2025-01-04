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
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ВыполнитьЗапросSQL";
    НоваяСтрока.МетодПоиска = "ВЫПОЛНИТЬЗАПРОСSQL";
    НоваяСтрока.Параметр    = "--sql";
    НоваяСтрока.Описание    = "Текст запроса к базе";
    НоваяСтрока.Область     = "Основные методы";
    НоваяСтрока.ОписаниеМетода   = "Выполняет произвольный SQL запрос
    |
    |    Пример указания параметра типа массив:
    |    --param ""['Val1','Val2','Val3']""
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ВыполнитьЗапросSQL";
    НоваяСтрока.МетодПоиска = "ВЫПОЛНИТЬЗАПРОСSQL";
    НоваяСтрока.Параметр    = "--params";
    НоваяСтрока.Описание    = "Массив позиционных параметров запроса (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Основные методы";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ВыполнитьЗапросSQL";
    НоваяСтрока.МетодПоиска = "ВЫПОЛНИТЬЗАПРОСSQL";
    НоваяСтрока.Параметр    = "--force";
    НоваяСтрока.Описание    = "Включает попытку получения результата, даже для не SELECT запросов (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Основные методы";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ВыполнитьЗапросSQL";
    НоваяСтрока.МетодПоиска = "ВЫПОЛНИТЬЗАПРОСSQL";
    НоваяСтрока.Параметр    = "--db";
    НоваяСтрока.Описание    = "Существующее соединение или путь к базе. In memory, если не заполнено (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Основные методы";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "СоздатьТаблицу";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬТАБЛИЦУ";
    НоваяСтрока.Параметр    = "--table";
    НоваяСтрока.Описание    = "Имя таблицы";
    НоваяСтрока.Область     = "Orm";
    НоваяСтрока.ОписаниеМетода   = "Создает пустую таблицу в базе";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "СоздатьТаблицу";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬТАБЛИЦУ";
    НоваяСтрока.Параметр    = "--cols";
    НоваяСтрока.Описание    = "Структура колонок: Ключ > имя, Значение > Тип данных";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "СоздатьТаблицу";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬТАБЛИЦУ";
    НоваяСтрока.Параметр    = "--db";
    НоваяСтрока.Описание    = "Существующее соединение или путь к базе (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ДобавитьЗаписи";
    НоваяСтрока.МетодПоиска = "ДОБАВИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--table";
    НоваяСтрока.Описание    = "Имя таблицы";
    НоваяСтрока.Область     = "Orm";
    НоваяСтрока.ОписаниеМетода   = "Добавляет записи в таблицу
    |
    |    Пример указания параметра типа массив:
    |    --param ""['Val1','Val2','Val3']""
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ДобавитьЗаписи";
    НоваяСтрока.МетодПоиска = "ДОБАВИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--rows";
    НоваяСтрока.Описание    = "Массив структур данных строк: Ключ > поле, Значение > значение поля";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ДобавитьЗаписи";
    НоваяСтрока.МетодПоиска = "ДОБАВИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--trn";
    НоваяСтрока.Описание    = "Истина > добавление записей в транзакции с откатом при ошибке (необяз. по ум. - Да)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ДобавитьЗаписи";
    НоваяСтрока.МетодПоиска = "ДОБАВИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--db";
    НоваяСтрока.Описание    = "Существующее соединение или путь к базе (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ПолучитьЗаписи";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--table";
    НоваяСтрока.Описание    = "Имя таблицы";
    НоваяСтрока.Область     = "Orm";
    НоваяСтрока.ОписаниеМетода   = "Получает записи из выбранной таблицы
    |
    |    Пример указания параметра типа массив:
    |    --param ""['Val1','Val2','Val3']""
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ПолучитьЗаписи";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--fields";
    НоваяСтрока.Описание    = "Поля для выборки (необяз. по ум. - *)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ПолучитьЗаписи";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--filter";
    НоваяСтрока.Описание    = "Массив фильтров. См. ПолучитьСтруктуруФильтраЗаписей (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ПолучитьЗаписи";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--order";
    НоваяСтрока.Описание    = "Сортировка: Ключ > поле, Значение > направление (ASC, DESC) (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ПолучитьЗаписи";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--limit";
    НоваяСтрока.Описание    = "Ограничение количества получаемых строк (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ПолучитьЗаписи";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--db";
    НоваяСтрока.Описание    = "Существующее соединение или путь к базе (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ОбновитьЗаписи";
    НоваяСтрока.МетодПоиска = "ОБНОВИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--table";
    НоваяСтрока.Описание    = "Имя таблицы";
    НоваяСтрока.Область     = "Orm";
    НоваяСтрока.ОписаниеМетода   = "Обновляет значение записей по выбранным критериям
    |
    |    Пример указания параметра типа массив:
    |    --param ""['Val1','Val2','Val3']""
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ОбновитьЗаписи";
    НоваяСтрока.МетодПоиска = "ОБНОВИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--values";
    НоваяСтрока.Описание    = "Структура значений: Ключ > поле, Значение > значение поля";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ОбновитьЗаписи";
    НоваяСтрока.МетодПоиска = "ОБНОВИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--filter";
    НоваяСтрока.Описание    = "Массив фильтров. См. ПолучитьСтруктуруФильтраЗаписей (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ОбновитьЗаписи";
    НоваяСтрока.МетодПоиска = "ОБНОВИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--db";
    НоваяСтрока.Описание    = "Существующее соединение или путь к базе (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "УдалитьЗаписи";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--table";
    НоваяСтрока.Описание    = "Имя таблицы";
    НоваяСтрока.Область     = "Orm";
    НоваяСтрока.ОписаниеМетода   = "Удаляет записи из таблицы
    |
    |    Пример указания параметра типа массив:
    |    --param ""['Val1','Val2','Val3']""
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "УдалитьЗаписи";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--filter";
    НоваяСтрока.Описание    = "Массив фильтров. См. ПолучитьСтруктуруФильтраЗаписей (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "УдалитьЗаписи";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬЗАПИСИ";
    НоваяСтрока.Параметр    = "--db";
    НоваяСтрока.Описание    = "Существующее соединение или путь к базе (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Orm";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "sqlite";
    НоваяСтрока.Модуль      = "OPI_SQLite";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруФильтраЗаписей";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУФИЛЬТРАЗАПИСЕЙ";
    НоваяСтрока.Параметр    = "--empty";
    НоваяСтрока.Описание    = "Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Orm";
    НоваяСтрока.ОписаниеМетода   = "Получает структуру шаблон для фильтрации записей в запросах ORM";

    Возврат ТаблицаСостава;
КонецФункции

