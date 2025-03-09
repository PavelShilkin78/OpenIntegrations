﻿// OneScript: ./OInt/tools/Modules/OPI_ПреобразованиеТипов.os

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

// BSLLS:LatinAndCyrillicSymbolInWord-off
// BSLLS:IncorrectLineBreak-off
// BSLLS:UnusedLocalVariable-off
// BSLLS:UsingServiceTag-off

//@skip-check module-structure-top-region
//@skip-check module-structure-method-in-regions
//@skip-check undefined-function-or-procedure
//@skip-check wrong-string-literal-content

#Использовать "./internal"
#Область СлужебныйПрограммныйИнтерфейс

Процедура ПолучитьДвоичныеДанные(Значение, Знач Безусловно = Ложь, Знач ПопыткаB64 = Истина) Экспорт

    Если Значение = Неопределено Тогда
        Возврат;
    КонецЕсли;

    Попытка

        Если ТипЗнч(Значение) = Тип("ДвоичныеДанные") Тогда
            Возврат;
        Иначе
            ПреобразоватьИсточникВЗначение(Значение, ПопыткаB64);
        КонецЕсли;

    Исключение

        Если Безусловно Тогда
            Значение = OPI_Инструменты.ЧислоВСтроку(Значение);
            Значение = ПолучитьДвоичныеДанныеИзСтроки(Значение);
        Иначе
            ВызватьИсключение "Ошибка получения двоичных данных из параметра: " + ОписаниеОшибки();
        КонецЕсли;

    КонецПопытки;

КонецПроцедуры

Процедура ПолучитьДвоичныеИлиПоток(Значение) Экспорт

    Если Значение = Неопределено Тогда
        Возврат;
    КонецЕсли;

    Если ТипЗнч(Значение) <> Тип("Строка") Тогда
        ПолучитьДвоичныеДанные(Значение);
        Возврат;
    КонецЕсли;

    ЗначениеУП = Значение;
    OPI_Инструменты.ВернутьУправляющиеПоследовательности(ЗначениеУП);

    Файл = Новый Файл(ЗначениеУП);

    Если Файл.Существует() Тогда
        Значение = Новый ФайловыйПоток(ЗначениеУП, РежимОткрытияФайла.Открыть);
    Иначе
        ПолучитьДвоичныеДанные(Значение);
    КонецЕсли;

КонецПроцедуры

Процедура ПолучитьКоллекцию(Значение) Экспорт

    Если Значение = Неопределено Тогда
        Возврат;
    КонецЕсли;

    Попытка

        ИсходноеЗначение = Значение;

        Если ЭтоКоллекция(Значение) Тогда
            Возврат;
        Иначе

            Если ТипЗнч(Значение) = Тип("ДвоичныеДанные") Тогда
                Значение = ПолучитьСтрокуИзДвоичныхДанных(Значение);
            Иначе
                Значение = OPI_Инструменты.ЧислоВСтроку(Значение);
            КонецЕсли;

            ЗначениеУП = Значение;
            OPI_Инструменты.ВернутьУправляющиеПоследовательности(ЗначениеУП);

            Файл       = Новый Файл(ЗначениеУП);
            ЧтениеJSON = Новый ЧтениеJSON;

            Если Файл.Существует() Тогда

                ЧтениеJSON.ОткрытьФайл(ЗначениеУП);

            ИначеЕсли СтрНачинаетсяС(СокрЛ(ЗначениеУП), "http://")
                Или СтрНачинаетсяС(СокрЛ(ЗначениеУП), "https://") Тогда

                ИВФ = ПолучитьИмяВременногоФайла();
                КопироватьФайл(ЗначениеУП, ИВФ);
                ЧтениеJSON.ОткрытьФайл(ИВФ);
                ЧтениеJSON.Прочитать();

                УдалитьФайлы(ИВФ);

            Иначе

                ЧтениеJSON.УстановитьСтроку(СокрЛП(Значение));

            КонецЕсли;

            Значение = ПрочитатьJSON(ЧтениеJSON, Истина, Неопределено, ФорматДатыJSON.ISO);
            ЧтениеJSON.Закрыть();

            Если (Не ЭтоКоллекция(Значение)) Или Не ЗначениеЗаполнено(Значение) Тогда

                Значение = ИсходноеЗначение;
                OPI_Инструменты.ЗначениеВМассив(Значение);

            КонецЕсли;

        КонецЕсли;

    Исключение

        Значение = ИсходноеЗначение;
        OPI_Инструменты.ЗначениеВМассив(Значение);

    КонецПопытки;

КонецПроцедуры

Процедура ПолучитьКоллекциюКлючИЗначение(Значение
    , Знач СообщениеОшибки = "Указанное значение не является подходящей коллекцией!") Экспорт

    ПолучитьКоллекцию(Значение);

    Если ТипЗнч(Значение) = Тип("Массив") Тогда
        ВызватьИсключение СообщениеОшибки;
    КонецЕсли;

КонецПроцедуры

Процедура ПолучитьМассив(Значение) Экспорт

    Если ТипЗнч(Значение) = Тип("Массив") Тогда
        Возврат;
    КонецЕсли;

    ПолучитьКоллекцию(Значение);

    Если Не ТипЗнч(Значение) = Тип("Массив") Тогда
        OPI_Инструменты.ЗначениеВМассив(Значение);
    КонецЕсли;

КонецПроцедуры

Процедура ПолучитьБулево(Значение) Экспорт

    Если Значение = Неопределено Тогда
        Возврат;
    КонецЕсли;

    Попытка

        Если ТипЗнч(Значение) = Тип("Булево") Тогда

            Возврат;

        Иначе

            Значение = Булево(Значение);

        КонецЕсли;

    Исключение
        ВызватьИсключение "Ошибка получения данных булево из параметра";
    КонецПопытки;

КонецПроцедуры

Процедура ПолучитьСтроку(Значение, Знач ИзИсточника = Ложь) Экспорт

    Если Значение = Неопределено Тогда
        Возврат;
    КонецЕсли;

    Попытка

        Если ЭтоСимвольное(Значение) Тогда

            Значение = OPI_Инструменты.ЧислоВСтроку(Значение);

            Если Не ИзИсточника Тогда
                Возврат;
            КонецЕсли;

            ЗначениеУП = Значение;
            OPI_Инструменты.ВернутьУправляющиеПоследовательности(ЗначениеУП);

            Файл = Новый Файл(ЗначениеУП);

            Если Файл.Существует() Тогда

                ЧтениеТекста = Новый ЧтениеТекста(ЗначениеУП);
                Значение     = ЧтениеТекста.Прочитать();
                ЧтениеТекста.Закрыть();

            ИначеЕсли СтрНачинаетсяС(СокрЛ(ЗначениеУП), "http://")
                Или СтрНачинаетсяС(СокрЛ(ЗначениеУП), "https://") Тогда

                Значение = OPI_Инструменты.Get(ЗначениеУП);
                ПолучитьСтроку(Значение);

            Иначе

                Значение = OPI_Инструменты.ЧислоВСтроку(Значение);

            КонецЕсли;

        ИначеЕсли ТипЗнч(Значение) = Тип("ДвоичныеДанные") Тогда

            Значение = ПолучитьСтрокуИзДвоичныхДанных(Значение);

        ИначеЕсли ЭтоКоллекция(Значение) Тогда

            Значение = OPI_Инструменты.JSONСтрокой(Значение);

        ИначеЕсли ТипЗнч(Значение) = Тип("ЗаписьXML") Тогда

            Значение = Значение.Закрыть();

        Иначе
            Возврат;
        КонецЕсли;

    Исключение
        Значение = Строка(Значение);
        Возврат;
    КонецПопытки;

КонецПроцедуры

Процедура ПолучитьДату(Значение) Экспорт

    Если Значение = Неопределено Тогда
        Возврат;
    КонецЕсли;

    Дата = "Дата";

    Попытка

        Если ТипЗнч(Значение) = Тип(Дата) Тогда

            Возврат;

        Иначе

            Значение = XMLЗначение(Тип(Дата), Значение);

        КонецЕсли;

    Исключение
        ООД      = Новый ОписаниеТипов(Дата);
        Значение = ООД.ПривестиЗначение(Значение);
    КонецПопытки;

КонецПроцедуры

Процедура ПолучитьЧисло(Значение) Экспорт

    Если ТипЗнч(Значение) = Тип("Число") Тогда

        Возврат;

    ИначеЕсли ТипЗнч(Значение) = Тип("Булево") Тогда

        Значение = ?(Значение, 1, 0);

    Иначе

        ОписаниеТипа = Новый ОписаниеТипов("Число");        
        Значение_    = ОписаниеТипа.ПривестиЗначение(Значение);

        Если Значение_ = 0 Тогда

            Попытка
                
                Значение_     = Строка(Значение);
                Значение_     = СтрЗаменить(Значение, Символы.НПП, "");
                Значение_     = СтрЗаменить(Значение, " ", "");
                Значение_     = СтрЗаменить(Значение, ",", ".");
                
                Если СтрЧислоВхождений(Значение_, ".") > 1 Тогда
                    
                    МассивЧастей   = СтрРазделить(Значение_, ".");
                    ПоследняяЧасть = МассивЧастей.ВГраница();
                    ДробнаяЧасть   = МассивЧастей[ПоследняяЧасть];
                    
                    МассивЧастей.Удалить(ПоследняяЧасть);
                    
                    Значение_ = СтрШаблон("%1.%2", СтрСоединить(МассивЧастей), ДробнаяЧасть);
                        
                КонецЕсли;
                
                Значение = Число(Значение_);
                
            Исключение
                Возврат;
            КонецПопытки;

        Иначе
            Значение = Значение_;
        КонецЕсли;

    КонецЕсли;

КонецПроцедуры

Процедура ПолучитьФайлНаДиске(Значение, Знач Расширение = "tmp") Экспорт

    СтруктураВозврата = Новый Структура("Путь,Временный", "", Ложь);
    ЗначениеСтрокой   = OPI_Инструменты.ЧислоВСтроку(Значение);
    ЗначениеФайл      = Новый Файл(ЗначениеСтрокой);

    Если ЗначениеФайл.Существует() Тогда

        СтруктураВозврата.Вставить("Путь", ЗначениеФайл.ПолноеИмя);

    Иначе

        OPI_ПреобразованиеТипов.ПолучитьДвоичныеДанные(Значение, Истина);

        //@skip-check missing-temporary-file-deletion
        Путь = ПолучитьИмяВременногоФайла(Расширение);
        Значение.Записать(Путь);

        СтруктураВозврата.Вставить("Путь"     , Путь);
        СтруктураВозврата.Вставить("Временный", Истина);

    КонецЕсли;

    Значение = СтруктураВозврата;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ЭтоКоллекция(Знач Значение)

    Возврат ТипЗнч(Значение) = Тип("Массив")
        Или ТипЗнч(Значение) = Тип("Структура")
        Или ТипЗнч(Значение) = Тип("Соответствие");

КонецФункции

Функция ЭтоСимвольное(Знач Значение)

    Возврат ТипЗнч(Значение) = Тип("Строка")
        Или ТипЗнч(Значение) = Тип("Число")
        Или ТипЗнч(Значение) = Тип("Дата");

КонецФункции

Процедура ПреобразоватьИсточникВЗначение(Значение, ПопыткаB64)

    ЗначениеУП = Значение;
    OPI_Инструменты.ВернутьУправляющиеПоследовательности(ЗначениеУП);

    Файл = Новый Файл(ЗначениеУП);

    Если Файл.Существует() Тогда

        Значение = Новый ДвоичныеДанные(ЗначениеУП);

    ИначеЕсли СтрНачинаетсяС(СокрЛ(ЗначениеУП), "http://")
        Или СтрНачинаетсяС(СокрЛ(ЗначениеУП), "https://") Тогда

        Значение = OPI_Инструменты.Get(ЗначениеУП);

    Иначе

        Если ПопыткаB64 Тогда
            Значение = Base64Значение(Значение);
        Иначе
            ВызватьИсключение "значение не является путем к файлу или Base64 строкой";
        КонецЕсли;

    КонецЕсли;

КонецПроцедуры

#КонецОбласти
