Перем Репозиторий;
Перем Версия;
Перем Режим;
Перем Файл1С;
Перем ПутьКРепозиторию;
Перем Сервер;
Перем ПутьВыгрузки;
Перем Кугвин;
Перем Оскрипт;


Процедура НачалоРаботы()
	
	Репозиторий = "https://github.com/Bayselonarrend/OpenIntegrations";
	Версия   = "1.17.0";
	Режим    = "CONFIG";

	//Локальные данные
	Файл1С            = """C:\Program Files\1cv8\8.3.18.1208\bin\1cv8.exe""";
	Сервер            = "AIONIOTISCORE:1742";
	Кугвин            = "C:\cygwin64\bin\";
	ОСкрипт           = "C:\Program Files\OneScript\";

	ПутьКРепозиторию  = "C:\ProgramData\Jenkins\.jenkins\workspace\Release";
	//ПутьКРепозиторию  = "C:\Repos\OPI";
	ПутьВыгрузки      = ПутьКРепозиторию + "\" + Версия + "\";

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
	СтруктураРус.Вставить("ПутьCLIP", ПутьКРепозиторию + "\src\ru\cli");
	СтруктураРус.Вставить("ПутьISS" , ПутьКРепозиторию + "\service\iss\ru.iss");
	СтруктураРус.Вставить("Описание", "OInt CLI - приложение для работы с API различных онлайн-сервисов из командной строки");
	СтруктураРус.Вставить("Префикс" , "ru");

	СтруктураАнг = Новый Структура();
	СтруктураАнг.Вставить("База"    , "OpenIntegrations_Eng");
	СтруктураАнг.Вставить("ПутьКEDT", ПутьКРепозиторию + "\src\en\OPI");
	СтруктураАнг.Вставить("ПутьOS"  , ПутьКРепозиторию + "\src\en\OInt");
	СтруктураАнг.Вставить("ПутьCLI" , ПутьКРепозиторию + "\src\en\cli\core\Classes\app.os");
	СтруктураАнг.Вставить("ПутьCLIP", ПутьКРепозиторию + "\src\en\cli");
	СтруктураАнг.Вставить("ПутьISS" , ПутьКРепозиторию + "\service\iss\en.iss");
	СтруктураАнг.Вставить("Описание", "OInt CLI - CLI toolkit for integrating with APIs of popular online services");
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

		УдалитьФайлы(".\ci\installer_set\share\oint\lib\oint");
		УдалитьФайлы(".\ci\installer_set\share\oint\lib\oint-cli");
		
	КонецЦикла;

	//Draft 

	ФайлыРелиза = НайтиФайлы(ПутьВыгрузки, "*", Истина);

	Сообщить("Start GHCLI");

	Для Каждого ФайлРелиза Из ФайлыРелиза Цикл
		ЗапуститьПриложение("""C:\Program Files\GitHub CLI\gh.exe"" release delete-asset draft --yes --repo " + Репозиторий + " """ + ФайлРелиза.Имя + """", , Истина);
		ЗапуститьПриложение("""C:\Program Files\GitHub CLI\gh.exe"" release upload draft --repo " + Репозиторий + " """ + ФайлРелиза.ПолноеИмя + """", , Истина);
	КонецЦикла;

	Сообщить("End GHCLI");

КонецПроцедуры


Процедура СоздатьCFE(Данные)

	Сообщить("Start CFE");

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

	Сообщить("End CFE");
	
КонецПроцедуры

Процедура СоздатьXML(Данные)

	Сообщить("Start XML");

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

	Сообщить("End XML");

КонецПроцедуры


Процедура СоздатьEDT(Данные)

	Сообщить("Start EDT");

	Префикс  = вРег(Данные["Префикс"]);
	ПутьКEDT = Данные["ПутьКEDT"];

	ПутьZIP = ПутьВыгрузки + "EDT_" + Префикс + ".zip";
	ZipEDT  = Новый ЗаписьZipФайла(ПутьZIP);

	//EDT
	ZipEDT.Добавить(ПутьКEDT + "\*.*" 
		, РежимСохраненияПутейZIP.СохранятьОтносительныеПути, РежимОбработкиПодкаталоговZIP.ОбрабатыватьРекурсивно);
	ZipEDT.Записать();

	Сообщить("End EDT");

КонецПроцедуры


Процедура СоздатьOSPX(Данные)
	
	Сообщить("Start OSPX");

	ПутьOS   = Данные["ПутьOS"];
	ПутьCLIP = Данные["ПутьCLIP"];
	Префикс  = Данные["Префикс"];

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

	СтандартноеИмяOSPXCLI = "oint-cli-" + Версия + ".ospx";
	СборкаCLI = "opm b && opm install -f " + СтандартноеИмяOSPXCLI;

	ЗапуститьПриложение(СборкаCLI, ПутьCLIP, Истина);

	ЗапуститьПриложение("xcopy """ + ОСкрипт + "lib\oint"" "".\ci\installer_set\share\oint\lib\oint"" /e /y /i", , Истина);
	ЗапуститьПриложение("xcopy """ + ОСкрипт + "lib\oint-cli"" "".\ci\installer_set\share\oint\lib\oint-cli"" /e /y /i", , Истина);
	УдалитьФайлы(".\ci\installer_set\share\oint\lib\oint\tests");

	Сообщить("End OSPX");

КонецПроцедуры


Процедура СоздатьEXE(Данные)

	Сообщить("Start EXE");

	ПутьCLI = Данные["ПутьCLI"];
	Префикс =  Данные["Префикс"];

	//EXE
	СборкаEXE = "oscript -make """ + ПутьCLI + """ """ + ПутьВыгрузки + "oint.exe""";
	ЗапуститьПриложение(СборкаEXE, , Истина);
	
	Сообщить("End EXE");

КонецПроцедуры

Процедура СоздатьПакеты(Данные)
	  
	Сообщить("Start Пакеты");

	ТекстSh = "--name oint"
	+ " -s dir"
	+ " --license mit"
	+ " --version " + Версия
	+ " --architecture all"
	+ " --description """ + Данные["Описание"] + """"
	+ " --url ""https://openintegrations.dev/"""
	+ " --maintainer ""Anton Titovets <bayselonarrend@gmail.com>"""
	+ " --verbose"
	+ " ../ci/installer_set/=/usr ../service/engine/linux/=/usr/share/oint/bin";

	СоответствиеПакетов = Новый Соответствие();
	СоответствиеПакетов.Вставить("deb", "oint_" + Версия + "_all_" + Данные["Префикс"] + ".deb");
	СоответствиеПакетов.Вставить("rpm", "oint-" + Версия + "-1.noarch_" + Данные["Префикс"] + ".rpm");

	СоответствиеДополнений = Новый Соответствие();
	СоответствиеДополнений.Вставить("deb", "");
	СоответствиеДополнений.Вставить("rpm", " --rpm-os linux --depends libicu ");

	Для Каждого Пакет Из СоответствиеПакетов Цикл

		MakeSh  = ПутьВыгрузки + "make" + Пакет.Ключ + ".sh";
		MakeBat = ПутьВыгрузки + "make" + Пакет.Ключ + ".bat";
		

		FPM = "chmod +x ../ci/installer_set/share/oint/bin/oscript.exe
		|chmod +x ../ci/installer_set/bin/oint
		|fpm -t " + Пакет.Ключ + " -p " + Пакет.Значение + " "  + СоответствиеДополнений[Пакет.Ключ] + ТекстSh;
		FPM = ПолучитьДвоичныеДанныеИзСтроки(FPM);
		FPM.Записать(MakeSh);

		ТекстBat = "C:\cygwin64\bin\bash.exe """ + "make" + Пакет.Ключ + ".sh" + """";
		ТекстBat = ПолучитьДвоичныеДанныеИзСтроки(ТекстBat, "CP866");
		ТекстBat.Записать(MakeBat);

		ЗапуститьПриложение("make" + Пакет.Ключ + ".bat", ПутьВыгрузки, Истина);

		УдалитьФайлы(MakeBat);
		УдалитьФайлы(MakeSh);

	КонецЦикла;
	
	Сообщить("End Пакеты");

КонецПроцедуры

Процедура СоздатьУстановщик(Данные)

	Сообщить("Start ISS");

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
	
	Сообщить("End ISS");

КонецПроцедуры


НачалоРаботы();