#Область СлужебныйПрограммныйИнтерфейс

Функция ПолучитьИмяМодуля(Знач ИмяКоманды = "") Экспорт

	СоответствиеКомандМодулей = Новый Соответствие();
	СоответствиеКомандМодулей.Вставить("telegram", "OPI_Telegram");

	Если ЗначениеЗаполнено(ИмяКоманды) Тогда
		Результат = СоответствиеКомандМодулей.Получить(ИмяКоманды);
	Иначе
		Результат = СоответствиеКомандМодулей;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(Результат) Тогда
		ВызватьИсключение "Неизвестная команда: " + ИмяКоманды;
	Иначе
		Возврат Результат;
	КонецЕсли;

КонецФункции

Функция ПолучитьТаблицуПараметров(Знач ИмяКоманды) Экспорт

	ТПМ = Новый ТаблицаЗначений();
	
	ТПМ.Колонки.Добавить("Метод");
	ТПМ.Колонки.Добавить("МетодПоиска");
	ТПМ.Колонки.Добавить("Параметр");
	ТПМ.Колонки.Добавить("Имя");
	ТПМ.Колонки.Добавить("Описание");
	ТПМ.Колонки.Добавить("ВариантОбработки");

	Попытка
		Выполнить("ЗаполнитьТаблицуПараметров" + ИмяКоманды + "(ТПМ);");
	Исключение
		ВызватьИсключение "Неизвестная команда: " + ИмяКоманды;
	КонецПопытки;

	Возврат ТПМ;

КонецФункции

Процедура ЗаполнитьТаблицуПараметровTelegram(ТПМ) Экспорт
	
	ДобавитьПараметрМетода(ТПМ, "ПолучитьИнформациюБота"	 , "--token"   , "Токен"     , "Токен бота");

	ДобавитьПараметрМетода(ТПМ, "ПолучитьОбновления"		 , "--token"   , "Токен"     , "Токен бота");

	ДобавитьПараметрМетода(ТПМ, "УстановитьWebhook" 		 , "--token"   , "Токен"     , "Токен бота");
	ДобавитьПараметрМетода(ТПМ, "УстановитьWebhook" 		 , "--url"     , "URL"       , "Адрес обработки запросов (с https://)");

	ДобавитьПараметрМетода(ТПМ, "УдалитьWebHook" 		     , "--token"   , "Токен"     , "Токен бота");
	ДобавитьПараметрМетода(ТПМ, "УдалитьWebHook" 	      	 , "--url"     , "URL"       , "Адрес обработки запросов (с https://)");

	ДобавитьПараметрМетода(ТПМ, "ОтправитьТекстовоеСообщение", "--token"   , "Токен"     , "Токен бота");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьТекстовоеСообщение", "--id"      , "IDЧата"    , "ID чата / ID чата*ID темы");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьТекстовоеСообщение", "--text"    , "Текст"     , "Текст сообщения");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьТекстовоеСообщение", "--keyboard", "Клавиатура", "JSON клавиатуры / файл .json клавиатуры (необяз.)"	    , "ОбработатьПараметрТекст");

	ДобавитьПараметрМетода(ТПМ, "ОтправитьКартинку"			 , "--token"   , "Токен"     , "Токен бота");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьКартинку"			 , "--id"      , "IDЧата"    , "ID чата / ID чата*ID темы");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьКартинку"			 , "--text"    , "Текст"     , "Текст сообщения");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьКартинку"			 , "--path"    , "Картинка"  , "Путь к файлу");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьКартинку"			 , "--keyboard", "Клавиатура", "JSON клавиатуры / файл .json клавиатуры (необяз.)"	    , "ОбработатьПараметрТекст");

	ДобавитьПараметрМетода(ТПМ, "ОтправитьВидео"			 , "--token"   , "Токен"     , "Токен бота");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьВидео"			 , "--id"      , "IDЧата"    , "ID чата / ID чата*ID темы");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьВидео"			 , "--text"    , "Текст"     , "Текст сообщения");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьВидео"			 , "--path"    , "Картинка"  , "Путь к файлу");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьВидео"			 , "--keyboard", "Клавиатура", "JSON клавиатуры / файл .json клавиатуры (необяз.)"	    , "ОбработатьПараметрТекст");

	ДобавитьПараметрМетода(ТПМ, "ОтправитьГифку"			 , "--token"   , "Токен"     , "Токен бота");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьГифку"			 , "--id"      , "IDЧата"    , "ID чата / ID чата*ID темы");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьГифку"			 , "--text"    , "Текст"     , "Текст сообщения");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьГифку"			 , "--path"    , "Гифка"     , "Путь к файлу");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьГифку"			 , "--keyboard", "Клавиатура", "JSON клавиатуры / файл .json клавиатуры (необяз.)"	    , "ОбработатьПараметрТекст");

	ДобавитьПараметрМетода(ТПМ, "ОтправитьАудио"			 , "--token"   , "Токен"     , "Токен бота");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьАудио"			 , "--id"      , "IDЧата"    , "ID чата / ID чата*ID темы");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьАудио"			 , "--text"    , "Текст"     , "Текст сообщения");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьАудио"			 , "--path"    , "Аудио"     , "Путь к файлу");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьАудио"			 , "--keyboard", "Клавиатура", "JSON клавиатуры / файл .json клавиатуры (необяз.)"	    , "ОбработатьПараметрТекст");

	ДобавитьПараметрМетода(ТПМ, "ОтправитьДокумент"			 , "--token"   , "Токен"     , "Токен бота");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьДокумент"			 , "--id"      , "IDЧата"    , "ID чата / ID чата*ID темы");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьДокумент"			 , "--text"    , "Текст"     , "Текст сообщения");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьДокумент"			 , "--path"    , "Документ"  , "Путь к файлу");
	ДобавитьПараметрМетода(ТПМ, "ОтправитьДокумент"			 , "--keyboard", "Клавиатура", "JSON клавиатуры / файл .json клавиатуры (необяз.)"	    , "ОбработатьПараметрТекст");

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьПараметрМетода(Таблица
	, Знач Метод
	, Знач Параметр
	, Знач Имя
	, Знач Описание
	, Знач ВариантОбработки = "Строка")
	
	НовыйПараметр = Таблица.Добавить();
	НовыйПараметр.МетодПоиска 		= вРег(Метод);
	НовыйПараметр.Метод 			= Метод;
	НовыйПараметр.Параметр 			= Параметр;
	НовыйПараметр.Имя 				= Имя;
	НовыйПараметр.Описание 			= Описание;
	НовыйПараметр.ВариантОбработки 	= ВариантОбработки;
	
КонецПроцедуры

#КонецОбласти