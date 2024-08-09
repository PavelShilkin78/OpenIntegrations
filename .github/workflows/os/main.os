#Использовать "./internal"

Перем ПутьPackagedef;
Перем ОсновнойПутьИсходников;
Перем СоответствиеЗамен;
Перем ПутьПакета;
Перем Версия;
Перем Языки;
Перем КаталогСловарей;
Перем ФайлыПеревода;
Перем ФайлыРазбораСловаря;
Перем ФайлыФорматирования;
Перем Корень;
Перем ОсновнойЯзык;
Перем КаталогWorkflow;
Перем КаталогПараметровЛок;

Процедура ПриСозданииОбъекта()

	ДанныеПроекта = ОбщиеМетоды.ПолучитьДанныеПроекта();

	// Основные
	Корень                 = ДанныеПроекта["root"];
	КаталогПакета          = ДанныеПроекта["packageSrc"];
	ОсновнойЯзык           = ДанныеПроекта["mainLang"];
	Версия                 = ДанныеПроекта["version"];
	Языки                  = ДанныеПроекта["additionalLangs"];
	КаталогСловарей        = ДанныеПроекта["dictionariesSrc"];
	КаталогWorkflow        = ДанныеПроекта["workflowsSrc"];
	КаталогПараметровЛок   = ДанныеПроекта["locVarsSrc"];

	ОсновнойПутьИсходников = Корень + ОсновнойЯзык + "/";
	ПутьПакета             = ОсновнойПутьИсходников + КаталогПакета;
	ПутьPackagedef         = ПутьПакета + "packagedef";

	// Замены для OneScript
	СоответствиеЗамен = Новый Соответствие();
	СоответствиеЗамен.Вставить("// #Использовать"					, "#Использовать");
	СоответствиеЗамен.Вставить("//#Использовать" 					, "#Использовать");
	СоответствиеЗамен.Вставить("УстановитьБезопасныйРежим(Истина);"	, "");
	СоответствиеЗамен.Вставить("УстановитьБезопасныйРежим(Ложь);"	, "");
	СоответствиеЗамен.Вставить("// !OInt "						    , "");
	
	// Файлы перевода
	ФайлыРазбораСловаря = ОпределитьНаборФайловДляСловаря();
	ФайлыПеревода       = ОпределитьНаборФайловПеревода();

КонецПроцедуры

Процедура ОсновнаяОбработка() Экспорт

	СоответствиеМодулей = МетодыКонвертации.ПолучитьСопоставлениеФайлов(ОсновнойПутьИсходников);

	МетодыВерсионирования.ОбновитьНомераВерсий(ПутьPackagedef, Версия);
	МетодыВерсионирования.ОбновитьLibConfig(СоответствиеМодулей, ПутьПакета);
	МетодыКонвертации.ПортироватьНабор(СоответствиеМодулей, СоответствиеЗамен);
	
	ЕстьНовыеСлова = МетодыСловарей.СоздатьНаборСловарей(ФайлыРазбораСловаря, Языки, КаталогСловарей);

	Если Не ЕстьНовыеСлова Тогда

		МетодыПеревода.ПеревестиПроект(КаталогСловарей, Корень, ОсновнойЯзык, Языки, ФайлыПеревода);

		ФайлыФорматирования = ОпределитьНаборФайловФорматирования();

		МетодыФорматирования.ОтформатироватьНабор(ФайлыФорматирования);

		Языки.Добавить(ОсновнойЯзык);

		МетодыCLI.СформироватьCLI(Корень, Языки);
		МетодыФормированияТестовGA.СоздатьНаборWorkflow(Языки, КаталогПараметровЛок, КаталогWorkflow);

	Иначе
		Сообщить("В словарях есть новые слова без перевода. Перевод и создание CLI не выполнено!");
	КонецЕсли;

КонецПроцедуры

Функция ОпределитьНаборФайловДляСловаря()

	ВсеФайлы       = НайтиФайлы(ОсновнойПутьИсходников, "*", Истина);
	МассивФайлов   = Новый Массив;
	
	Для Каждого ФайлПроекта Из ВсеФайлы Цикл

		Признак = 
			СтрНайти(ФайлПроекта.ПолноеИмя, "cli\data") = 0
			И СтрНайти(ФайлПроекта.ПолноеИмя, "cli/data") = 0
			И Не ФайлПроекта.ЭтоКаталог();

		Если Признак Тогда
			МассивФайлов.Добавить(ФайлПроекта);
		КонецЕсли;

	КонецЦикла;

	Возврат МассивФайлов;

КонецФункции

Функция ОпределитьНаборФайловФорматирования()
	
	// Наборы файлов
	ВсеФайлы     = НайтиФайлы(Корень, "*", Истина);
	МассивФайлов = Новый Массив;
	
	Для Каждого ФайлПроекта Из ВсеФайлы Цикл

		Признак =
			(ФайлПроекта.Расширение = ".os"
			Или ФайлПроекта.Расширение = ".bsl")
			И СтрНайти(ФайлПроекта.ПолноеИмя, "cli/") = 0
			И СтрНайти(ФайлПроекта.ПолноеИмя, "cli\") = 0;

		Если Признак Тогда
			МассивФайлов.Добавить(ФайлПроекта);
		КонецЕсли;

	КонецЦикла;

	Возврат МассивФайлов;

КонецФункции

Функция ОпределитьНаборФайловПеревода()
	
	// Наборы файлов
	ВсеФайлы     = НайтиФайлы(ОсновнойПутьИсходников, "*", Истина);
	МассивФайлов = Новый Массив;
	
	Для Каждого ФайлПроекта Из ВсеФайлы Цикл

		Признак = СтрНайти(ФайлПроекта.ПолноеИмя, "cli") = 0;

		Если Признак Тогда
			МассивФайлов.Добавить(ФайлПроекта);
		КонецЕсли;

	КонецЦикла;

	Возврат МассивФайлов;

КонецФункции

ПриСозданииОбъекта();
ОсновнаяОбработка();

