#Использовать cmdline
#Использовать oint
#Использовать "../../tools"
#Использовать "../../help"

Перем ОбъектОПИ;
Перем Парсер;
Перем Отладка;
Перем Тестирование;
Перем ФайлВывода;

#Область СлужебныеПроцедурыИФункции

#Область Основные

Процедура ОсновнойОбработчик()
	
	Отладка        = Ложь;
	Тестирование   = Ложь;
	Парсер         = Новый ПарсерАргументовКоманднойСтроки();
	ОбъектОПИ      = Новый СвязьОПИ();
	Команды        = ОбъектОПИ.СоответствиеКомандМодулей;

	ДобавитьКомандуСправки();

	Для Каждого Команда Из Команды Цикл
		СформироватьКоманду(Команда.Ключ, Парсер);
	КонецЦикла;

	Результат      = Парсер.Разобрать(АргументыКоманднойСтроки);
	ТекущаяКоманда = Результат["Команда"];

	Если ТекущаяКоманда = Неопределено Тогда
		Справка.ВывестиНачальнуюСтраницу(Команды);
	Иначе
		ВыполнитьОбработкуКоманды(Результат);
	КонецЕсли;
	
КонецПроцедуры

Процедура ДобавитьКомандуСправки()

	Парсер.ДобавитьПараметр("-h");
	Парсер.ДобавитьПараметр("-help");
	Парсер.ДобавитьПараметр("--help");

КонецПроцедуры

Процедура СформироватьКоманду(Знач Имя, Парсер)
	
	Команда           = Парсер.ОписаниеКоманды(Имя);
	ТаблицаПараметров = ОбъектОПИ.СоответствиеТаблицПараметров[Имя];

	Если Не ТаблицаПараметров = Неопределено Тогда

		ТаблицаПараметров = ТаблицаПараметров.Скопировать();
		Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "Метод");
		
		ДобавитьПараметрыКоманды(Парсер, Команда, ТаблицаПараметров);
		Парсер.ДобавитьПараметрФлагКоманды(Команда, "--help");
		Парсер.ДобавитьПараметрФлагКоманды(Команда, "--debug");
		Парсер.ДобавитьПараметрФлагКоманды(Команда, "--test");

		Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "--out");
		
		Парсер.ДобавитьКоманду(Команда);

	Иначе
		Справка.ВывестиСообщениеИсключения("Команда");
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьОбработкуКоманды(Знач Данные)
	
	ТекущаяКоманда = Данные["Команда"];
	Параметры      = Данные["ЗначенияПараметров"];
	Вывод		   = "";

	УстановитьРежимОтладки(Параметры);
	УстановитьРежимТеста(Параметры);
	УстановитьФайлВывода(Параметры);

	Если Отладка Или Тестирование Тогда

		Для каждого ВводныйПараметр Из Параметры Цикл
			Сообщить(ВводныйПараметр.Ключ + " : " + ВводныйПараметр.Значение);	
		КонецЦикла;

    КонецЕсли;
	
	Попытка
			
		Вывод = ПолучитьРезультатОбработки(ТекущаяКоманда, Параметры);

		Если ЗначениеЗаполнено(Вывод) Тогда
			ОбработатьВыводJSON(Вывод);
			СообщитьРезультат(Вывод, СтатусСообщения.Внимание);
		КонецЕсли;

	Исключение

		Информация = "";
		Если ЗначениеЗаполнено(Вывод) Тогда

			Если Отладка Или Тестирование Тогда
				Информация = ОписаниеОшибки();
			КонецЕсли;

			СообщитьРезультат(Вывод);
		Иначе

			Если Отладка Или Тестирование Тогда
				Информация = ОписаниеОшибки();
			Иначе
				Информация = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
			КонецЕсли;
		
		КонецЕсли;
		
		Справка.ВывестиСообщениеИсключения(Информация);

	КонецПопытки;
	
КонецПроцедуры

Функция ПолучитьРезультатОбработки(Знач Команда, Знач Параметры)

	Модуль    = ОбъектОПИ.СоответствиеКомандМодулей[Команда];
	Метод     = Параметры["Метод"];
	Ответ     = "Функция вернула пустое значение";

	ТаблицаПараметров = ОбъектОПИ.СоответствиеТаблицПараметров[Команда];

	Если Не ЗначениеЗаполнено(Метод) Или Метод = "--help" Тогда
		Справка.ВывестиСправкуПоМетодам(Команда, ТаблицаПараметров);
	КонецЕсли;

	ОтборКоманды      = Новый Структура("МетодПоиска", вРег(Метод));
	ПараметрыМетода   = ТаблицаПараметров.НайтиСтроки(ОтборКоманды);

	Если Параметры.Количество() = 4 Или Параметры["--help"] Тогда
		Справка.ВывестиСправкуПоПараметрам(ПараметрыМетода, Команда);
	КонецЕсли;

	ТекстВыполнения = СформироватьСтрокуВызоваМетода(Параметры, ПараметрыМетода, Модуль, Метод);

	Если Отладка Или Тестирование Тогда
		Сообщить(ТекстВыполнения, СтатусСообщения.Внимание);
	КонецЕсли;

	Если Не Тестирование Тогда
		Выполнить(ТекстВыполнения);
	КонецЕсли;

	Возврат Ответ;
	
КонецФункции

#КонецОбласти

#Область Вспомогательные

Процедура ДобавитьПараметрыКоманды(Парсер, Команда, Знач ТаблицаПараметров);
	
	ТаблицаПараметров.Свернуть("Параметр");

	МассивПараметров = ТаблицаПараметров.ВыгрузитьКолонку("Параметр");
	
	Для Каждого Параметр Из МассивПараметров Цикл
		Парсер.ДобавитьИменованныйПараметрКоманды(Команда, Параметр);
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьВыводJSON(Вывод)
	
	Если ТипЗнч(Вывод) = Тип("Структура")
		Или ТипЗнч(Вывод) = Тип("Соответствие")
		Или ТипЗнч(Вывод) = Тип("Массив") Тогда
	
		Вывод = OPI_Инструменты.JSONСтрокой(Вывод);

	КонецЕсли;

КонецПроцедуры

Функция СформироватьСтрокуВызоваМетода(Знач ПереданныеПараметры, Знач ПараметрыМетода, Знач Модуль, Знач Метод)

	ТекстВыполнения = "";
	СтрокаВызова    = Модуль + "." + Метод + "(";
	Счетчик         = 0;

	Для Каждого НеобходимыйПараметр Из ПараметрыМетода Цикл

		ИмяПараметра      = НеобходимыйПараметр.Параметр;
		ЗначениеПараметра = ПереданныеПараметры.Получить(ИмяПараметра);

		Если ЗначениеЗаполнено(ЗначениеПараметра) Тогда

			ИмяПараметра    = "Параметр" + СтрЗаменить(ИмяПараметра, "--", "_");

			ТекстВыполнения = ТекстВыполнения 
				+ Символы.ПС 
				+ ИмяПараметра
				+ " = """ 
				+ СтрЗаменить(ЗначениеПараметра, """", """""")
				+ """;";

			СтрокаВызова = СтрокаВызова + ИмяПараметра + ", ";
			Счетчик      = Счетчик + 1;

		Иначе
			СтрокаВызова = СтрокаВызова + " , ";
		КонецЕсли;

	КонецЦикла;

	ЛишниеСимволы   = 2;
	СтрокаВызова    = Лев(СтрокаВызова, СтрДлина(СтрокаВызова) - ЛишниеСимволы);
	СтрокаВызова    = СтрокаВызова + ");";
	СтрокаВызова    = "Ответ = " + СтрокаВызова;
	ТекстВыполнения = ТекстВыполнения + Символы.ПС + СтрокаВызова;

	Возврат ТекстВыполнения;

КонецФункции

Процедура УстановитьРежимОтладки(Знач Параметры)

	Если Параметры["--debug"] Тогда
		Отладка = Истина;
	Иначе
		Отладка = Ложь;
	КонецЕсли;

КонецПроцедуры

Процедура УстановитьРежимТеста(Знач Параметры)

	Если Параметры["--test"] Тогда
		Тестирование = Истина;
	Иначе
		Тестирование = Ложь;
	КонецЕсли;

КонецПроцедуры

Процедура УстановитьФайлВывода(Знач Параметры)

	Вывод = Параметры["--out"];

	Если ЗначениеЗаполнено(Вывод) Тогда
		ФайлВывода = Вывод;
	КонецЕсли;

КонецПроцедуры

Процедура СообщитьРезультат(Знач Текст, Знач Статус = "")

	Если Не ЗначениеЗаполнено(Статус) Тогда
		Статус = СтатусСообщения.БезСтатуса;
	КонецЕсли;

	Если ЗначениеЗаполнено(ФайлВывода) Тогда
		Текст = ЗаписатьЗначениеВФайл(Текст, ФайлВывода);
	ИначеЕсли ТипЗнч(Текст) = Тип("ДвоичныеДанные") Тогда
		Текст = "Похоже, что в ответе пришли двоичные данные! "
		    + "В следующий раз используйте опцию --out для указания пути их сохранения";
		Статус = СтатусСообщения.Информация;
	Иначе 
		Текст = Строка(Текст);
	КонецЕсли;

    Сообщить(Текст, Статус);
	
КонецПроцедуры

Функция ЗаписатьЗначениеВФайл(Знач Значение, Знач Путь)
	
	ЕдиницаДанных = 1024 * 1024;

	Если ТипЗнч(Значение) = Тип("ДвоичныеДанные") Тогда
        Значение.Записать(Путь);
	Иначе
		ТекстовыйДокумент = Новый ТекстовыйДокумент();
		ТекстовыйДокумент.УстановитьТекст(Значение);
		ТекстовыйДокумент.Записать(Путь);
	КонецЕсли;

	ЗаписанныйФайл = Новый Файл(Путь);

	Если ЗаписанныйФайл.Существует() Тогда
		Возврат "Файл размера " 
		    + Строка(ЗаписанныйФайл.Размер() / ЕдиницаДанных) 
			+ " МБ был записан в " 
			+ ЗаписанныйФайл.ПолноеИмя;
	Иначе
		ВызватьИсключение "Файл не был записан! Используйте флаг --debug для полчения дополнительной информации";
	КонецЕсли;

КонецФункции

#КонецОбласти

#КонецОбласти

Попытка
	ОсновнойОбработчик();	
Исключение
	
	Если Отладка Тогда
		Информация = ОписаниеОшибки();
	Иначе
		Информация = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
	КонецЕсли;

	Справка.ВывестиСообщениеИсключения(Информация);

КонецПопытки;

