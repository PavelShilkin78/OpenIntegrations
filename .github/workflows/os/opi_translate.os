Перем ТаблицаСловаря;

Процедура ПриСозданииОбъекта()

	КаталогСловарей = "./service/dictionaries";
	ФайлыСловарей   = НайтиФайлы(КаталогСловарей, "*.json");

	ТаблицаСловаря = Новый ТаблицаЗначений();
	ТаблицаСловаря.Колонки.Добавить("Ключ");
	ТаблицаСловаря.Колонки.Добавить("Значение");
	ТаблицаСловаря.Колонки.Добавить("Длина");
	ТаблицаСловаря.Колонки.Добавить("ИмяМодуля");

	Для Каждого Словарь Из ФайлыСловарей Цикл

		Если Словарь.ИмяБезРасширения = "keywords" Тогда
			Продолжить;
		КонецЕсли;
		
		СоздатьЛокализацию(Словарь);
	КонецЦикла;

КонецПроцедуры

Процедура СоздатьЛокализацию(Знач Словарь)

	ПутьКСловарю = Словарь.ПолноеИмя;
	Язык         = Словарь.ИмяБезРасширения;

	ПолучитьТаблицуСловаря(ПутьКСловарю);

	КаталогИсточник = Новый Файл(".\src\ru\OPI");
	КаталогПриемник = Новый Файл(".\src\" + Язык + "\OPI");

	Если КаталогПриемник.Существует() Тогда
		УдалитьФайлы(КаталогПриемник.ПолноеИмя);
	КонецЕсли;

	СкопироватьФайлы(КаталогИсточник.ПолноеИмя, КаталогПриемник.ПолноеИмя);
	ФайлыМодулей  = НайтиФайлы(".\src\" + Язык + "\", "*", Истина);

	Для Каждого ФайлМодуля Из ФайлыМодулей Цикл

		Если ФайлМодуля.ЭтоКаталог() Тогда
			Продолжить;
		КонецЕсли;

		ПеревестиМодуль(ФайлМодуля.ПолноеИмя);
	КонецЦикла;

	ВсеФайлыЛокализации     = НайтиФайлы(".\src\" + Язык, "*", Истина);
	ОтборИменМодулей        = Новый Структура("ИмяМодуля", Истина);
	СтрокиИмен              = ТаблицаСловаря.НайтиСтроки(ОтборИменМодулей);
	УдаляемыеКаталоги       = Новый Массив;

	Для Каждого ФайлЛокализации Из ВсеФайлыЛокализации Цикл

		Если Не ФайлЛокализации.ЭтоКаталог() Тогда
			Продолжить;
		КонецЕсли;

		ТекущийПуть = ФайлЛокализации.ПолноеИмя;
		НовыйПуть   = ТекущийПуть;

		Для Каждого Имя Из СтрокиИмен Цикл
			НовыйПуть = СтрЗаменить(НовыйПуть, Имя.Ключ, Имя.Значение);
		КонецЦикла;

		ФайлНовогоПути = Новый Файл(НовыйПуть);

		Если Не ФайлНовогоПути.Существует() Тогда
			УдаляемыеКаталоги.Добавить(ТекущийПуть);
			СоздатьКаталог(НовыйПуть);
		КонецЕсли;

	КонецЦикла;
	
	Для Каждого ФайлЛокализации Из ВсеФайлыЛокализации Цикл

		Если ФайлЛокализации.ЭтоКаталог() Тогда
			Продолжить;
		КонецЕсли;

		ТекущийПуть = ФайлЛокализации.ПолноеИмя;
		НовыйПуть   = ТекущийПуть;

		Для Каждого Имя Из СтрокиИмен Цикл
			НовыйПуть = СтрЗаменить(НовыйПуть, Имя.Ключ, Имя.Значение);
		КонецЦикла;

		ФайлНовогоПути = Новый Файл(НовыйПуть);

		Если Не ФайлНовогоПути.Существует() Тогда
			ПереместитьФайл(ТекущийПуть, НовыйПуть);
		КонецЕсли;

	КонецЦикла;

	Для Каждого Каталог Из УдаляемыеКаталоги Цикл
		УдалитьФайлы(Каталог);
	КонецЦикла;

КонецПроцедуры

Процедура ПеревестиМодуль(ПутьКМодулю)

	ДокументМодуля = Новый ТекстовыйДокумент();
	ДокументМодуля.Прочитать(ПутьКМодулю, "UTF-8");

	Для Н = 1 По ДокументМодуля.КоличествоСтрок() Цикл

		ТекущаяСтрока = СокрЛП(ДокументМодуля.ПолучитьСтроку(Н));

		Если Не ЗначениеЗаполнено(ТекущаяСтрока) Тогда
			Продолжить;
		КонецЕсли;

		Пока СтрНайти(ТекущаяСтрока, "  ") <> 0 Цикл
			ТекущаяСтрока = СтрЗаменить(ТекущаяСтрока, "  ", " ");
		КонецЦикла;

		ВыводимаяСтрока = СтрЗаменить(ДокументМодуля.ПолучитьСтроку(Н), СокрЛП(ДокументМодуля.ПолучитьСтроку(Н)), ТекущаяСтрока);
		ДокументМодуля.ЗаменитьСтроку(Н, ВыводимаяСтрока);

	КонецЦикла;

	ТекстМодуля = ДокументМодуля.ПолучитьТекст();

	Для Каждого Элемент Из ТаблицаСловаря Цикл

		ТекущееЗначение = Элемент.Значение;

		Пока СтрДлина(ТекущееЗначение) < Элемент.Длина Цикл
			ТекущееЗначение = ТекущееЗначение + " ";
		КонецЦикла;

		ТекстМодуля = СтрЗаменить(ТекстМодуля, Элемент.Ключ, Элемент.Значение);
	КонецЦикла;

	ДокументМодуля.УстановитьТекст(ТекстМодуля);
	ДокументМодуля.Записать(ПутьКМодулю);

КонецПроцедуры

Процедура ПолучитьТаблицуСловаря(ПутьКСловарю)

	ТаблицаСловаря.Очистить();

	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.ОткрытьФайл(ПутьКСловарю);
	ДанныеСловаря = ПрочитатьJSON(ЧтениеJSON, Истина);
	ЧтениеJSON.Закрыть();

	Для Каждого Элемент Из ДанныеСловаря Цикл

		НоваяСтрокаСловаря = ТаблицаСловаря.Добавить();
		НоваяСтрокаСловаря.Ключ      = Элемент.Ключ;
		НоваяСтрокаСловаря.Значение  = Элемент.Значение;
		НоваяСтрокаСловаря.Длина     = СтрДлина(Элемент.Ключ);
		НоваяСтрокаСловаря.ИмяМодуля = СтрНайти(Элемент.Ключ, "OPI_") <> 0;

	КонецЦикла;

	ТаблицаСловаря.Сортировать("Длина УБЫВ");

КонецПроцедуры

Процедура СкопироватьФайлы(Знач КаталогИсточник, Знач КаталогПриемник)
	
	Если Прав(КаталогИсточник, 1) <> "\" Тогда
		КаталогИсточник = КаталогИсточник + "\";
	КонецЕсли;	
	Если Прав(КаталогПриемник, 1) <> "\" Тогда
		КаталогПриемник = КаталогПриемник + "\";
	КонецЕсли;	
	
	СоздатьКаталог(КаталогПриемник);
	
	МассивФайлов = НайтиФайлы(КаталогИсточник, "*.*", Истина);
	
	Для Каждого Файл Из МассивФайлов Цикл
		ПолноеИмяИсточник = Файл.ПолноеИмя;
		ПолноеИмяПриемник = КаталогПриемник + СтрЗаменить(Файл.ПолноеИмя, КаталогИсточник, "");
		
		Если Файл.ЭтоКаталог() Тогда
			СоздатьКаталог(ПолноеИмяПриемник);	
		Иначе
			КопироватьФайл(ПолноеИмяИсточник, ПолноеИмяПриемник);
		КонецЕсли;
	КонецЦикла;	
	
КонецПроцедуры

ПриСозданииОбъекта();