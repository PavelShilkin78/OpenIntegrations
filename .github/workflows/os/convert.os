Функция ПолучитьСопоставлениеФайлов()

	Сопоставление = Новый Соответствие();
	ФайлыМодулей  = НайтиФайлы("./", "*.bsl", Истина);
	Признак       = "// Расположение OS: ";

	Для Каждого Файл Из ФайлыМодулей Цикл

		ТекущийФайл = Файл.ПолноеИмя;
		ТекстФайла  = Новый ТекстовыйДокумент();
		ТекстФайла.Прочитать(ТекущийФайл, "UTF-8");

		Для Н = 1 По ТекстФайла.КоличествоСтрок() Цикл

			ТекущаяСтрока = СокрЛП(ТекстФайла.ПолучитьСтроку(Н));

			Если Не ЗначениеЗаполнено(ТекущаяСтрока) Тогда
				Прервать;
			КонецЕсли;

			Если СтрНайти(ТекущаяСтрока, Признак) > 0 Тогда

				ПутьOS = СтрЗаменить(ТекущаяСтрока, Признак, "");
				ПутьOS = СокрЛП(ПутьOS);
				Сопоставление.Вставить(ТекущийФайл, ПутьOS);

			КонецЕсли;

		КонецЦикла;

	КонецЦикла;

 	Возврат Сопоставление;

КонецФункции 

Функция ПолучитьСоответствиеЗамен()

	СоответствиеЗамен = Новый Соответствие();
	СоответствиеЗамен.Вставить("// #Использовать"					, "#Использовать");
	СоответствиеЗамен.Вставить("//#Использовать" 					, "#Использовать");
	СоответствиеЗамен.Вставить("УстановитьБезопасныйРежим(Истина);"	, "");
	СоответствиеЗамен.Вставить("УстановитьБезопасныйРежим(Ложь);"	, "");
	СоответствиеЗамен.Вставить("// !OInt "						    , "");

	Возврат СоответствиеЗамен;

КонецФункции

Процедура ВыполнитьОбработку()

	ОбновитьНомерВерсии();

	Сообщить("Начало конвертации OPI -> OInt");
	Сообщить("------------------------------");
	
	Начало = ТекущаяДата();

	СоответствиеМодулей = ПолучитьСопоставлениеФайлов();

	Для Каждого ПараМодулей Из СоответствиеМодулей Цикл

		Сообщить(Символы.ПС);
		ПортироватьФайл(ПараМодулей.Ключ, ПараМодулей.Значение);

	КонецЦикла;

	Сообщить("------------------------------");
	Сообщить("Обработка завершена! Длительность - " + Строка(ТекущаяДата() - Начало));

КонецПроцедуры

#Область СлужебныеПроцедурыИФункции

Процедура ПортироватьФайл(Знач Файл1С, Знач ФайлОС)
	
	ФайлМодуля = Новый Файл(Файл1С);

	МодульОС   = Новый Файл(ФайлОС);
	ИмяМодуля  = МодульОС.Имя;

	Если ФайлМодуля.Существует() Тогда
		ВыводСообщенияПроцесса(ИмяМодуля, "Начало обработки файла");
	Иначе
		ВыводСообщенияПроцесса(ИмяМодуля, "Файл не существует. Пропускаем");
		Возврат;
	КонецЕсли;

	Модуль = ПрочитатьМодуль(Файл1С, ИмяМодуля);

	Если СтрДлина(Модуль) = 0 Тогда
		ВыводСообщенияПроцесса(ИмяМодуля, "Модуль пустой. Пропускаем");
		Возврат;
	КонецЕсли;

	ОбработатьЗаменыМодуля(ИмяМодуля, Модуль);
	ЗаписатьМодуль(ФайлОС, Модуль, ИмяМодуля);
	
КонецПроцедуры

Функция ПрочитатьМодуль(Знач ФайлМодуля, Знач ИмяМодуля)

	ВыводСообщенияПроцесса(ИмяМодуля, "Начало чтения текста модуля");

	ЧтениеТекста = Новый ЧтениеТекста(ФайлМодуля, "UTF-8");
	Модуль       = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();
	
	ВыводСообщенияПроцесса(ИмяМодуля, "Модуль прочитан. Длина - " + Строка(СтрДлина(Модуль)));
	
	Возврат Модуль;

КонецФункции

Процедура ЗаписатьМодуль(Знач ФайлМодуля, Знач Модуль, Знач ИмяМодуля)

	ВыводСообщенияПроцесса(ИмяМодуля, "Начало записи модуля");

	ТекстовыйДокумент = Новый ТекстовыйДокумент();
	ТекстовыйДокумент.УстановитьТекст(Модуль);
	ТекстовыйДокумент.Записать(ФайлМодуля);

	ВыводСообщенияПроцесса(ИмяМодуля, "Модуль записан");

КонецПроцедуры

Процедура ВыводСообщенияПроцесса(Знач ИмяФайла, Знач Действие)

	Длина = 30;

	Пока СтрДлина(ИмяФайла) < Длина Цикл
		ИмяФайла = ИмяФайла + " ";
	КонецЦикла;

	Сообщить("Конвертация | " + ИмяФайла + " | " + Действие);

КонецПроцедуры

Процедура ОбработатьЗаменыМодуля(Знач ИмяМодуля, Модуль)

	ВыводСообщенияПроцесса(ИмяМодуля, "Начало произведения замен");

	СоответствиеЗамен = ПолучитьСоответствиеЗамен();

	Для Каждого Замена Из СоответствиеЗамен Цикл
		Модуль = СтрЗаменить(Модуль, Замена.Ключ, Замена.Значение);
	КонецЦикла;

	ВыводСообщенияПроцесса(ИмяМодуля, "Окончание произведения замен");

КонецПроцедуры

Процедура ОбновитьНомерВерсии()

	ПутьПД = "./OInt/packagedef";
	ПутьКФ = "./OPI/src/Configuration/Configuration.mdo";
	Версия = "";

	ЧтениеДанныхКонфигурации = Новый ЧтениеXML();
	ЧтениеДанныхКонфигурации.ОткрытьФайл(ПутьКФ);

	Пока ЧтениеДанныхКонфигурации.Прочитать() Цикл
		Если Строка(ЧтениеДанныхКонфигурации.Имя) = "version" Тогда
			ЧтениеДанныхКонфигурации.Прочитать();
			Версия = Строка(ЧтениеДанныхКонфигурации.Значение);
			Прервать;
		КонецЕсли;
	КонецЦикла;

	Признак    = ".Версия(""";
	Packagedef = Новый ТекстовыйДокумент();
	Packagedef.Прочитать(ПутьПД);

	Для Н = 1 По Packagedef.КоличествоСтрок() Цикл

        ТекущаяСтрока = СокрЛП(Packagedef.ПолучитьСтроку(Н));
        Если СтрНайти(ТекущаяСтрока, Признак) Тогда
			Packagedef.ЗаменитьСтроку(Н, "    .Версия(""" + Версия + """)");
			Packagedef.Записать(ПутьПД);
			Возврат;
        КонецЕсли;    
    КонецЦикла;

КонецПроцедуры;

#КонецОбласти

ВыполнитьОбработку();
