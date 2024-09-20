Перем Репозиторий;
Перем Версия;
Перем Режим;
Перем Файл1С;
Перем ПутьКРепозиторию;
Перем Сервер;
Перем ПутьВыгрузки;
Перем Кугвин;

Процедура НачалоРаботы()
	
	Репозиторий = "https://github.com/Bayselonarrend/OpenIntegrations";
	Версия   = "1.13.0";
	Режим    = "CONFIG";

	//Локальные данные
	Файл1С           = """C:\Program Files\1cv8\8.3.18.1208\bin\1cv8.exe""";
	ПутьКРепозиторию = "C:\ProgramData\Jenkins\.jenkins\workspace\Release";
	Сервер           = "AIONIOTISCORE:1742";
	ПутьВыгрузки     = "C:\ProgramData\Jenkins\.jenkins\workspace\Release\" + Версия + "\";
	Кугвин           = "C:\cygwin64\bin\";
	//----------------

	ОбъектПутьВыгрузки = Новый Файл(ПутьВыгрузки);
	
	Если Не ОбъектПутьВыгрузки.Существует() Тогда
		СоздатьКаталог(ПутьВыгрузки);
	КонецЕсли;
	
	МассивЛокализаций = Новый Массив();

	СтруктураРус = Новый Структура();
	СтруктураРус.Вставить("База"    , "OpenIntegrations");
	СтруктураРус.Вставить("ПутьКEDT", ПутьКРепозиторию + "\src\ru\OPI");
	СтруктураРус.Вставить("ПутьOS"  , ПутьКРепозиторию + "\src\ru\OInt");
	СтруктураРус.Вставить("ПутьCLI" , ПутьКРепозиторию + "\src\ru\cli\core\Classes\app.os");
	СтруктураРус.Вставить("ПутьISS" , ПутьКРепозиторию + "\service\iss\ru.iss");
	СтруктураРус.Вставить("Префикс" , "ru");

	СтруктураАнг = Новый Структура();
	СтруктураАнг.Вставить("База"    , "OpenIntegrations_Eng");
	СтруктураАнг.Вставить("ПутьКEDT", ПутьКРепозиторию + "\src\en\OPI");
	СтруктураАнг.Вставить("ПутьOS"  , ПутьКРепозиторию + "\src\en\OInt");
	СтруктураАнг.Вставить("ПутьCLI" , ПутьКРепозиторию + "\src\en\cli\core\Classes\app.os");
	СтруктураАнг.Вставить("ПутьISS" , ПутьКРепозиторию + "\service\iss\en.iss");
	СтруктураАнг.Вставить("Префикс" , "en");
 
	МассивЛокализаций.Добавить(СтруктураРус);
	МассивЛокализаций.Добавить(СтруктураАнг); 

	КаталогВыгрузки = Новый Файл(ПутьВыгрузки);
	Если КаталогВыгрузки.Существует() Тогда 
		УдалитьФайлы(ПутьВыгрузки);
	КонецЕсли;
 
	СоздатьКаталог(ПутьВыгрузки);
	Приостановить(2000);
  
	Для Каждого Локализация Из МассивЛокализаций Цикл
  
		СоздатьXML(Локализация);
		СоздатьCFE(Локализация);
		СоздатьEDT(Локализация);   
		СоздатьOSPX(Локализация);
		СоздатьEXE(Локализация);
		СоздатьПакеты(Локализация);
		СоздатьУстановщик(Локализация);

	КонецЦикла;

	//Draft 

	ФайлыРелиза = НайтиФайлы(ПутьВыгрузки, "*", Истина);

	Для Каждого ФайлРелиза Из ФайлыРелиза Цикл
		ЗапуститьПриложение("""C:\Program Files\GitHub CLI\gh.exe"" release delete-asset draft --yes --repo " + Репозиторий + " """ + ФайлРелиза.Имя + """", , Истина);
		ЗапуститьПриложение("""C:\Program Files\GitHub CLI\gh.exe"" release upload draft --repo " + Репозиторий + " """ + ФайлРелиза.ПолноеИмя + """", , Истина);
	КонецЦикла;

КонецПроцедуры


Процедура СоздатьCFE(Данные)

	Сообщить("Начало CFE");

	База    = Данные["База"];
	Префикс = Данные["Префикс"];
	Основа  = Файл1С + " " + Режим + " /S " + Сервер + "\" + База + " ";
 
	//CFEawd
	ВыгрузкаВФайл = Основа   
		+ "/DumpCfg """    
		+ ПутьВыгрузки 
		+ "OpenIntegrations_" 
		+ Версия 
		+ "_"  
		+ Префикс      
		+ ".cfe"  
		+ """ -Extension OpenIntegrations";
		
		 
	ЗапуститьПриложение(ВыгрузкаВФайл, , Истина);

	Сообщить("Конец CFE");
	
КонецПроцедуры

Процедура СоздатьXML(Данные)

	Сообщить("Начало XML");

	Префикс = вРег(Данные["Префикс"]); 
	База    = Данные["База"];  
	
	Основа  = Файл1С + " " + Режим + " /S " + Сервер + "\" + База + " ";

	// XML 
	ПапкаXML = ПутьВыгрузки + "XML_" + Префикс;

	КаталогXML = Новый Файл(ПапкаXML);
	Если Не КаталогXML.Существует() Тогда
		СоздатьКаталог(ПапкаXML);
	КонецЕсли;

	ВыгрузкаВXML = Основа + "/DumpConfigToFiles """ + ПапкаXML + """ -Extension OpenIntegrations";
	ЗапуститьПриложение(ВыгрузкаВXML, , Истина);

	ПутьZIP = ПутьВыгрузки + "XML_" + Префикс + ".zip";
	ZipXML = Новый ЗаписьZipФайла(ПутьZIP);

	ZipXML.Добавить(ПапкаXML 
		+ "\*.*" , РежимСохраненияПутейZIP.СохранятьОтносительныеПути, РежимОбработкиПодкаталоговZIP.ОбрабатыватьРекурсивно);
	ZipXML.Записать();

	УдалитьФайлы(ПапкаXML);

	Сообщить("Конец XML");

КонецПроцедуры


Процедура СоздатьEDT(Данные)

	Сообщить("Начало EDT");

	Префикс  = вРег(Данные["Префикс"]);
	ПутьКEDT = Данные["ПутьКEDT"];

	ПутьZIP = ПутьВыгрузки + "EDT_" + Префикс + ".zip";
	ZipEDT  = Новый ЗаписьZipФайла(ПутьZIP);

	//EDT
	ZipEDT.Добавить(ПутьКEDT + "\*.*" 
		, РежимСохраненияПутейZIP.СохранятьОтносительныеПути, РежимОбработкиПодкаталоговZIP.ОбрабатыватьРекурсивно);
	ZipEDT.Записать();

	Сообщить("Конец EDT");

КонецПроцедуры


Процедура СоздатьOSPX(Данные)
	
	Сообщить("Начало OSPX");

	ПутьOS  = Данные["ПутьOS"];
	Префикс = Данные["Префикс"];

	СтандартноеИмяOSPX = "oint-" + Версия + ".ospx";
	ИмяOSPX            = "oint-" + Версия + "_" + Префикс + ".ospx";
	//OSPX
	КонечныйПутьOSPX = ПутьВыгрузки + ИмяOSPX;
	СборкаOS         = "opm b -o ""C:/"" """ + ПутьOS + """";

	ЗапуститьПриложение(СборкаOS, , Истина);
	ПереместитьФайл("C:\" + СтандартноеИмяOSPX, КонечныйПутьOSPX);

	Приостановить(1000);
	ЗапуститьПриложение("opm install -f """ + КонечныйПутьOSPX + """", , Истина);
	Приостановить(1000);

	Сообщить("Конец OSPX");

КонецПроцедуры


Процедура СоздатьEXE(Данные)

	Сообщить("Начало EXE");

	ПутьCLI = Данные["ПутьCLI"];
	Префикс =  Данные["Префикс"];

	//EXE
	СборкаEXE = "oscript -make """ + ПутьCLI + """ """ + ПутьВыгрузки + "oint.exe""";
	ЗапуститьПриложение(СборкаEXE, , Истина);
	
	Сообщить("Конец EXE");

КонецПроцедуры

Процедура СоздатьПакеты(Данные)
	  
	Сообщить("Начало Пакеты");

	КопироватьФайл(ПутьВыгрузки + "oint.exe", ПутьВыгрузки + "oint");

	ТекстSh = "--name oint"
	+ " -s dir"
	+ " --license mit"
	+ " --version " + Версия
	+ " --architecture all"
	+ " --depends mono-complete"
	+ " --description ""OInt CLI - приложение для работы с API различных онлайн-сервисов из командной строки"""
	+ " --url ""https://openintegrations.dev/"""
	+ " --maintainer ""Anton Titovets <bayselonarrend@gmail.com>"""
	+ " oint=/usr/bin/oint";

	MakeSh = ПутьВыгрузки + "make.sh";

	ДокументSh = Новый ТекстовыйДокумент();
	
	ДокументSh.ДобавитьСтроку("fpm -t deb " + ТекстSh);
	ДокументSh.ДобавитьСтроку("fpm -t rpm " + ТекстSh);
	
	ДокументSh.Записать(MakeSh);

	тДанные = Новый ДвоичныеДанные(MakeSh);
 
	тСтрока = Base64Строка(тДанные);
	тСтрока=Прав(тСтрока, СтрДлина(тСтрока) - 4);
	Base64Значение(тСтрока).Записать(MakeSh);

	ЗапуститьПриложение("C:\cygwin64\bin\bash.exe """ + MakeSh + """ > C:/log.txt", ПутьВыгрузки);

	Сообщить("Конец Пакеты");

КонецПроцедуры

Процедура СоздатьУстановщик(Данные)

	Сообщить("Начало ISS");

	ПутьISS = Данные["ПутьISS"];
	ПутьCLI = Данные["ПутьCLI"];
	Префикс = Данные["Префикс"];

	//Setup
 
	ТекстISS = Новый ТекстовыйДокумент();
	ТекстISS.Прочитать(ПутьISS);

	Для Н = 1 По ТекстISS.КоличествоСтрок() Цикл

		ТекущаяСтрока = СокрЛП(ТекстISS.ПолучитьСтроку(Н));

		Если СтрНайти(ТекущаяСтрока, "#define MyAppVersion") Тогда
			ТекстISS.ЗаменитьСтроку(Н, "#define MyAppVersion """ + Версия + """");
			Прервать;
		КонецЕсли;

	КонецЦикла;

	ТекстISS.Записать(ПутьISS);

	СборкаSetup = """C:\Program Files (x86)\Inno Setup 6\Compil32.exe"" /cc """ + ПутьISS + """";
	ЗапуститьПриложение(СборкаSetup, , Истина);
	ПереместитьФайл(ПутьВыгрузки + "oint.exe", ПутьВыгрузки + "oint_" + Префикс + ".exe");

	Сообщить("Конец ISS");

КонецПроцедуры


НачалоРаботы();