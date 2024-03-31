#Использовать "../../data"

Перем СоответствиеТаблицПараметров Экспорт;
Перем СоответствиеКомандМодулей Экспорт;

Процедура ПриСозданииОбъекта()
    
    СоответствиеТаблицПараметров = Новый Соответствие();
    СоответствиеКомандМодулей    = Новый Соответствие();

    ТаблицаСостава               = СоставБиблиотеки.ПолучитьСостав();
    ТекущаяБиблиотека            = "";
    ТекущаяТаблица               = "";

    Для Каждого СтрокаСостава Из ТаблицаСостава Цикл

        Если ТекущаяБиблиотека <> СтрокаСостава.Библиотека Тогда
            
            Если ЗначениеЗаполнено(ТекущаяБиблиотека) Тогда
                СоответствиеТаблицПараметров.Вставить(ТекущаяБиблиотека, ТекущаяТаблица);
            КонецЕсли;

            ТекущаяБиблиотека = СтрокаСостава.Библиотека;
            ТекущаяТаблица    = ПолучитьПустуюТаблицуПараметров();
            СоответствиеКомандМодулей.Вставить(СтрокаСостава.Библиотека, СтрокаСостава.Модуль);

        КонецЕсли;

        ЗаполнитьЗначенияСвойств(ТекущаяТаблица.Добавить(), СтрокаСостава);

    КонецЦикла;

    Если ЗначениеЗаполнено(ТекущаяБиблиотека) Тогда
        СоответствиеТаблицПараметров.Вставить(ТекущаяБиблиотека, ТекущаяТаблица);
    КонецЕсли;
    
КонецПроцедуры

#Область СлужебныйПрограммныйИнтерфейс

Функция ПолучитьПустуюТаблицуПараметров() Экспорт
    
    ТПМ = Новый ТаблицаЗначений();
    
    ТПМ.Колонки.Добавить("Модуль");
    ТПМ.Колонки.Добавить("Метод");
    ТПМ.Колонки.Добавить("МетодПоиска");
    ТПМ.Колонки.Добавить("Параметр");
    ТПМ.Колонки.Добавить("Описание");
    ТПМ.Колонки.Добавить("ОписаниеМетода");
 
    Возврат ТПМ;

КонецФункции

#КонецОбласти
