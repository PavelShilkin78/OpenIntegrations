// OneScript: ./OInt/core/Modules/OPI_YandexMarket.os
// Lib: Yandex Market
// CLI: yamarket

// MIT License

// Copyright (c) 2023 Anton Tsitavets

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// https://github.com/Bayselonarrend/OpenIntegrations

// BSLLS:Typo-off
// BSLLS:LatinAndCyrillicSymbolInWord-off
// BSLLS:IncorrectLineBreak-off
// BSLLS:NumberOfOptionalParams-off
// BSLLS:UsingServiceTag-off
// BSLLS:LineLength-off

//@skip-check module-structure-top-region
//@skip-check module-structure-method-in-regions
//@skip-check wrong-string-literal-content
//@skip-check method-too-many-params

// Раскомментировать, если выполняется OneScript
// #Использовать "../../tools"

#Область ПрограммныйИнтерфейс

#Область КабинетыИМагазины

// Получить список магазинов
// Получает список магазинов в кабинете по токену
//
// Примечание:
// Метод в документации API: [Список магазинов пользователя](@yandex.ru/dev/market/partner-api/doc/ru/reference/campaigns/getCampaigns)
//
// Параметры:
//  Токен    - Строка - Токен авторизации (Api-Key)  - token
//  Страница - Число  - Номер страницы выдачи списка - page
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Yandex Market
Функция ПолучитьСписокМагазинов(Знач Токен, Знач Страница = 1) Экспорт

    URL       = "https://api.partner.market.yandex.ru/campaigns";
    Заголовки = СоздатьЗаголовкиЗапроса(Токен);

    РазмерСтраницы = 100;

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("page"    , Страница      , "Число", Параметры);
    OPI_Инструменты.ДобавитьПоле("pageSize", РазмерСтраницы, "Число", Параметры);

    Ответ = OPI_Инструменты.Get(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Получить магазин
// Получает информацию о магазине (кампании) по ID
//
// Примечание:
// Метод в документации API: [Информация о магазине](@yandex.ru/dev/market/partner-api/doc/ru/reference/campaigns/getCampaign)
//
// Параметры:
//  Токен      - Строка        - Токен авторизации (Api-Key) - token
//  IDМагазина - Строка, Число - ID магазина (кампании)      - campaign
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Yandex Market
Функция ПолучитьМагазин(Знач Токен, Знач IDМагазина) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDМагазина);

    URL       = "https://api.partner.market.yandex.ru/campaigns/" + IDМагазина;
    Заголовки = СоздатьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.Get(URL, , Заголовки);

    Возврат Ответ;

КонецФункции

// Получить настройки кабинета
// Получает значения настроек кабинета по ID
//
// Примечание:
// Метод в документации API: [Настройки кабинета](@yandex.ru/dev/market/partner-api/doc/ru/reference/businesses/getBusinessSettings)
//
// Параметры:
//  Токен      - Строка        - Токен авторизации (Api-Key) - token
//  IDКабинета - Строка, Число - ID кабинета                 - business
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Yandex Market
Функция ПолучитьНастройкиКабинета(Знач Токен, Знач IDКабинета) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDКабинета);

    URL       = "https://api.partner.market.yandex.ru/businesses/%1/settings";
    URL       = СтрШаблон(URL, IDКабинета);
    Заголовки = СоздатьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.Post(URL, , Заголовки);

    Возврат Ответ;

КонецФункции

// Получить настройки магазина
// Получает настройки магазина по ID
//
// Примечание:
// Метод в документации API: [Настройки магазина](@yandex.ru/dev/market/partner-api/doc/ru/reference/campaigns/getCampaignSettings)
//
// Параметры:
//  Токен      - Строка        - Токен авторизации (Api-Key) - token
//  IDМагазина - Строка, Число - ID магазина (кампании)      - campaign
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Yandex Market
Функция ПолучитьНастройкиМагазина(Знач Токен, Знач IDМагазина) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDМагазина);

    URL       = "https://api.partner.market.yandex.ru/campaigns/%1/settings";
    URL       = СтрШаблон(URL, IDМагазина);
    Заголовки = СоздатьЗаголовкиЗапроса(Токен);

    Ответ = OPI_Инструменты.Get(URL, , Заголовки);

    Возврат Ответ;

КонецФункции

#КонецОбласти

#Область РаботаСТоварами

// Добавить обновить товары
// Добавляет или обновляет информацию о товарах в каталоге
//
// Примечание:
// Метод в документации API: [Добавление товаров в каталог и изменение информации о них](@yandex.ru/dev/market/partner-api/doc/ru/reference/business-assortment/updateOfferMappings)
//
// Параметры:
//  Токен           - Строка                         - Токен авторизации (Api-Key)                            - token
//  IDКабинета      - Строка, Число                  - ID кабинета                                            - business
//  МассивТоваров   - Структура, Массив Из Структура - Массив описаний товаров                                - offers
//  СвоиИзображения - Булево                         - Признак использования только своих изображений товаров - pmedia
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Yandex Market
Функция ДобавитьОбновитьТовары(Знач Токен, Знач IDКабинета, Знач МассивТоваров, Знач СвоиИзображения = Ложь) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDКабинета);

    URL       = "https://api.partner.market.yandex.ru/businesses/%1/offer-mappings/update";
    URL       = СтрШаблон(URL, IDКабинета);
    Заголовки = СоздатьЗаголовкиЗапроса(Токен);

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("offerMappings"          , МассивТоваров  , "Массив", Параметры);
    OPI_Инструменты.ДобавитьПоле("onlyPartnerMediaContent", СвоиИзображения, "Булево", Параметры);

    Ответ = OPI_Инструменты.Post(URL, Параметры, Заголовки);

    Возврат Ответ;

КонецФункции

// Получить товары магазина
// Получает список товаров выбранного магазина
//
// Примечание:
// Метод в документации API: [Информация о товарах, которые размещены в заданном магазине](@https://yandex.ru/dev/market/partner-api/doc/ru/reference/assortment/getCampaignOffers)
//
// Параметры:
//  Токен         - Строка                      - Токен авторизации (Api-Key)                  - token
//  IDМагазина    - Строка, Число               - ID магазина                                  - business
//  Фильтры       - Структура Из КлючИЗначение  - Фильтры для отбора товаров                   - filters
//  ТокенСтраницы - Строка                      - Токен следующей страницы при большой выборке - page
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от Yandex Market
Функция ПолучитьТоварыМагазина(Знач Токен, Знач IDМагазина, Знач Фильтры = "", Знач ТокенСтраницы = "") Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDМагазина);
    OPI_ПреобразованиеТипов.ПолучитьСтроку(ТокенСтраницы);

    URL       = "https://api.partner.market.yandex.ru/campaigns/%1/offers";
    URL       = СтрШаблон(URL, IDМагазина);
    Заголовки = СоздатьЗаголовкиЗапроса(Токен);

    Если ЗначениеЗаполнено(ТокенСтраницы) Тогда
        URL = URL + "?page_token=" + ТокенСтраницы;
    КонецЕсли;

    Если ЗначениеЗаполнено(Фильтры) Тогда
        OPI_ПреобразованиеТипов.ПолучитьКоллекцию(Фильтры);
        Ответ = OPI_Инструменты.Post(URL, Фильтры, Заголовки);
    Иначе
        Ответ = OPI_Инструменты.Post(URL,        , Заголовки);
    КонецЕсли;

    Возврат Ответ;

КонецФункции

Функция ПолучитьТоварыКабинета(Знач Токен, Знач IDКабинета, Знач Фильтры = "", Знач ТокенСтраницы = "") Экспорт

    OPI_ПреобразованиеТипов.ПолучитьСтроку(IDКабинета);
    OPI_ПреобразованиеТипов.ПолучитьСтроку(ТокенСтраницы);

    URL       = "https://api.partner.market.yandex.ru/businesses/%1/offer-mappings";
    URL       = СтрШаблон(URL, IDКабинета);
    Заголовки = СоздатьЗаголовкиЗапроса(Токен);

    Если ЗначениеЗаполнено(ТокенСтраницы) Тогда
        URL = URL + "?page_token=" + ТокенСтраницы;
    КонецЕсли;

    Если ЗначениеЗаполнено(Фильтры) Тогда
        OPI_ПреобразованиеТипов.ПолучитьКоллекцию(Фильтры);
        Ответ = OPI_Инструменты.Post(URL, Фильтры, Заголовки);
    Иначе
        Ответ = OPI_Инструменты.Post(URL,        , Заголовки);
    КонецЕсли;

    Возврат Ответ;

КонецФункции

// Получить структуру товара
// Получает структуру стандартных полей товара
//
// Примечание:
// Описание в документации API: [UpdateOfferDTO](@https://yandex.ru/dev/market/partner-api/doc/ru/reference/business-assortment/updateOfferMappings#updateofferdto)
//
// Параметры:
//  Пустая - Булево - Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей - empty
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение - Структура полей товара
Функция ПолучитьСтруктуруТовара(Знач Пустая = Ложь) Экспорт

    OPI_ПреобразованиеТипов.ПолучитьБулево(Пустая);

    СтруктураТовара = Новый Структура;
    СтруктураТовара.Вставить("offerId", "<идентификатор товара в вашей системе>");

        СтруктураРасходов = Новый Структура;
        СтруктураРасходов.Вставить("currencyId"  , "<код валюты>");
        СтруктураРасходов.Вставить("value"       , "<доп. расходы>");

    СтруктураТовара.Вставить("additionalExpenses", СтруктураРасходов);
    СтруктураТовара.Вставить("adult"             , "<параметр включает для товара пометку 18+>");

        СтруктураВозраста = Новый Структура;
        СтруктураВозраста.Вставить("ageUnit", "<единица измерения: YEAR, MONTH>");
        СтруктураВозраста.Вставить("value"  , "<возрастное ограничение>");

    СтруктураТовара.Вставить("age", СтруктураВозраста);

        МассивШтрихкодов = Новый Массив;
        МассивШтрихкодов.Добавить("<штрихкод>");

    СтруктураТовара.Вставить("barcodes", МассивШтрихкодов);

        СтруктураБазовойЦены = Новый Структура;
        СтруктураБазовойЦены.Вставить("currencyId"  , "<код валюты>");
        СтруктураБазовойЦены.Вставить("value"       , "<цена>");
        СтруктураБазовойЦены.Вставить("discountBase", "<цена до скидки>");

    СтруктураТовара.Вставить("basicPrice", СтруктураБазовойЦены);
    СтруктураТовара.Вставить("boxCount"  , "<количество грузовых мест>");
    СтруктураТовара.Вставить("category"  , "<категория товара в вашем магазине>");

        МассивСертификатов = Новый Массив;
        МассивСертификатов.Добавить("<номер документа на товар>");

    СтруктураТовара.Вставить("certificates", МассивСертификатов);

        СтруктураЦеныДляСкидок = Новый Структура;
        СтруктураЦеныДляСкидок.Вставить("currencyId"  , "<код валюты>");
        СтруктураЦеныДляСкидок.Вставить("value"       , "<цена>");

    СтруктураТовара.Вставить("cofinancePrice", СтруктураЦеныДляСкидок);

        СтруктураСостояния = Новый Структура;
        СтруктураСостояния.Вставить("quality", "<внешний вид товара>");
        СтруктураСостояния.Вставить("reason" , "<описание дефектов>");
        СтруктураСостояния.Вставить("type"   , "<тип уценки>");

    СтруктураТовара.Вставить("condition", СтруктураСостояния);

    СтруктураТовара.Вставить("customsCommodityCode", "<код товара ТН ВЭД>");
    СтруктураТовара.Вставить("description"         , "<подробное описание товара>");
    СтруктураТовара.Вставить("downloadable"        , "<признак цифрового товара>");

        СтруктураПериода = Новый Структура;
        СтруктураПериода.Вставить("timePeriod", "<значение продолжительности>");
        СтруктураПериода.Вставить("timeUnit"  , "<единица измерения>");
        СтруктураПериода.Вставить("comment"   , "<комментарий>");

    СтруктураТовара.Вставить("guaranteePeriod", СтруктураПериода);
    СтруктураТовара.Вставить("lifeTime"       , СтруктураПериода);

        МассивРуководств = Новый Массив;

            СтруктураРуководства = Новый Структура;
            СтруктураРуководства.Вставить("url"  , "<сслыка на руководство>");
            СтруктураРуководства.Вставить("title", "<заголовок руководства>");

        МассивРуководств.Добавить(СтруктураРуководства);

    СтруктураТовара.Вставить("manuals", МассивРуководств);

        МассивСтран = Новый Массив;
        МассивСтран.Добавить("<страна производства>");

    СтруктураТовара.Вставить("manufacturerCountries", МассивСтран);
    СтруктураТовара.Вставить("marketCategoryId"     , "<идентификатор категории на Маркете>");
    СтруктураТовара.Вставить("name"                 , "<имя товара>");

        МассивХарактеристик = Новый Массив;

            СтруктураХарактеристики = Новый Структура;
            СтруктураХарактеристики.Вставить("parameterId", "<идентификатор характеристики>");
            СтруктураХарактеристики.Вставить("unitId"     , "<идентификатор единицы измерения>");
            СтруктураХарактеристики.Вставить("value"      , "<значение>");
            СтруктураХарактеристики.Вставить("valueId"    , "<идентификатор значения для перечислений>");

        МассивХарактеристик.Добавить(СтруктураХарактеристики);

    СтруктураТовара.Вставить("parameterValues", МассивХарактеристик);

        МассивКартинок = Новый Массив;
        МассивКартинок.Добавить("<ссылка на картинку товара>");

    СтруктураТовара.Вставить("pictures"     , МассивКартинок);

        СтруктураЦеныЗакупки = Новый Структура;
        СтруктураЦеныЗакупки.Вставить("currencyId"  , "<код валюты>");
        СтруктураЦеныЗакупки.Вставить("value"       , "<цена>");

    СтруктураТовара.Вставить("purchasePrice", СтруктураЦеныЗакупки);
    СтруктураТовара.Вставить("shelfLife"    , СтруктураПериода);

        МассивТэгов = Новый Массив;
        МассивТэгов.Добавить("<метка>");

    СтруктураТовара.Вставить("tags"      , МассивТэгов);
    СтруктураТовара.Вставить("type"      , "<особый тип товара>");
    СтруктураТовара.Вставить("vendor"    , "<название бренда или производителя>");
    СтруктураТовара.Вставить("vendorCode", "<артикул товара от производителя>");

        МассивВидео = Новый Массив;
        МассивВидео.Добавить("<ссылка на видео>");

    СтруктураТовара.Вставить("videos"          , МассивВидео);

        СтруктураРазмеров = Новый Структура;
        СтруктураРазмеров.Вставить("height", "<высота в см.>");
        СтруктураРазмеров.Вставить("length", "<длина в см.>");
        СтруктураРазмеров.Вставить("weight", "<вес в кг. (брутто)>");
        СтруктураРазмеров.Вставить("width" , "<ширина в см.>");

    СтруктураТовара.Вставить("weightDimensions", "<габариты и вес товара>");

    Если Пустая Тогда
        СтруктураТовара = OPI_Инструменты.ОчиститьКоллекциюРекурсивно(СтруктураТовара);
    КонецЕсли;

    //@skip-check constructor-function-return-section
    Возврат СтруктураТовара;

КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СоздатьЗаголовкиЗапроса(Знач Токен)

    OPI_ПреобразованиеТипов.ПолучитьСтроку(Токен);

    Заголовки = Новый Соответствие;
    Заголовки.Вставить("Api-Key", Токен);
    Возврат Заголовки;

КонецФункции

#КонецОбласти
