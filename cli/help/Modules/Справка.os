#Использовать "../../tools"
#Использовать coloratos

#Область СлужебныйПрограммныйИнтерфейс

Процедура ВывестиНачальнуюСтраницу(Знач СоответствиеКомандМодулей, Знач Версия) Экспорт
	
	СписокКоманд = "";

	Для Каждого Команда Из СоответствиеКомандМодулей Цикл
		СписокКоманд = СписокКоманд + Команда.Ключ + ", ";
	КонецЦикла;

	ЛишниеСимволы = 2;
	СписокКоманд  = Лев(СписокКоманд, СтрДлина(СписокКоманд) - ЛишниеСимволы);

	Консоль.ЦветТекста = ЦветКонсоли.Зеленый;
	Консоль.ВывестиСтроку("-----------------------------------------------------");
	Консоль.ВывестиСтроку("");

	Консоль.ЦветТекста = ЦветКонсоли.Желтый;
	ЦветнойВывод.Вывести("
		|
		|    _______ _____________  ___  _______
		|    __  __ ___/__  _/_ /  |  / /___  __/
		|    _  / / / __  /  __      / __  /   
		|    / /_/ / __/ /   _  /|  /  _  /    
		|    \____/  /___/   /_/ |_/   /_/     
		|                          
		|
		| Добро пожаловать в (OInt|#color=Белый) v (" + Версия + "|#color=Зеленый)!
		|
		| Структура вызова:
	    | 
		| "
		+ "(oint|#color=Белый) "
		+ "(<бибилотека>|#color=Бирюза) "
		+ "(<метод>|#color=Бирюза) " 
		+ "(--опция1|#color=Серый) "
		+ "(""|#color=Зеленый)"
		+ "(Значение|#color=Белый)"
		+ "(""|#color=Зеленый) "
		+ "(...|#color=Белый) "
		+ "(--опцияN|#color=Серый) "
		+ "(""|#color=Зеленый)"
		+ "(Значение|#color=Белый)"
		+ "(""|#color=Зеленый) ");

	Консоль.Вывести("
		|
		| Вызов библиотеки без метода или метода без параметров возвращает справку
		| Список доступных библиотек: "); 
		
	Консоль.ЦветТекста = ЦветКонсоли.Белый;
	Консоль.Вывести(СписокКоманд); 

	Консоль.ЦветТекста = ЦветКонсоли.Белый;
	ЦветнойВывод.ВывестиСтроку("
		|
		| (Стандартные опции:|#color=Желтый)
		|  (--help|#color=Зеленый)  - выводит справку по текущей команде или методу. Аналогично вызову команды без опций
		|  (--debug|#color=Зеленый) - флаг, отвечающий за предоставление более подробной информации при работе программы
		|  (--out|#color=Зеленый)   - путь к файлу сохранения результата (двоичных данных в частности)
		|");
	
	Консоль.ЦветТекста = ЦветКонсоли.Желтый;
	ЦветнойВывод.ВывестиСтроку(" Полную документацию можно найти по адресу: (https://openintegrations.dev|#color=Бирюза)" + Символы.ПС);
	Консоль.ЦветТекста = ЦветКонсоли.Белый;

	ЗавершитьРаботу(0);
	
КонецПроцедуры

Процедура ВывестиСправкуПоМетодам(Знач Команда, Знач ТаблицаПараметров) Экспорт

	Консоль.ЦветТекста = ЦветКонсоли.Белый;
	ЦветнойВывод.ВывестиСтроку(Символы.ПС + " (##|#color=Зеленый) Библиотека - (" + Команда + "|#color=Бирюза)");

	ТаблицаПараметров.Свернуть("Метод");
	МассивМетодов = ТаблицаПараметров.ВыгрузитьКолонку("Метод");

	ЦветнойВывод.ВывестиСтроку(" (##|#color=Зеленый) Доступные методы: " + Символы.ПС);
	Консоль.ЦветТекста = ЦветКонсоли.Желтый;

	Для каждого Метод Из МассивМетодов Цикл
		ЦветнойВывод.ВывестиСтроку("    (-|#color=Белый) " + Метод);
	КонецЦикла;

	Сообщить(Символы.ПС);
	Консоль.ЦветТекста = ЦветКонсоли.Белый;

	ЗавершитьРаботу(0);

КонецПроцедуры

Процедура ВывестиСправкуПоПараметрам(Знач ТаблицаПараметров) Экспорт 

	Если ТаблицаПараметров.Количество() = 0 Тогда
		ВывестиСообщениеИсключения("Метод");
	КонецЕсли;

	ИмяМетода    = ТаблицаПараметров[0].Метод;
	ТекстСправки = "
	| (##|#color=Зеленый) Метод (" + ИмяМетода + "|#color=Бирюза)
	| (##|#color=Зеленый) "       + ТаблицаПараметров[0].ОписаниеМетода; 
	
	ЦветнойВывод.ВывестиСтроку(ТекстСправки);
	ТекстСправки = "";

	ОбработатьТабуляциюСправки(ТаблицаПараметров);

	Для Каждого ПараметрМетода Из ТаблицаПараметров Цикл

		ТекстСправки = ТекстСправки 
			+ Символы.ПС
			+ "    ("
			+ ПараметрМетода["Параметр"]
			+ "|#color=Желтый) - "
			+ ПараметрМетода["Описание"];

	КонецЦикла;

	ЦветнойВывод.ВывестиСтроку(ТекстСправки + Символы.ПС);

	ЗавершитьРаботу(0);
	
КонецПроцедуры

Процедура ВывестиСообщениеИсключения(Знач Причина) Экспорт

	Если Причина = "Команда" Тогда
		Текст = "Некорректная команда! Проверьте правильность ввода";
		Код   = 1;

	ИначеЕсли Причина = "Метод" Тогда
		Текст = "Некорректный метод! Проверьте правильность ввода";
		Код   = 2;
		
	Иначе
		Текст = "Непредвиденная ошибка!: " + Причина;
		Код   = 99;
	КонецЕсли;

	Текст = Символы.ПС + Текст + Символы.ПС;
	
	Сообщить(Текст, СтатусСообщения.ОченьВажное);
	ЗавершитьРаботу(Код);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОбработатьТабуляциюСправки(ТаблицаПараметров)

	Параметр_			= "Параметр";
	МаксимальнаяДлина 	= 15;

	Для Каждого ПараметрМетода Из ТаблицаПараметров Цикл
			
		Пока Не СтрДлина(ПараметрМетода[Параметр_]) = МаксимальнаяДлина Цикл
			ПараметрМетода[Параметр_] = ПараметрМетода[Параметр_] + " ";
		КонецЦикла;

		ТекущееОписание    = ПараметрМетода["Описание"];
		МассивОписания     = СтрРазделить(ТекущееОписание, Символы.ПС);
		НачальнаяТабуляция = 4;

		Если МассивОписания.Количество() = 1 Тогда
			Продолжить;
		Иначе

			Для Н = 1 По МассивОписания.ВГраница() Цикл

				ТекущийЭлемент = МассивОписания[Н];
				НеобходимаяДлина = СтрДлина(ТекущийЭлемент) + СтрДлина(ПараметрМетода[Параметр_] + " - ") + НачальнаяТабуляция;

				Пока СтрДлина(МассивОписания[Н]) < НеобходимаяДлина Цикл
					МассивОписания[Н] = " " + МассивОписания[Н];
				КонецЦикла;

			КонецЦикла;

			ПараметрМетода["Описание"] = СтрСоединить(МассивОписания, Символы.ПС);	
			
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

#КонецОбласти
