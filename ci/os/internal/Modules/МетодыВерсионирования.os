#Область СлужебныйПрограммныйИнтерфейс

Процедура ОбновитьНомераВерсий(Знач ПутьPackagedef, Знач Версия) Экспорт

	Признак    = ".Версия(""";
	Packagedef = Новый ТекстовыйДокумент();
	Packagedef.Прочитать(ПутьPackagedef);

	Для Н = 1 По Packagedef.КоличествоСтрок() Цикл

        ТекущаяСтрока = СокрЛП(Packagedef.ПолучитьСтроку(Н));
        Если СтрНайти(ТекущаяСтрока, Признак) Тогда
			Packagedef.ЗаменитьСтроку(Н, "    .Версия(""" + Версия + """)");
			Packagedef.Записать(ПутьPackagedef);
			Возврат;
        КонецЕсли;    
    КонецЦикла;

КонецПроцедуры

Процедура ОбновитьLibConfig(Знач СоответствиеКовертации, Знач ПутьПакета) Экспорт

	Документ = Новый ТекстовыйДокумент();
	Документ.ДобавитьСтроку("<package-def>");

	Макет = "    <module name=""%1"" file=""%2""/>";

	Для Каждого Модуль Из СоответствиеКовертации Цикл

		ТекущийМодуль = Модуль.Значение;
		ФайлМодуля    = Новый Файл(ТекущийМодуль);
		ПутьМодуля    = СтрЗаменить(ТекущийМодуль, ПутьПакета, "");
		Бибилотека    = ФайлМодуля.ИмяБезРасширения;

		Если Бибилотека = "OPI_Тесты" Или  Бибилотека = "OPI_ТестыCLI" Тогда
			Продолжить;
		КонецЕсли;

		ТекущаяСтрока = СтрШаблон(Макет, Бибилотека, СокрЛП(ПутьМодуля));
		Документ.ДобавитьСтроку(ТекущаяСтрока);

	КонецЦикла;

	ТекущаяСтрока = СтрШаблон(Макет, "LibraryComposition", СокрЛП("data/Classes/LibraryComposition.os"));
	Документ.ДобавитьСтроку(ТекущаяСтрока);
	
	Документ.ДобавитьСтроку("</package-def>");
	Документ.Записать(ПутьПакета + "lib.config");

КонецПроцедуры

#КонецОбласти