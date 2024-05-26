#Использовать "../../../cli/data"

Перем СоответствияПараметровЗначениям;
Перем СоответствияПараметровПредобработкам;
Перем Версия;
Перем ТекущийФайл;
Перем ТаблицаПараметров;

#Область Основа

Процедура ПриСозданииОбъекта()
	
	СоответствияПараметровЗначениям      = Новый Соответствие();
	СоответствияПараметровПредобработкам = Новый Соответствие();
	ТекущийСоставБиблиотеки              = Новый СоставБиблиотеки();

	ТаблицаПараметров = ТекущийСоставБиблиотеки.ПолучитьПолныйСостав();
	Версия            = ТекущийСоставБиблиотеки.ПолучитьВерсию();

	ДобавитьСоответствияTelegram();
	ДобавитьСоответствияVK();
	ДобавитьСоответствияViber();
	ДобавитьСоответствияОбщие();

	СоздатьОсновнойФайл();
	СоздатьФайлДрафта();

КонецПроцедуры

Процедура СоздатьОсновнойФайл()

	ТекущийФайл = Новый ТекстовыйДокумент();

	СообщитьНачалоФайлаПроцесса();
	СообщитьСборку();
	СформироватьЗапуск();
	СообщитьОкончаниеФайлаПроцесса();

	ТекущийФайл.Записать("./.github/workflows/cli_test.yml");

КонецПроцедуры

Процедура СоздатьФайлДрафта()

	ТекущийФайл = Новый ТекстовыйДокумент();

	ТекущийФайл.ДобавитьСтроку(
		"name: CLI | Добавить пакеты в Draft
		|
		|on:
		|  workflow_dispatch:
		|
		|jobs:");

	СообщитьСборку();
	СообщитьЗаписьВДрафт();

	ТекущийФайл.Записать("./.github/workflows/cli_draft.yml");

КонецПроцедуры

#КонецОбласти

#Область ФормированиеФайлов

Процедура СообщитьНачалоФайлаПроцесса()

	ТекущийФайл.ДобавитьСтроку(
	"name: CLI | Сборка и тестирование
	|
	|on:
	|  workflow_dispatch:
	|
	|jobs:
	|  Decode:
	|    runs-on: ubuntu-latest
	|    steps:
	|
	|      - uses: actions/checkout@v4 
	|
	|      - name: Расшифровать тестовые данные
	|        run: gpg --quiet --batch --yes --decrypt --passphrase=""$ENC_JSON"" --output ./data.json ./data.json.gpg        
	|        env:
	|          ENC_JSON: ${{ secrets.ENC_JSON }}
	|
	|      - name: Кэшировать данные
	|        uses: actions/cache/save@v3
	|        with:
	|          path: ./data.json
	|          key: test-data
	|");

КонецПроцедуры

Процедура СообщитьСборку()
	
	ТекущийФайл.ДобавитьСтроку("
	|  Build:
	|    runs-on: ubuntu-latest
	|    permissions:
	|      contents: write
	|    steps:
	|      - uses: actions/checkout@v4             
	|      - uses: otymko/setup-onescript@v1.4
	|        with:
	|          version: " + Версия + " 
	|
	|      - name: Установить cmdline, asserts и osparser
	|        run: |
	|          opm install cmdline
	|          opm install asserts
	|          opm install osparser
	|      - name: Сформировать список методов ОПИ -> CLI
	|        run: oscript ./.github/workflows/os/cli_parse.os
	|
	|      - name: Записать измененный список методов CLI
	|        uses: stefanzweifel/git-auto-commit-action@v5   
	|        with:
	|          commit_user_name: Vitaly the Alpaca (bot) 
	|          commit_user_email: vitaly.the.alpaca@gmail.com
	|          commit_author: Vitaly the Alpaca <vitaly.the.alpaca@gmail.com>
	|          commit_message: Обновление зашифрованных данных по результатам тестов (workflow)
	|
	|      - name: Собрать и установить OInt
	|        run: |
	|          cd ./OInt
	|          opm build
	|          opm install *.ospx  
	|
	|      - name: Собрать бинарник
	|        run: |
	|          cd ./cli
	|          oscript -make core/Classes/Приложение.os oint
	|
	|      - name: Собрать exe
	|        run: |
	|          cd ./cli
	|          oscript -make core/Classes/Приложение.os oint.exe
	|
	|      - name: Записать артефакт
	|        uses: actions/upload-artifact@v4
	|        with:
	|          name: oint
	|          path: ./cli/oint
	|
	|      - name: Создать каталог deb-пакета
	|        run: |
	|          mkdir -p .debpkg/usr/bin
	|          cp ./cli/oint .debpkg/usr/bin/oint
	|          chmod +x .debpkg/usr/bin/oint
	|
	|      - name: Собрать deb-пакет
	|        uses: jiro4989/build-deb-action@v3
	|        with:
	|          package: oint
	|          package_root: .debpkg
	|          maintainer: Anton Titovets <bayselonarrend@gmail.com>
	|          version: '" + Версия + "' # refs/tags/v*.*.*
	|          arch: 'all'
	|          depends: 'mono-runtime, libmono-system-core4.0-cil | libmono-system-core4.5-cil, libmono-system4.0-cil | libmono-system4.5-cil, libmono-corlib4.0-cil | libmono-corlib4.5-cil, libmono-i18n4.0-all | libmono-i18n4.5-all'
	|          desc: 'OInt CLI - приложение для работы с API различных онлайн-сервисов из командной строки'
	|
	|      - uses: actions/upload-artifact@v3
	|        with:
	|          name: oint-deb
	|          path: |
	|            ./*.deb
	|
	|      - name: Создать каталог rpm-пакета
	|        run: |
	|          mkdir -p .rpmpkg/usr/bin
	|          mkdir -p .rpmpkg/usr/share/oint/bin
	|          cp ./cli/oint .rpmpkg/usr/share/oint/bin/oint
	|          echo 'mono /usr/share/oint/bin/oint ""$@""' > .rpmpkg/usr/bin/oint
	|          chmod +x .rpmpkg/usr/bin/oint
	|
	|      - name: Собрать rpm-пакет 
	|        uses: jiro4989/build-rpm-action@v2
	|        with:
	|          summary: 'OInt CLI - приложение для работы с API различных онлайн-сервисов из командной строки. Требуется mono-runtime с поддержкой .NET Framework 4.8'
	|          package: oint
	|          package_root: .rpmpkg
	|          maintainer: Anton Titovets <bayselonarrend@gmail.com>
	|          version: '" + Версия + "'
	|          arch: 'x86_64'
	|          desc: 'OInt CLI - приложение для работы с API различных онлайн-сервисов из командной строки'
	|          requires: |
	|            mono-core
	|            Requires:       mono-locale-extras
	|
	|      - uses: actions/upload-artifact@v4
	|        with:
	|          name: oint-rpm
	|          path: |
	|            ./*.rpm
	|            !./*-debuginfo-*.rpm");

КонецПроцедуры

Процедура СформироватьЗапуск()
	
	Для Каждого Вариант Из СоответствияПараметровЗначениям Цикл

		Библиотека = Вариант.Ключ;
		Если Библиотека = "Общие" Тогда
			Продолжить;
		КонецЕсли;

		ТекстРаботы = "
		|  Testing-" + Библиотека + ":
		|    runs-on: ubuntu-latest
		|    needs: [Decode, Build]
		|    steps:
		|
		|      - name: Получить тестовые данные из кэша
		|        uses: actions/cache/restore@v3
		|        with:
		|          path: ./data.json
		|          key: test-data
		|
		|      - name: Скачать артефакт с исполняемым файлом
		|        uses: actions/download-artifact@v4
		|        with:
		|          name: oint 
		|
		|      - name: JSON в переменные
		|        uses: rgarcia-phi/json-to-variables@v1.1.0
		|        with:
		|          filename: 'data.json'
		|          masked: true
		|
		|      - name: chmod для OInt
		|        run: chmod +x ./oint
		|
		|";

		Отбор            = Новый Структура("Библиотека", Библиотека);
		СтрокиБиблиотеки = ТаблицаПараметров.НайтиСтроки(Отбор);
		ТекущийМетод     = "";

		Для Каждого СтрокаПараметра Из СтрокиБиблиотеки Цикл

			Если ТекущийМетод <> СтрокаПараметра.Метод Тогда

				ТекущийМетод = СтрокаПараметра.Метод;
				Отбор.Вставить("Метод", ТекущийМетод);		
				СтрокиМетода = ТаблицаПараметров.НайтиСтроки(Отбор);

				ТекстРаботы = ТекстРаботы + Символы.ПС + "
				|
				|      - name: Выполнить " + ТекущийМетод+ "
				|        if: ${{ cancelled() }} == false
				|        run: |
				| ";

				ДобавитьПредобработки(ТекстРаботы, СтрокиМетода, Библиотека);
				
				ТекстРаботы = ТекстРаботы + "
				|          ./oint " + Библиотека + " " + ТекущийМетод + " --debug --test \" + Символы.ПС; 

			КонецЕсли;

			ТекстРаботы = ТекстРаботы 
				+ "          " 
				+ СтрокаПараметра.Параметр 
				+ " " 
				+ ОпределитьЗначениеПараметра(СтрокаПараметра.Параметр, Библиотека) 
				+ " \"
				+ Символы.ПС; 

		КонецЦикла;

		ТекущийФайл.ДобавитьСтроку(ТекстРаботы);

	КонецЦикла;

КонецПроцедуры

Процедура СообщитьОкончаниеФайлаПроцесса()

	ТекущийФайл.ДобавитьСтроку("
	|  Clear-Cache:
    |    runs-on: ubuntu-latest
    |    needs: [Testing-telegram, Testing-vk, Testing-viber]
    |    if: ${{ always() }}
    |    steps:
    |      - name: Очистка кэша
    |        run: |
    |          curl -L \
    |          -X DELETE \
    |          -H ""Accept: application/vnd.github+json"" \
    |          -H ""Authorization: Bearer ${{ secrets.TOKEN }}"" \
    |          -H ""X-GitHub-Api-Version: 2022-11-28"" \
    |          ""https://api.github.com/repos/Bayselonarrend/OpenIntegrations/actions/caches?key=test-data""");

КонецПроцедуры

Процедура СообщитьЗаписьВДрафт()

	ТекущийФайл.ДобавитьСтроку("
    |      - name: Добавить DEB
    |        env:
    |          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    |        run: gh release upload draft ./*.deb
	|
    |      - name: Добавить RPM
    |        env:
    |          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    |        run: gh release upload draft ./*.rpm");

КонецПроцедуры

#КонецОбласти

#Область ОбработкиТестов

Процедура ДобавитьСоответствияTelegram()
	
	СоответствиеПЗ = Новый Соответствие();

	СоответствиеПЗ.Вставить("token"    , "${{ env.json_Telegram_Token }}");
	СоответствиеПЗ.Вставить("url"      , "${{ env.json_Telegram_URL }}");
	СоответствиеПЗ.Вставить("chat"     , "${{ env.json_Telegram_ChannelID }}");
	СоответствиеПЗ.Вставить("media"    , "mediagroup.json");
	СоответствиеПЗ.Вставить("anonymous", "true");
	СоответствиеПЗ.Вставить("message"  , "${{ env.json_Telegram_ChannelMessageID }}");
	СоответствиеПЗ.Вставить("to"       , "${{ env.json_Telegram_ChatID }}");
	СоответствиеПЗ.Вставить("from"     , "${{ env.json_Telegram_ChannelID }}");
	СоответствиеПЗ.Вставить("user"     , "${{ env.json_Telegram_ChatID }}");
	СоответствиеПЗ.Вставить("expire"   , "1");
	СоответствиеПЗ.Вставить("limit"    , "1");
	СоответствиеПЗ.Вставить("forum"    , "${{ env.json_Telegram_ForumID }}");
	СоответствиеПЗ.Вставить("icon"     , "5350444672789519765 ");
	СоответствиеПЗ.Вставить("topic"    , "${{ env.json_Telegram_TopicID }}");
	СоответствиеПЗ.Вставить("under"    , "true");
	СоответствиеПЗ.Вставить("column"   , "false");

	СоответствияПараметровЗначениям.Вставить("telegram", СоответствиеПЗ);

	СоответствиеПредобработок = Новый Соответствие();

	Предобработка = "
	|          echo "" {
	|            \""${{ env.json_Picture }}\"" : \""photo\"",
	|            \""${{ env.json_Picture2 }}\"" : \""photo\""
	|          } "" > mediagroup.json
	|";

	СоответствиеПредобработок.Вставить("media", Предобработка);

	СоответствияПараметровПредобработкам.Вставить("telegram", СоответствиеПредобработок);

КонецПроцедуры

Процедура ДобавитьСоответствияVK()
	
	СоответствиеПЗ = Новый Соответствие();

	СоответствиеПЗ.Вставить("app"       , "${{ env.json_VK_AppID }}");
	СоответствиеПЗ.Вставить("pictures"  , "['${{ env.json_Picture }}', '${{ env.json_Picture2 }}']");
	СоответствиеПЗ.Вставить("ad"        , "false");
	СоответствиеПЗ.Вставить("url"       , "https://github.com/Bayselonarrend/OpenIntegrations");
	СоответствиеПЗ.Вставить("auth"      , "auth.json");
	СоответствиеПЗ.Вставить("post"      , "1159");
	СоответствиеПЗ.Вставить("album"     , "303733811");
	СоответствиеПЗ.Вставить("pictureid" , "1");
	СоответствиеПЗ.Вставить("topic"     , "1");
	СоответствиеПЗ.Вставить("remove"    , "false");
	СоответствиеПЗ.Вставить("wall"      , "-${{ env.json_VK_GroupID }}");
	СоответствиеПЗ.Вставить("from"      , "-${{ env.json_VK_GroupID }}");
	СоответствиеПЗ.Вставить("to"        , "-${{ env.json_VK_GroupID }}");
	СоответствиеПЗ.Вставить("user"      , "${{ env.json_VK_UserID }}");
	СоответствиеПЗ.Вставить("ct"        , "${{ env.json_VK_CommunityToken }}");
	СоответствиеПЗ.Вставить("keyboard"  , "");
	СоответствиеПЗ.Вставить("cabinet"   , "${{ env.json_VK_AdsCabinetID }}");
	СоответствиеПЗ.Вставить("campaign"  , "1");
	СоответствиеПЗ.Вставить("limit"     , "1");
	СоответствиеПЗ.Вставить("category"  , "1");
	СоответствиеПЗ.Вставить("adv"       , "1");
	СоответствиеПЗ.Вставить("sel"       , "1");
	СоответствиеПЗ.Вставить("items"     , "['1111111','2222222']");
	СоответствиеПЗ.Вставить("product"   , "product.json");
	СоответствиеПЗ.Вставить("item"      , "1");
	СоответствиеПЗ.Вставить("sellgroup" , "1");
	СоответствиеПЗ.Вставить("sels"      , "['1111111','2222222']");
	СоответствиеПЗ.Вставить("posts"     , "['1111111','2222222']");
	СоответствиеПЗ.Вставить("main"      , "false");
	СоответствиеПЗ.Вставить("hidden"    , "false");
	СоответствиеПЗ.Вставить("prop"      , "1");
	СоответствиеПЗ.Вставить("option"    , "1");
	СоответствиеПЗ.Вставить("value"     , "Тест");

	СоответствияПараметровЗначениям.Вставить("vk", СоответствиеПЗ);

	СоответствиеПредобработок = Новый Соответствие();

	Предобработка = "
	|          echo "" {
	|            \""access_token\"": \""${{ env.json_VK_Token }}\"",
	|            \""from_group\""  : \""1\"",
	|            \""owner_id\""    : \""-${{ env.json_VK_GroupID }}\"",
	|            \""v\""           : \""5.131\"",
	|            \""app_id\""      : \""${{ env.json_VK_AppID }}\"",
	|            \""group_id\""    : \""${{ env.json_VK_GroupID }}\""
	|          } "" > auth.json
	|";

	СоответствиеПредобработок.Вставить("auth", Предобработка);

	Предобработка = "
	|          echo "" {
	|            \""Имя\""                  : \""Тест\"",
	|            \""Описание\""             : \""Тест\"",
	|            \""Категория\""            : \""20173\"",
	|            \""Цена\""                 : \""1\"",
	|            \""СтараяЦена\""           : \""2\"",
	|            \""ДополнительныеФото\""   : [],
	|            \""ЗначенияСвойств\""      : [],
	|            \""ГлавныйВГруппе\""       : false,
	|            \""Ширина\""               : \""1\"",
	|            \""Высота\""               : \""1\"",
	|            \""Глубина\""              : \""1\"",
	|            \""Вес\""                  : \""1\"",
	|            \""SKU\""                  : \""12345\"",
	|            \""ДоступныйОстаток\""     : \""1\""
	|          } "" > product.json
	|";

	СоответствиеПредобработок.Вставить("product", Предобработка);

	СоответствияПараметровПредобработкам.Вставить("vk", СоответствиеПредобработок);

КонецПроцедуры

Процедура ДобавитьСоответствияViber()

	СоответствиеПЗ = Новый Соответствие();

	СоответствиеПЗ.Вставить("token"    , "${{ env.json_Viber_Token }}");
	СоответствиеПЗ.Вставить("user"     , "${{ env.json_Viber_UserID }}");
	СоответствиеПЗ.Вставить("chat"     , "${{ env.json_Telegram_ChannelID }}");
	СоответствиеПЗ.Вставить("ischannel", "true");

	СоответствияПараметровЗначениям.Вставить("viber", СоответствиеПЗ);

КонецПроцедуры

Процедура ДобавитьСоответствияОбщие()
	
	СоответствиеПЗ = Новый Соответствие();

	СоответствиеПЗ.Вставить("lat"        , "48.87373649724122");
	СоответствиеПЗ.Вставить("long"       , "48.87373649724122");
	СоответствиеПЗ.Вставить("text"       , "Тестовый текст");
	СоответствиеПЗ.Вставить("picture"    , "${{ env.json_Picture }}");
	СоответствиеПЗ.Вставить("video"      , "${{ env.json_Video }}");
	СоответствиеПЗ.Вставить("gif"        , "${{ env.json_GIF }}");
	СоответствиеПЗ.Вставить("audio"      , "${{ env.json_Audio }}");
	СоответствиеПЗ.Вставить("doc"        , "${{ env.json_Document }}");
	СоответствиеПЗ.Вставить("name"       , "Петр");
	СоответствиеПЗ.Вставить("surname"    , "Петров");
	СоответствиеПЗ.Вставить("phone"      , "+123456789");
	СоответствиеПЗ.Вставить("question"   , "Да или нет?");
	СоответствиеПЗ.Вставить("options"    , "['Да', 'Нет', 'Затрудняюсь ответить']");
	СоответствиеПЗ.Вставить("description", "Тестовое описание");
	СоответствиеПЗ.Вставить("buttons"    , "['Кнопка1','Кнопка2','Кнопка3']");
	СоответствиеПЗ.Вставить("title"      , "Тест");
	СоответствиеПЗ.Вставить("datefrom"   , "2024-02-30T23:50:08+03:00");
	СоответствиеПЗ.Вставить("dateto"     , "2024-03-30T23:50:08+03:00");
	СоответствиеПЗ.Вставить("ext"        , ".txt");
	СоответствиеПЗ.Вставить("size"       , "10");

	СоответствияПараметровЗначениям.Вставить("Общие", СоответствиеПЗ);
	СоответствияПараметровЗначениям.Вставить("twitter", СоответствиеПЗ);
	СоответствияПараметровЗначениям.Вставить("notion", СоответствиеПЗ);
	СоответствияПараметровЗначениям.Вставить("yandex", СоответствиеПЗ);
	СоответствияПараметровЗначениям.Вставить("yadisk", СоответствиеПЗ);
	СоответствияПараметровЗначениям.Вставить("google", СоответствиеПЗ);
	СоответствияПараметровЗначениям.Вставить("gcalendar", СоответствиеПЗ);
	СоответствияПараметровЗначениям.Вставить("gdrive", СоответствиеПЗ);
	СоответствияПараметровЗначениям.Вставить("gsheets", СоответствиеПЗ);

КонецПроцедуры

Функция ОпределитьЗначениеПараметра(Знач Параметр, Знач Библиотека)

	СоответствиеБиблиотеки = СоответствияПараметровЗначениям[Библиотека];
	Значение               = СоответствиеБиблиотеки[СтрЗаменить(Параметр, "-", "")];

	Если Не ЗначениеЗаполнено(Значение) Тогда

		СоответствиеОбщее = СоответствияПараметровЗначениям["Общие"];
		Значение          = СоответствиеОбщее[СтрЗаменить(Параметр, "-", "")];

	КонецЕсли;

	Если Не вРег(Значение) = "TRUE" И Не вРег(Значение) = "FALSE" Тогда
		Значение = """" + Значение + """";
	КонецЕсли;

	Возврат Значение;

КонецФункции

Процедура ДобавитьПредобработки(ТекстРаботы, Знач СтрокиБиблиотеки, Знач Библиотека)
	
	Предобработки      = СоответствияПараметровПредобработкам[Библиотека];
	ТекстПредобработки = "";

	Если ЗначениеЗаполнено(Предобработки) Тогда

		Для Каждого Параметр Из СтрокиБиблиотеки Цикл
			
			ТекущаяОбработка = Предобработки[СтрЗаменить(Параметр.Параметр, "-", "")];

			Если ЗначениеЗаполнено(ТекущаяОбработка) Тогда
				ТекстПредобработки = ТекстПредобработки + ТекущаяОбработка + Символы.ПС;
			КонецЕсли;

		КонецЦикла;

	КонецЕсли;

	ТекстРаботы = ТекстРаботы + ТекстПредобработки;

КонецПроцедуры

#КонецОбласти
