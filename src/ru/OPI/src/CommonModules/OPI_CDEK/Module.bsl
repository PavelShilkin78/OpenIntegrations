﻿// OneScript: ./OInt/core/Modules/OPI_CDEK.os
// Lib: CDEK
// CLI: cdek

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

#Область ОбщиеМетоды

// Получить токен
// Получает токен на основе идентификатора аккаунта и пароля
//
// Примечание:
// Метод в документации API: [Авторизация клиентов](@api-docs.cdek.ru/29923918.html)
//
// Параметры:
//  Аккаунт     - Строка - Идентификатор клиента (Account)              - account
//  Пароль      - Строка - Секретный ключ (Password)                    - pass
//  ТестовыйAPI - Булево - Флаг использования API для тестовых запросов - testapi
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от CDEK
Функция ПолучитьТокен(Знач Аккаунт, Знач Пароль, ТестовыйAPI = Ложь) Экспорт

    URL = СформироватьURL("/oauth/token", ТестовыйAPI);

    Параметры = Новый Структура;
    OPI_Инструменты.ДобавитьПоле("grant_type"   , "client_credentials", "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("client_id"    , Аккаунт             , "Строка", Параметры);
    OPI_Инструменты.ДобавитьПоле("client_secret", Пароль              , "Строка", Параметры);

    Ответ = OPI_Инструменты.Post(URL, Параметры, , Ложь);

    Возврат Ответ;

КонецФункции

#КонецОбласти

#Область РаботаСЗаказми

// Создать заказ
// Создает заказ по описанию полей
// 
// Примечание:
// Метод в документации API: [Регистрация заказа](@api-docs.cdek.ru/29923926.html)
// 
// Параметры:
//  Токен           - Строка                     - Токен авторизации                              - token
//  ОписаниеЗаказа  - Структура Из КлючИЗначение - Набор полей заказа. См. ПолучитьОписаниеЗаказа - order
//  ИнтернетМагазин - Булево                     - Признак типа заказа Интернет магазин           - ostore 
//  ТестовыйAPI     - Булево                     - Флаг использования API для тестовых запросов   - testapi
// 
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение - сериализованный JSON ответа от CDEK
Функция СоздатьЗаказ(Знач Токен, Знач ОписаниеЗаказа, Знач ИнтернетМагазин = Ложь, ТестовыйAPI = Ложь) Экспорт
	
	OPI_ПреобразованиеТипов.ПолучитьКоллекцию(ОписаниеЗаказа);
	OPI_ПреобразованиеТипов.ПолучитьБулево(ИнтернетМагазин);
	
	URL = СформироватьURL("/orders", ТестовыйAPI);

	Параметры = Новый Структура;
	
	Для Каждого ПолеЗаказа Из ОписаниеЗаказа Цикл
		OPI_Инструменты.ДобавитьПоле(ПолеЗаказа.Ключ, ПолеЗаказа.Значение, "Текущий", Параметры);	
	КонецЦикла;
	
    OPI_Инструменты.ДобавитьПоле("type", ?(ИнтернетМагазин, 1, 2), "Число", Параметры);
    
    Ответ = OPI_Инструменты.Post(URL, ОписаниеЗаказа, , Ложь);

    Возврат Ответ;
      
КонецФункции
 
// Получить описание заказа
// Получает макет для создания заказа в функции СоздатьЗаказ
// 
// Примечание:
// Обязательность реквизитов может зависить от типа зказа или вложенности. Обязательно ознакомьтесь с документацией CDEK
// Описания полей в документации: [Регистрация заказа](@api-docs.cdek.ru/29923926.html)
// 
// Параметры:
//  Пустая             - Булево - Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей - empty
//  ТолькоОбязательные - Булево - Истина > в макете будут только обязательные поля                                 - required
//  ИнтернетМагазин    - Булево - Признак включения в макет полей исключительно для заказо Интернет магазина       - ostore
//
// Возвращаемое значение:
//  Структура Из КлючИЗначение - Структура полей
Функция ПолучитьОписаниеЗаказа(Знач Пустая = Ложь, Знач ТолькоОбязательные = Ложь, Знач ИнтернетМагазин = Ложь) Экспорт
	
	OPI_ПреобразованиеТипов.ПолучитьБулево(Пустая);
	OPI_ПреобразованиеТипов.ПолучитьБулево(ТолькоОбязательные);
	OPI_ПреобразованиеТипов.ПолучитьБулево(ИнтернетМагазин);

    СтруктураЗаказа = Новый Структура;
    
    СтруктураЗаказа.Вставить("tariff_code" , "<Код тарифа (подробнее см. приложение 1)>");

    	СтруктураПолучателя = Новый Структура;
    	СтруктураПолучателя.Вставить("company"               , "<Название компании>");
    	СтруктураПолучателя.Вставить("name"                  , "<ФИО контактного лица>");
    	СтруктураПолучателя.Вставить("passport_series"       , "<Серия паспорта>");
    	СтруктураПолучателя.Вставить("passport_number"       , "<Номер паспорта>");
    	СтруктураПолучателя.Вставить("passport_date_of_issue", "<Дата выдачи паспорта>");
    	СтруктураПолучателя.Вставить("passport_organization" , "<Орган выдачи паспорта>");
    	СтруктураПолучателя.Вставить("tin"                   , "<ИНН>");
    	СтруктураПолучателя.Вставить("passport_date_of_birth", "<Дата рождения>");
    	СтруктураПолучателя.Вставить("email"                 , "<Email как RFC 2822>");
    	СтруктураПолучателя.Вставить("contragent_type"       , "<Тип отправителя: LEGAL_ENTITY, INDIVIDUAL >");
    		
    		МассивТелефонов   = Новый Массив;
		    СтруктураТелефона = Новый Структура;
		    	
		    СтруктураТелефона.Вставить("number"    , "<Номер телефона>");
		    СтруктураТелефона.Вставить("additional", "<Дополнительная информация (добавочный номер)>");
		    	
		    МассивТелефонов.Добавить(СтруктураТелефона);
	    	
	    СтруктураПолучателя.Вставить("phones", МассивТелефонов); 
    	
    СтруктураЗаказа.Вставить("recipient", СтруктураПолучателя);
    
    	МассивУпаковок    = Новый Массив;
    	СтруктураУпаковки = Новый Структура;
    	
    	СтруктураУпаковки.Вставить("number" , "<Номер упаковки>");
    	СтруктураУпаковки.Вставить("weight" , "<Общий вес (в граммах)>");
    	СтруктураУпаковки.Вставить("length" , "<Габариты упаковки. Длина (в сантиметрах)>");
    	СтруктураУпаковки.Вставить("width"  , "<Габариты упаковки. Ширина (в сантиметрах)>");
    	СтруктураУпаковки.Вставить("height" , "<Габариты упаковки. Высота (в сантиметрах)>");
    	СтруктураУпаковки.Вставить("comment", "<Комментарий к упаковке>");
    	
    		МассивПозиций    = Новый Массив;
    		СтруктураПозиции = Новый Структура;
    		
    		СтруктураПозиции.Вставить("name"    , "<Наименование товара>");
    		СтруктураПозиции.Вставить("ware_key", "<Идентификатор/артикул товара>");
    		СтруктураПозиции.Вставить("marking" , "<Маркировка товара>");
    		
    			СтруктураОплаты = Новый Структура;
    		    СтруктураОплаты.Вставить("value"   , "<Сумма наложенного платежа, в том числе и НДС>");
	    		СтруктураОплаты.Вставить("vat_sum" , "<Сумма НДС>");
	    		СтруктураОплаты.Вставить("vat_rate", "<Ставка НДС (значение - 0, 10, 12, 20, null - нет НДС)>"); 
    			
    		СтруктураПозиции.Вставить("payment"     , СтруктураОплаты);
    		СтруктураПозиции.Вставить("cost"        , "<Объявленная стоимость товара>");
    		СтруктураПозиции.Вставить("weight"      , "<Вес (за единицу товара, в граммах)>");
    		СтруктураПозиции.Вставить("weight_gross", "<Вес брутто>");
    		СтруктураПозиции.Вставить("amount"      , "<Количество единиц товара (в штуках)>");
    		СтруктураПозиции.Вставить("name_i18n"   , "<Наименование на иностранном языке>");
    		СтруктураПозиции.Вставить("brand"       , "<Бренд на иностранном языке>");
    		СтруктураПозиции.Вставить("country_code", "<Код страны производителя товара ISO_3166-1_alpha-2>");
    		СтруктураПозиции.Вставить("material"    , "<Код материала>");
    		СтруктураПозиции.Вставить("wifi_gsm"    , "<Содержит wifi или gsm>");
    		СтруктураПозиции.Вставить("url"         , "<Ссылка на сайт интернет-магазина с описанием товара>");
    		
    		МассивПозиций.Добавить(СтруктураПозиции);
    		
    	СтруктураУпаковки.Вставить("items", МассивПозиций);
    	МассивУпаковок.Добавить(СтруктураУпаковки);
    	
    СтруктураЗаказа.Вставить("packages", МассивУпаковок); 
    
    Если Не ТолькоОбязательные Тогда
    	
    	СтруктураЗаказа.Вставить("additional_order_types" , "<Дополнительный тип заказа>");  	
    	СтруктураЗаказа.Вставить("comment"                , "<Комментарий к заказу>");
    	СтруктураЗаказа.Вставить("developer_key"          , "<Ключ разработчика (для разработчиков модулей)>");
    	СтруктураЗаказа.Вставить("shipment_point"         , "<Код ПВЗ СДЭК для самостоятельного привоза клиентом>");
    	СтруктураЗаказа.Вставить("delivery_point"         , "<Код офиса СДЭК, на который будет доставлена посылка>");
    	СтруктураЗаказа.Вставить("date_invoice"           , "<Дата инвойса>");
    	СтруктураЗаказа.Вставить("shipper_name"           , "<Грузоотправитель>");
    	СтруктураЗаказа.Вставить("shipper_address"        , "<Адрес грузоотправителя>");
    		
	    	СтруктураОтправителя = Новый Структура;
	    	СтруктураОтправителя.Вставить("company"                , "<Название компании>");
	    	СтруктураОтправителя.Вставить("name"                   , "<ФИО контактного лица>");
	    	СтруктураОтправителя.Вставить("email"                  , "<Email для оповещений RFC 2822>");
	    	СтруктураОтправителя.Вставить("passport_series"        , "<Серия паспорта>");
	    	СтруктураОтправителя.Вставить("passport_number"        , "<Номер паспорта>");
	    	СтруктураОтправителя.Вставить("passport_date_of_issue" , "<Дата выдачи паспорта>");
	    	СтруктураОтправителя.Вставить("passport_organization"  , "<Орган выдачи паспорта>");
	    	СтруктураОтправителя.Вставить("tin"                    , "<ИНН>");
	    	СтруктураОтправителя.Вставить("passport_date_of_birth" , "<Дата рождения>");
	    	СтруктураОтправителя.Вставить("contragent_type"        , "<Тип отправителя: LEGAL_ENTITY, INDIVIDUAL >");
	    	
		    	МассивТелефонов   = Новый Массив;
		    	СтруктураТелефона = Новый Структура;
		    	
		    	СтруктураТелефона.Вставить("number"    , "<Номер телефона>");
		    	СтруктураТелефона.Вставить("additional", "<Дополнительная информация (добавочный номер)>");
		    	
		    	МассивТелефонов.Добавить(СтруктураТелефона);
	    	
	    	СтруктураОтправителя.Вставить("phones", МассивТелефонов);   
	    		
    	СтруктураЗаказа.Вставить("sender", СтруктураОтправителя);
    	
    		СтруктураАдреса = Новый Структура;
    		СтруктураАдреса.Вставить("code"        , "<Код населенного пункта СДЭК>");
    		СтруктураАдреса.Вставить("fias_guid"   , "<Уникальный идентификатор ФИАС>");
    		СтруктураАдреса.Вставить("postal_code" , "<Почтовый индекс>");
    		СтруктураАдреса.Вставить("longitude"   , "<Долгота>");
    		СтруктураАдреса.Вставить("latitude"    , "<Широта>");
    		СтруктураАдреса.Вставить("country_code", "<Код страны в формате  ISO_3166-1_alpha-2>");
    		СтруктураАдреса.Вставить("region"      , "<Название региона, уточняющий параметр для поля city>");
    		СтруктураАдреса.Вставить("region_code" , "<Код региона СДЭК, уточняющий параметр для поля city>");
    		СтруктураАдреса.Вставить("sub_region"  , "<Название района региона, уточняющий параметр для поля region>");
    		СтруктураАдреса.Вставить("city"        , "<Название города, уточняющий параметр для postal_code>");
    		СтруктураАдреса.Вставить("kladr_code"  , "<Код КЛАДР>");
    		СтруктураАдреса.Вставить("address"     , "<Строка адреса >");
      	
    	СтруктураЗаказа.Вставить("from_location", СтруктураАдреса);
    	СтруктураЗаказа.Вставить("to_location"  , СтруктураАдреса);
    	
    		СтруктураУслуги = Новый Структура;
    		СтруктураУслуги.Вставить("code"     , "<Тип дополнительной услуги>");
    		СтруктураУслуги.Вставить("parameter", "<Параметр дополнительной услуги>");
    		
    	СтруктураЗаказа.Вставить("services"           , СтруктураУслуги);
    	СтруктураЗаказа.Вставить("print"              , "<Необходимость сформировать печатную форму>");
    	СтруктураЗаказа.Вставить("is_client_return"   , "<Клиентский возврат>");
    	СтруктураЗаказа.Вставить("accompanying_number", "<Номер сопроводительной накладной>");
    	СтруктураЗаказа.Вставить("widget_token"       , "<Токен, полученный от widget.cdek.ru>");    	
    	
    	Если ИнтернетМагазин Тогда
    		
    		СтруктураЗаказа.Вставить("number", "<Номер заказа в ИС Клиента (uuid, если не заполнено)>");
    		
	    		СтруктураСбора = Новый Структура;
	    		СтруктураСбора.Вставить("value"   , "<Сумма дополнительного сбора (в том числе и НДС)>");
	    		СтруктураСбора.Вставить("vat_sum" , "<Сумма НДС>");
	    		СтруктураСбора.Вставить("vat_rate", "<Ставка НДС (значение - 0, 10, 12, 20, null - нет НДС)>");  	
	    			
    		СтруктураЗаказа.Вставить("delivery_recipient_cost", СтруктураСбора);
    			
	    		МассивПорогов   = Новый Массив;  		
	    		СтруктураПорога = Новый Структура;
	    		
	    		СтруктураПорога.Вставить("threshold", "<Порог стоимости товара в целых единицах валюты>");
	    		СтруктураПорога.Вставить("sum"      , "<Доп. сбор за доставку товаров, общая стоимость которых в интервале>");
	    		СтруктураПорога.Вставить("vat_sum"  , "<Сумма НДС, включённая в доп. сбор за доставку>");
	    		СтруктураПорога.Вставить("vat_rate" , "<Ставка НДС (значение - 0, 10, 12, 20, null - нет НДС)>");
	    		
	    		МассивПорогов.Добавить(СтруктураПорога);
	    		
    		СтруктураЗаказа.Вставить("delivery_recipient_cost_adv", МассивПорогов);		
    		
    			СтруктураПродавца = Новый Структура;
    			СтруктураПродавца.Вставить("name"          , "<Наименование истинного продавца>");
    			СтруктураПродавца.Вставить("inn"           , "<ИНН истинного продавца>");
    			СтруктураПродавца.Вставить("phone"         , "<Телефон истинного продавца>");
    			СтруктураПродавца.Вставить("ownership_form", "<Код формы собственности>");
    			СтруктураПродавца.Вставить("address"       , "<Адрес истинного продавца>");
    			
    		СтруктураЗаказа.Вставить("seller", СтруктураПродавца);
    		    		
    	КонецЕсли;
    		
    КонецЕсли;

    Если Пустая Тогда
		СтруктураЗаказа = OPI_Инструменты.ОчиститьКоллекциюРекурсивно(СтруктураЗаказа);
    КонецЕсли;

    //@skip-check constructor-function-return-section
    Возврат СтруктураЗаказа;
    
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СформироватьURL(Знач Метод, Знач ТестовыйAPI)

    OPI_ПреобразованиеТипов.ПолучитьБулево(ТестовыйAPI);

    Если ТестовыйAPI Тогда
        URL = "https://api.edu.cdek.ru/v2";
    Иначе
        URL = "https://api.cdek.ru";
    КонецЕсли;

    URL = URL + Метод;

    Возврат URL;

КонецФункции

#КонецОбласти
