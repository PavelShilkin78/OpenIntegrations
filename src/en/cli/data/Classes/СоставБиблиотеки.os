﻿#Использовать "./internal"

Функция ПолучитьВерсию() Экспорт
  Возврат "1.11.1";
КонецФункции

Функция ПолучитьСоответствиеКомандМодулей() Экспорт
СоответствиеКомандМодулей  = Новый Соответствие();
СоответствиеКомандМодулей.Вставить("slack", "OPI_Slack");
СоответствиеКомандМодулей.Вставить("dropbox", "OPI_Dropbox");
СоответствиеКомандМодулей.Вставить("twitter", "OPI_Twitter");
СоответствиеКомандМодулей.Вставить("telegram", "OPI_Telegram");
СоответствиеКомандМодулей.Вставить("bitrix24", "OPI_Bitrix24");
СоответствиеКомандМодулей.Вставить("gsheets", "OPI_GoogleSheets");
СоответствиеКомандМодулей.Вставить("yadisk", "OPI_YandexDisk");
СоответствиеКомандМодулей.Вставить("gcalendar", "OPI_GoogleCalendar");
СоответствиеКомандМодулей.Вставить("gdrive", "OPI_GoogleDrive");
СоответствиеКомандМодулей.Вставить("viber", "OPI_Viber");
СоответствиеКомандМодулей.Вставить("yandex", "OPI_YandexID");
СоответствиеКомандМодулей.Вставить("airtable", "OPI_Airtable");
СоответствиеКомандМодулей.Вставить("google", "OPI_GoogleWorkspace");
СоответствиеКомандМодулей.Вставить("notion", "OPI_Notion");
СоответствиеКомандМодулей.Вставить("vk", "OPI_VK");
СоответствиеКомандМодулей.Вставить("tools", "Утилиты");
Возврат СоответствиеКомандМодулей;
КонецФункции



Функция ПолучитьСостав(Знач Команда) Экспорт
    ТекущийСостав = Новый(Команда);
    Возврат ТекущийСостав.ПолучитьСостав();
КонецФункции

Функция ПолучитьПолныйСостав() Экспорт

    ОбщаяТаблица = Неопределено;

    Для Каждого Команда Из ПолучитьСоответствиеКомандМодулей() Цикл

        ТекущаяТаблица = ПолучитьСостав(Команда.Ключ);
        
        Если ОбщаяТаблица = Неопределено Тогда
            ОбщаяТаблица = ТекущаяТаблица;
        Иначе
            Для Каждого СтрокаТаблицы Из ТекущаяТаблица Цикл
                ЗаполнитьЗначенияСвойств(ОбщаяТаблица.Добавить(), СтрокаТаблицы);
            КонецЦикла;
        КонецЕсли;

    КонецЦикла;

    Возврат ОбщаяТаблица;

КонецФункции
