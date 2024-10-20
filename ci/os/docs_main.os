#Использовать osparser
#Использовать cmdline

Перем ТекущийМодуль;
Перем Парсер;
Перем Расположение;
Перем СПодкаталогами;
Перем КаталогДокументации;
Перем КаталогЛокализации;
Перем КаталогЛогов;
Перем КаталогПримеров;
Перем КаталогЗначений;
Перем КаталогCLI;
Перем СписокОбластей;
Перем ТекущаяОбласть;
Перем СчетчикОбласти;
Перем Словарь;
Перем Транслитация;
Перем СчетчикБиблиотеки;
Перем СоответствиеЗаголовков;
Перем СоответствиеТестов;
Перем ТекущийЯзык;
Перем ТекущаяБиблиотека;
Перем КаталогИнструкцийОригинал;
Перем КаталогИнструкцийЛокализация;

Процедура ПриСозданииОбъекта()  

	Языки = Новый Массив();
	Языки.Добавить("ru");
	Языки.Добавить("en");

	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.ОткрытьФайл("./service/dictionaries/en.json");
	Словарь = ПрочитатьJSON(ЧтениеJSON, Истина);
	ЧтениеJSON.Закрыть();

	КаталогИнструкцийОригинал = "./docs/ru/md/Instructions";

	Для Каждого Язык Из Языки Цикл

		ТекущийЯзык         = Язык;
		Расположение        = "./src/" + Язык + "/OInt";
		СПодкаталогами      = Истина;
		КаталогДокументации = "./docs/" + Язык + "/md";
		//КаталогЛокализации  = "./docs/en/md";
		КаталогЛогов        = "./docs/" + Язык + "/results/";
		КаталогПримеров     = "./docs/" + Язык + "/examples/";
		КаталогЗначений     = "./docs/" + Язык + "/data/";
		КаталогCLI          = "./docs/" + Язык + "/cli/NEW_CLI/";
		СписокОбластей      = Новый СписокЗначений();
		ТекущаяОбласть      = "";
		СчетчикОбласти      = 0;

		КаталогИнструкцийЛокализация = "./docs/" + Язык + "/md/Instructions";

		СоответствиеЗаголовков = Новый Соответствие();
		ОчиститьКаталогиДокументов();


		ПолучитьТаблицуТранслитации();
		ПроверитьСоздатьКаталог(КаталогДокументации);
		СоздатьФайлыДокументации();

	КонецЦикла;

КонецПроцедуры

#Область СлужебныеПроцедурыИФункции

#Область ФормированиеДокументации

Процедура СоздатьФайлыДокументации()

    ОбщийМассивМодулей = Новый Массив;
	ФайлыМодулей       = НайтиФайлы(Расположение, "*.os", СПодкаталогами);

	Для Каждого Модуль Из ФайлыМодулей Цикл

		Если Модуль.ИмяБезРасширения = "OPI_YandexID" 
			Или Модуль.ИмяБезРасширения = "OPI_GoogleWorkspace" Тогда
			Продолжить;
		КонецЕсли;
		
		ОбщийМассивМодулей.Добавить(Модуль);
	КонецЦикла;

    Для Каждого Модуль Из ОбщийМассивМодулей Цикл

        ТекущийМодуль = Новый ТекстовыйДокумент();
		ТекущийМодуль.Прочитать(Модуль.ПолноеИмя);
        РазобратьМодуль(ТекущийМодуль, Модуль.ИмяБезРасширения);
	  
    КонецЦикла;

КонецПроцедуры

Процедура СоздатьСтраницуДокументации(СтруктураМетода, Счетчик = 1)

	Раздел    = СтрЗаменить(СтруктураМетода["Каталог"], "_", "");
	Результат = ПолучитьРезультатМетода(Раздел, СтруктураМетода["ИмяМетода"]);
	Область   = СтруктураМетода["Область"];

	Если ТекущаяОбласть <> Область Тогда
		ТекущаяОбласть = Область;
		СчетчикОбласти = 1;
		СчетчикБиблиотеки = СчетчикБиблиотеки + 1;
	КонецЕсли;

	ТранслитированноеИмя     = ПеревестиИмя(СтруктураМетода["ИмяМетода"]);
	ТранслитированнаяОбласть = ПеревестиИмя(Область);

	ТранслитированноеИмя     = СтрЗаменить(Синонимайзер(ТранслитированноеИмя), " ", "-");
	ТранслитированнаяОбласть = СтрЗаменить(Синонимайзер(ТранслитированнаяОбласть), " ", "-");

	СинонимОбласти   = СтрЗаменить(ТранслитированнаяОбласть, "-", " ");
	ЗаголовокОбласти = Синонимайзер(Область);

	СоответствиеЗаголовков.Вставить(ЗаголовокОбласти, СинонимОбласти);
	
	ИмяМодуляБезПрефикса     = СтрЗаменить(СтруктураМетода["ИмяМодуля"], "OPI_", "");

	КаталогБиблиотеки = КаталогДокументации + "/" + СтруктураМетода["Каталог"];
	КаталогОбласти    = КаталогБиблиотеки + "/" + ТранслитированнаяОбласть;
	КаталогКартинок   = КаталогОбласти + "/" + "img";
	ПутьДанных        = КаталогЗначений + ИмяМодуляБезПрефикса + "/" + СтруктураМетода["ИмяМетода"] + ".json";
	ФайлДанных        = Новый Файл(ПутьДанных);

	Если ФайлДанных.Существует() Тогда
		ЧтениеJSON = Новый ЧтениеJSON();
		ЧтениеJSON.ОткрытьФайл(ПутьДанных);
		СтруктураЗначений = ПрочитатьJSON(ЧтениеJSON, Истина);
		ЧтениеJSON.Закрыть();
	Иначе
		СтруктураЗначений = Новый Соответствие();
	КонецЕсли;

	ПроверитьСоздатьКаталог(КаталогБиблиотеки);
	ПроверитьСоздатьКаталог(КаталогОбласти);
	ПроверитьСоздатьКаталог(КаталогКартинок);

	СтруктураКатегории = Новый Структура("label,position", ЗаголовокОбласти, Строка(СчетчикБиблиотеки));
	ФайлКатегории      = КаталогОбласти + "/_category_.json";

	Запись = Новый ЗаписьJSON;
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто);
	Запись.ОткрытьФайл(ФайлКатегории, , , ПараметрыЗаписиJSON);
	ЗаписатьJSON(Запись, СтруктураКатегории);
	Запись.Закрыть();
	
	Макет = Новый ТекстовыйДокумент();
	Макет.Прочитать("./service/templates/doc_" + ТекущийЯзык + ".md", "UTF-8");

	Макет = Макет.ПолучитьТекст();

	Макет = СтрЗаменить(Макет, "@Счетчик"             , Строка(СчетчикОбласти));
	Макет = СтрЗаменить(Макет, "@Заголовок"           , СтруктураМетода["Заголовок"]);
	Макет = СтрЗаменить(Макет, "@Описание"            , СтруктураМетода["Описание"]);
	Макет = СтрЗаменить(Макет, "@Объявление"          , СтруктураМетода["Объявление"]);
	Макет = СтрЗаменить(Макет, "@ВозвращаемоеЗначение", СтруктураМетода["ВозвращаемоеЗначение"]);
	Макет = СтрЗаменить(Макет, "@Результат"           , Результат);
	Макет = СтрЗаменить(Макет, "@Примечание"          , СтруктураМетода["Примечание"]);

	ТаблицаПараметров = "";
	Вызов1С           = ПолучитьВызов1С(СтруктураМетода["ИмяМодуля"], СтруктураМетода["ИмяМетода"]);
	ВызовCLI          = ПолучитьВызовCLI(СтруктураМетода);
	
	Для каждого ПараметрМетода Из СтруктураМетода["Параметры"] Цикл
			
		Если Не ЗначениеЗаполнено(ПараметрМетода.Опция) Или Не СтруктураМетода["ЕстьCLI"] Тогда
			Сообщить("Метод не имеет опции: " + СтруктураМетода["Заголовок"]);
			Возврат;
		КонецЕсли;

		ТаблицаПараметров = ТаблицаПараметров + "  | " 
			+ ПараметрМетода.Имя + " | "
			+ ПараметрМетода.Опция + " | "
			+ ПараметрМетода.Типы  + " | "
			+ ?(ЗначениеЗаполнено(ПараметрМетода.ЗначениеПоУмолчанию), "&#x2716;", "&#x2714;") + " | "
			+ ПараметрМетода.Описание + " |"
			+ Символы.ПС;
	КонецЦикла;

	Макет = СтрЗаменить(Макет, "@Вызов1С"          , Вызов1С);
	Макет = СтрЗаменить(Макет, "@ВызовCLI"         , ВызовCLI);
	Макет = СтрЗаменить(Макет, "@ТаблицаПараметров", ТаблицаПараметров); 

	НовыйДокумент = Новый ТекстовыйДокумент();
	НовыйДокумент.УстановитьТекст(Макет);
	НовыйДокумент.Записать(КаталогОбласти + "/" + ТранслитированноеИмя + ".mdx");

	СчетчикОбласти = СчетчикОбласти + 1;

КонецПроцедуры

#КонецОбласти

#Область РазборМодуля

Процедура РазобратьМодуль(ТекущийМодуль, ИмяМодуля)

	СчетчикБиблиотеки    = 1;
	ТекстМодуля          = ТекущийМодуль.ПолучитьТекст();
	СтруктураОбщихДанных = Новый Структура();
	СтруктураОбщихДанных.Вставить("ИмяМодуля", ИмяМодуля);

	ПолучитьДанныеМодуля(СтруктураОбщихДанных, ТекущийМодуль);

	Если Не ЗначениеЗаполнено(СтруктураОбщихДанных["Библиотека"]) Тогда
		Возврат;
	КонеЦесли;

	ТекущаяБиблиотека = СтруктураОбщихДанных["Библиотека"];
	
	Парсер          = Новый ПарсерВстроенногоЯзыка;
	СтруктураМодуля = Парсер.Разобрать(ТекстМодуля);

	Для Каждого Метод Из СтруктураМодуля.Объявления Цикл

		Если Метод.Тип = "ОбъявлениеМетода" И Метод.Сигнатура.Экспорт = Истина Тогда
			РазобратьМетод(ТекущийМодуль, Метод, СтруктураОбщихДанных);	
		КонецЕсли;

		Если Метод.Тип = "ИнструкцияПрепроцессораОбласть" Тогда
			СписокОбластей.Добавить(Метод.Начало.НомерСтроки, Метод.Имя);
	    КонецЕсли;

	КонецЦикла;

	СписокОбластей.СортироватьПоЗначению();

КонецПроцедуры

Процедура ПолучитьДанныеМодуля(СтруктураОбщихДанных, ТекущийМодуль)

	Имя = ТекущийМодуль.ПолучитьСтроку(2);
	CLI = ТекущийМодуль.ПолучитьСтроку(3);

	Если СтрНайти(Имя, "Lib") = 0 Тогда
		Имя = "";
	Иначе 
		Имя = СтрЗаменить(Имя, "// Lib:", "");
		Имя = СокрЛП(Имя);
	КонецЕсли;

	Если СтрНайти(CLI, "CLI") = 0 Тогда
		CLI = "none";
	Иначе
		CLI = СтрЗаменить(CLI, "// CLI:", "");
		CLI = СокрЛП(CLI);
	КонецЕсли;

	Каталог = СтрЗаменить(Имя, " ", "_");

	СтруктураОбщихДанных.Вставить("Библиотека", Имя);
	СтруктураОбщихДанных.Вставить("Команда"   , CLI);
	СтруктураОбщихДанных.Вставить("Каталог"   , Каталог);

КонецПроцедуры

#КонецОбласти

#Область РазборМетода

Процедура РазобратьМетод(ТекстовыйДокумент, Метод, СтруктураДанных)

	НомерСтроки         = Метод.Начало.НомерСтроки;
	ИмяМетода           = Метод.Сигнатура.Имя;
	Объявление          = "";

	Для Н = НомерСтроки По Метод.Конец.НомерСтроки Цикл

		Часть      = СокрЛП(ТекстовыйДокумент.ПолучитьСтроку(Н));
		Объявление = Объявление + Часть;

		Если Не ЗначениеЗаполнено(Часть) Тогда
			Прервать;
		КонецЕсли;

	КонецЦикла;
	
	Для Каждого Область Из СписокОбластей Цикл
		Если НомерСтроки > Область.Значение Тогда
			СтруктураДанных.Вставить("Область", Область.Представление);
		КонецЕсли;
	КонецЦикла;

	МассивКомментария        = ПарсингКомментария(ТекстовыйДокумент, НомерСтроки, СтруктураДанных);
	МассивПараметров         = Новый Массив;
	МассивОписанийПараметров = Новый Массив;

	Если МассивКомментария.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;

	СформироватьСтруктуруМетода(МассивКомментария, МассивПараметров, СтруктураДанных);
	СформироватьМассивОписанийПараметров(МассивПараметров, Метод, МассивОписанийПараметров);

	СтруктураДанных.Вставить("ИмяМетода" , ИмяМетода);
	СтруктураДанных.Вставить("Объявление", Объявление);
	СтруктураДанных.Вставить("Параметры" , МассивОписанийПараметров);

	СоздатьСтраницуДокументации(СтруктураДанных);

КонецПроцедуры

Функция ПарсингКомментария(Знач ТекстовыйДокумент, Знач НомерСтроки, СтруктураДанных)

	ТекущаяСтрока       = ТекстовыйДокумент.ПолучитьСтроку(НомерСтроки - 1);
	ТекстКомментария    = ТекущаяСтрока;
	
	Счетчик	= 1;
	Пока СтрНайти(ТекущаяСтрока, "//") > 0 Цикл

		Счетчик = Счетчик + 1;

		ТекущаяСтрока    = ТекстовыйДокумент.ПолучитьСтроку(НомерСтроки - Счетчик);
		ТекстКомментария = ТекущаяСтрока + Символы.ПС + ТекстКомментария;

	КонецЦикла;

    Если СтрНайти(ТекстКомментария, "!NOCLI") > 0 Тогда
        СтруктураДанных.Вставить("ЕстьCLI", Ложь);
	Иначе
		СтруктураДанных.Вставить("ЕстьCLI", Истина);
    КонецЕсли;

	ТекстКомментария  = СтрЗаменить(ТекстКомментария, "//", "$");
    МассивКомментария = СтрРазделить(ТекстКомментария, "$", Ложь);

    Если МассивКомментария.Количество() = 0 Тогда
		Возврат Новый Массив;
    Иначе
        МассивКомментария.Удалить(0);
    КонецЕсли;

    Возврат МассивКомментария;

КонецФункции

Процедура СформироватьСтруктуруМетода(Знач МассивКомментария, МассивПараметров, СтруктураДанных)

	ОписаниеМетода       = "";
	ЗаписыватьПараметры  = Ложь;
	ЗаписыватьПримечание = Ложь;
    ЗаписыватьОписание   = Истина;

	ТекстПримечания = "";

	Счетчик = 0;
	ЕстьДД  = "";
	Для Каждого СтрокаКомментария Из МассивКомментария Цикл

        Счетчик = Счетчик + 1;

        Если Не ЗначениеЗаполнено(СокрЛП(СтрокаКомментария)) Тогда
            ЗаписыватьОписание = Ложь;
        КонецЕсли;
            
        Если ЗаписыватьОписание = Истина И Счетчик > 1 Тогда
            ОписаниеМетода = СокрЛП(ОписаниеМетода) + " " + СокрЛП(СтрокаКомментария);
        КонецЕсли;

        Если СтрНайти(СтрокаКомментария, "Параметры:") > 0
			Или СтрНайти(СтрокаКомментария, "Parameters:") > 0 Тогда
            ЗаписыватьПараметры  = Истина;
            ЗаписыватьОписание   = Ложь;
			ЗаписыватьПримечание = Ложь;

		ИначеЕсли СтрНайти(СтрокаКомментария, "Примечание:") > 0
			Или СтрНайти(СтрокаКомментария, "Note") > 0 Тогда
			ЗаписыватьПараметры  = Ложь;
			ЗаписыватьОписание   = Ложь;
			ЗаписыватьПримечание = Истина;

        ИначеЕсли СтрНайти(СтрокаКомментария, "Возвращаемое значение:") > 0
			Или СтрНайти(СтрокаКомментария, "Returns:") > 0 Тогда
			СтруктураДанных.Вставить("ВозвращаемоеЗначение", МассивКомментария[Счетчик]);
            Прервать;

        ИначеЕсли ЗаписыватьПараметры = Истина 
            И ЗначениеЗаполнено(СокрЛП(СтрокаКомментария)) 
            И Не СтрНачинаетсяС(СокрЛП(СтрокаКомментария), "*") = 0 Тогда
            
            МассивПараметров.Добавить(СтрокаКомментария);

			Если СтрНайти(СтрокаКомментария, "ДвоичныеДанные") <> 0 Тогда
				ЕстьДД = "ru";
			КонецЕсли;

			Если СтрНайти(СтрокаКомментария, "BinaryData") <> 0 Тогда
				ЕстьДД = "en";
			КонецЕсли;

		ИначеЕсли ЗаписыватьПримечание = Истина Тогда

			ТекстПримечания = ТекстПримечания + СтрокаКомментария + Символы.ПС;

        Иначе
            Продолжить;
        КонецЕсли;

    КонецЦикла;

	ТекстПримечания = СокрЛП(ТекстПримечания);

	Если ЗначениеЗаполнено(ЕстьДД) Тогда

		ТекстДополнения = ?(ЕстьДД = "ru"
			, "Параметры с типом данных Двоичные данные могут принимать также пути к файлам на диске и URL"
			, "Parameters with Binary data type can also accept file paths on disk and URLs");

		Если ЗначениеЗаполнено(ТекстПримечания) Тогда
			ТекстПримечания = ТекстПримечания + "<br/>" + Символы.ПС + ТекстДополнения;
		Иначе
			ТекстПримечания = ТекстДополнения;
		КонецЕсли;

	КонецЕсли;

	Если ЗначениеЗаполнено(ТекстПримечания) Тогда

		ТекстПримечания = СтрЗаменить(ТекстПримечания, "(@", "(https://");
		ТекстПримечания = СтрЗаменить(ТекстПримечания, "<", "&lt;");
		ТекстПримечания = СтрЗаменить(ТекстПримечания, ">", "&gt;");

		ТекстПримечания = ":::tip"
			+ Символы.ПС
			+ ТекстПримечания
			+ Символы.ПС
			+ ":::"
			+ Символы.ПС
			+ "<br/>";

	КонецЕсли;

	СтруктураДанных.Вставить("Описание"  , ОписаниеМетода);
	СтруктураДанных.Вставить("Заголовок" , СтрЗаменить(СокрЛП(МассивКомментария[0]), "!NOCLI", ""));
	СтруктураДанных.Вставить("Примечание", ТекстПримечания);

КонецПроцедуры

Процедура СформироватьМассивОписанийПараметров(Знач МассивПараметров, Знач Метод, МассивОписанийПараметров)

	Разделитель = "-";

	Для Каждого ПараметрМетода Из МассивПараметров Цикл

		МассивЭлементовПараметра = СтрРазделить(ПараметрМетода, Разделитель, Ложь);
		КоличествоЭлементов      = МассивЭлементовПараметра.Количество();
	
		Для Н = 0 По МассивЭлементовПараметра.ВГраница() Цикл
			МассивЭлементовПараметра[Н] = СокрЛП(МассивЭлементовПараметра[Н]);
		КонецЦикла;
	
        Имя1С     = МассивЭлементовПараметра[0];

		Если КоличествоЭлементов >= 4 Тогда
			Имя  = "--" + МассивЭлементовПараметра[3];
		Иначе 
			Имя = "";
		Конецесли;
		Типы      = МассивЭлементовПараметра[1];

		Описание  = ?(КоличествоЭлементов >= 5, МассивЭлементовПараметра[4], МассивЭлементовПараметра[2]);	
		
		СтруктураПараметра = Новый Структура;
		СтруктураПараметра.Вставить("Имя"                , Имя1С);
		СтруктураПараметра.Вставить("Опция"              , Имя);
		СтруктураПараметра.Вставить("Типы"               , Типы);
		СтруктураПараметра.Вставить("Описание"           , Описание);
		СтруктураПараметра.Вставить("ЗначениеПоУмолчанию", ПолучитьЗначениеПараметраПоУмолчанию(Имя1С, Метод));

		МассивОписанийПараметров.Добавить(СтруктураПараметра);
         
    КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область Инструменты

Процедура ОчиститьКаталогиДокументов()

	МассивКорней = Новый Массив;
	МассивКорней.Добавить(КаталогДокументации);
	МассивКорней.Добавить(КаталогЛокализации);

	Постоянные = Новый СписокЗначений();
	Постоянные.Добавить("Instructions");
	Постоянные.Добавить("Start");

	Для Каждого Корень Из МассивКорней Цикл

		Каталоги = НайтиФайлы(Корень, "*");

		Для Каждого Каталог Из Каталоги Цикл

			Если Постоянные.НайтиПоЗначению(Каталог.Имя) <> Неопределено
				Или Не Каталог.ЭтоКаталог() Тогда
				Продолжить;
			КонецЕсли;

			УдалитьФайлы(Каталог.ПолноеИмя);
			
		КонецЦикла;

	КонецЦикла;

КонецПроцедуры

Функция ПолучитьВызов1С(Модуль, Метод)

	Результат = "";

	ИмяКаталога = СтрЗаменить(Модуль, "OPI_", "");
	ИмяФайла    = Метод + ".txt";

	ПутьПримера = КаталогПримеров + ИмяКаталога + "/" + ИмяФайла;
	ФайлПримера = Новый Файл(ПутьПримера);

	Если ФайлПримера.Существует() Тогда
		ТекстПримера = Новый ТекстовыйДокумент();
		ТекстПримера.Прочитать(ПутьПримера);

		Результат = ТекстПримера.ПолучитьТекст();
	
		Если ЗначениеЗаполнено(Результат) Тогда
			Результат = Лев(Результат, СтрДлина(Результат) - 1);
		КонецЕсли;

	КонецЕсли;

	Результат = СокрП(Результат);

	Возврат Результат;

КонецФункции

Функция ПолучитьВызовCLI(СтруктураМетода)

	ПутьCLI  = КаталогCLI + СтруктураМетода["Команда"] + "/" + СтруктураМетода["ИмяМетода"];
	ФайлCLI  = Новый Файл(ПутьCLI);
	ВызовCLI = "";

	Если Не ФайлCLI.Существует() Тогда
		
		Возврат "";
		
	Иначе

		СоответствиеПодсветки = Новый Соответствие();
		СоответствиеПодсветки.Вставить("bat"   , "batch");
		СоответствиеПодсветки.Вставить("bash"  , "bash");
		СоответствиеПодсветки.Вставить("single", "powershell");

		СоответствиеЗаголовков = Новый Соответствие();
		СоответствиеЗаголовков.Вставить("bat"   , "CMD/Bat");
		СоответствиеЗаголовков.Вставить("bash"  , "Bash");
		СоответствиеЗаголовков.Вставить("single", "*");

		ФайлыВызова = НайтиФайлы(ПутьCLI, "*");
		ПолныйТекст = "
		| <Tabs>";

		ШаблонПримера = "  
		|    <TabItem value=""%1"" label=""%2"" default>
		|        ```%3
		|%4
		|        ```
  		|    </TabItem>";

		Для Каждого ФайлВызова Из ФайлыВызова Цикл

			ТекущийПуть = ФайлВызова.ПолноеИмя;
			ДанныеФайла = Новый ДвоичныеДанные(ТекущийПуть);
			ДанныеФайла = ПолучитьСтрокуИзДвоичныхДанных(ДанныеФайла);

			Если СтрЧислоСтрок(ДанныеФайла) > 1 Тогда
				ДанныеФайла = СтрЗаменить(ДанныеФайла, "  --" , "              --");
				ДанныеФайла = СтрЗаменить(ДанныеФайла, "oint ", "            oint ");
			КонецЕсли;

			Ключ      = ФайлВызова.ИмяБезРасширения;
			Подсветка = СоответствиеПодсветки[Ключ];
			Заголовок = СоответствиеЗаголовков[Ключ];

			ПолныйТекст = ПолныйТекст + Символы.ПС + СтрШаблон(ШаблонПримера, Ключ, Заголовок, Подсветка, ДанныеФайла);

		КонецЦикла;

		ПолныйТекст = ПолныйТекст + Символы.ПС + "</Tabs>";
		
		Возврат ПолныйТекст;
	
	КонецЕсли;

КонецФункции

Функция ОпределитьЗначениеОпции(Опция, Значение = "")

	Если ЗначениеЗаполнено(Значение) Тогда
		Опция = """" + Строка(Значение) + """";
	Иначе
		Опция = "%" + СтрЗаменить(Опция, "-", "") + "%";
	КонецЕсли;

	Возврат Опция;

КонецФункции

Процедура ПроверитьСоздатьКаталог(Путь)

	Каталог = Новый Файл(Путь);

	Если Не Каталог.Существует() Тогда
		СоздатьКаталог(Путь);
    КонецЕсли;

КонецПроцедуры

Функция ПолучитьЗначениеПараметраПоУмолчанию(Знач Имя, Знач Метод)

    Значение = "";

    Для Каждого ПараметрМетода Из Метод.Сигнатура.Параметры Цикл

        Если ПараметрМетода.Имя = Имя Тогда

            ЗначениеПараметра = ПараметрМетода.Значение;
            Если ЗначениеЗаполнено(ЗначениеПараметра) Тогда
                Попытка
                    Значение = ЗначениеПараметра["Элементы"][0]["Значение"];
                Исключение 
                    Значение = ЗначениеПараметра.Значение;
                КонецПопытки;
                Значение = ?(ЗначениеЗаполнено(Значение), Значение, "Пустое значение");
            КонецЕсли;

        КонецЕсли;

    КонецЦикла;

    Возврат Значение;

КонецФункции

Функция ТранслитироватьСтроку(Знач Значение)

	Значение = нРег(Значение);

	Для Каждого ЗаменяемыйСимвол Из Транслитация Цикл
		Значение = СтрЗаменить(Значение, ЗаменяемыйСимвол.Ключ, ЗаменяемыйСимвол.Значение);
	КонецЦикла;

	Значение = ВРег(Лев(Значение,1)) + Сред(Значение,2);
	Возврат Значение;

КонецФункции

Функция ПеревестиИмя(Значение)

	ПереведенноеИмя = Словарь[Значение];

	Если Не ЗначениеЗаполнено(ПереведенноеИмя)  Тогда
		Если ТекущийЯзык = "ru" Тогда
			ПереведенноеИмя = ТранслитироватьСтроку(Значение);
		Иначе 
			ПереведенноеИмя = Значение;
		КонецЕсли;
	КонецЕсли;

	ПереведенноеИмя = СтрЗаменить(ПереведенноеИмя, "(", "");
	ПереведенноеИмя = СтрЗаменить(ПереведенноеИмя, ")", "");
	ПереведенноеИмя = СтрЗаменить(ПереведенноеИмя, "-", " ");

	Возврат ПереведенноеИмя;

КонецФункции

 Функция Синонимайзер(ИмяРеквизита)
    
    Перем Синоним, ъ, Символ, ПредСимвол, СледСимвол, Прописная, ПредПрописная, СледПрописная, ДлинаСтроки;
    
    Синоним = ВРег(Сред(ИмяРеквизита, 1, 1));
    ДлинаСтроки = СтрДлина(ИмяРеквизита);
    Для ъ=2 По ДлинаСтроки Цикл
        Символ = Сред(ИмяРеквизита, ъ, 1);
        ПредСимвол = Сред(ИмяРеквизита, ъ-1, 1);
        СледСимвол = Сред(ИмяРеквизита, ъ+1, 1);
        Прописная = Символ = ВРег(Символ);
        ПредПрописная = ПредСимвол = ВРег(ПредСимвол);
        СледПрописная = СледСимвол = ВРег(СледСимвол);
        
        // Варианты:
        Если НЕ ПредПрописная И Прописная Тогда
            Синоним = Синоним + " " + Символ;
        ИначеЕсли Прописная И НЕ СледПрописная Тогда
            Синоним = Синоним + " " + Символ;
        Иначе
            Синоним = Синоним + Символ;
        Конецесли;
    КонецЦикла;

	Синоним = ВРег(Лев(Синоним,1)) + нРег(Сред(Синоним,2));
    
    Возврат Синоним;
    
КонецФункции

Функция ПолучитьРезультатМетода(Знач Раздел, Знач Метод)

	Результат           = "";
	ПутьКаталогаРаздела = КаталогЛогов + Раздел;
	КаталогРаздела      = Новый Файл(ПутьКаталогаРаздела);

	Если Не КаталогРаздела.Существует() Тогда
		Возврат Результат;
	КонецЕсли;

	ПутьЛога = ПутьКаталогаРаздела + "/" + Метод + ".log";
	ФайлЛога = Новый Файл(ПутьЛога);

	Если Не ФайлЛога.Существует() Тогда
		Возврат Результат;
	КонецЕсли;

	ДокументЛога = Новый ТекстовыйДокумент();
	ДокументЛога.Прочитать(ПутьЛога);

	Результат = ДокументЛога.ПолучитьТекст();
	Результат = СокрЛП(Результат);

	МаксимальныйРазмер = Мин(СтрЧислоСтрок(Результат), 150);
	Обрезка            = СтрЧислоСтрок(Результат) > 150;
	ТекстРезультата    = "";

	Для Счетчик = 1 По МаксимальныйРазмер Цикл
		ТекстРезультата = ТекстРезультата + СтрПолучитьСтроку(Результат, Счетчик) + Символы.ПС;
	КонецЦикла;

	ТекстРезультата = ?(Обрезка, ТекстРезультата + "...", Лев(ТекстРезультата, СтрДлина(ТекстРезультата) - 1));
	
	Возврат ТекстРезультата;

КонецФункции

Процедура ПолучитьТаблицуТранслитации()

	Транслитация = Новый Соответствие();
	
	Транслитация.Вставить("а", "a");
	Транслитация.Вставить("б", "b");
	Транслитация.Вставить("в", "v");
	Транслитация.Вставить("г", "g");
	Транслитация.Вставить("д", "d");
	Транслитация.Вставить("е", "e");
	Транслитация.Вставить("ё", "e");
	Транслитация.Вставить("ж", "zh");
	Транслитация.Вставить("з", "z");
	Транслитация.Вставить("и", "i");
	Транслитация.Вставить("й", "y");
	Транслитация.Вставить("к", "k");
	Транслитация.Вставить("л", "l");
	Транслитация.Вставить("м", "m");
	Транслитация.Вставить("н", "n");
	Транслитация.Вставить("о", "o");
	Транслитация.Вставить("п", "p");
	Транслитация.Вставить("р", "r");
	Транслитация.Вставить("с", "s");
	Транслитация.Вставить("т", "t");
	Транслитация.Вставить("у", "u");
	Транслитация.Вставить("ф", "f");
	Транслитация.Вставить("х", "h");
	Транслитация.Вставить("ц", "ts");
	Транслитация.Вставить("ч", "ch");
	Транслитация.Вставить("ш", "sh");
	Транслитация.Вставить("щ", "sch");
	Транслитация.Вставить("ъ", "");
	Транслитация.Вставить("ы", "y");
	Транслитация.Вставить("ь", "");
	Транслитация.Вставить("э", "e");
	Транслитация.Вставить("ю", "u");
	Транслитация.Вставить("я", "ya");

КонецПроцедуры

#КонецОбласти

#КонецОбласти