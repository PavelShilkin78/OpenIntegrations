#Область СлужебныйПрограммныйИнтерфейс

Процедура ПолучитьДвоичныеДанные(Значение) Экспорт
    
    Попытка 
        
        Если ТипЗнч(Значение) = Тип("ДвоичныеДанные") Тогда
            Возврат;
        Иначе
            
            Файл = Новый Файл(Значение);
            
            Если Файл.Существует() Тогда
                Значение = Новый ДвоичныеДанные(Значение);
                
            ИначеЕсли СтрНайти(Значение, "//") Тогда
                
                ИВФ = ПолучитьИмяВременногоФайла();
                КопироватьФайл(Значение, ИВФ);
                
                Значение = Новый ДвоичныеДанные(ИВФ);
                
                УдалитьФайлы(ИВФ);
                
            Иначе
                
                Значение = Base64Значение(Значение);
                
            КонецЕсли;
                  
        КонецЕсли;
    
    Исключение
        ВызватьИсключение "Ошибка получения двоичных данных из параметра";
    КонецПопытки;
    
КонецПроцедуры

Процедура ПолучитьКоллекцию(Значение) Экспорт
    
    Попытка 
        
        Если ТипЗнч(Значение) = Тип("Структура") 
            Или ТипЗнч(Значение) = Тип("Соответствие")
            Или ТипЗнч(Значение) = Тип("Массив") Тогда
            Возврат;
        Иначе
            
            Файл        = Новый Файл(Значение);
            ЧтениеJSON  = Новый ЧтениеJSON;
            
            Если Файл.Существует() Тогда
                
                ЧтениеJSON.ОткрытьФайл(Значение);
                ЧтениеJSON.Прочитать();
                
           ИначеЕсли СтрНайти(Значение, "://") Тогда
                
                ИВФ = ПолучитьИмяВременногоФайла();
                КопироватьФайл(Значение, ИВФ);
                ЧтениеJSON.ОткрытьФайл(ИВФ);
                ЧтениеJSON.Прочитать();
                
                УдалитьФайлы(ИВФ);
                
            Иначе
                
                ЧтениеJSON.УстановитьСтроку(СокрЛП(Значение));
                
            КонецЕсли;
            
            Значение = ПрочитатьJSON(ЧтениеJSON, Истина, Неопределено, ФорматДатыJSON.ISO);
            ЧтениеJSON.Закрыть();
                 
        КонецЕсли;
    
    Исключение
        
        Если ТипЗнч(Значение) = Тип("Строка") И СтрНайти(Значение, "[") > 0 Тогда
            
            Значение = СтрЗаменить(Значение, "['"   , "");
            Значение = СтрЗаменить(Значение, "']"   , "");
            Значение = СтрЗаменить(Значение, "', '" , "','");
            Значение = СтрЗаменить(Значение, "' , '", "','");
            Значение = СтрЗаменить(Значение, "' ,'" , "','");
        
            Значение = СтрРазделить(Значение, "','", Ложь);
        
            Для Н = 0 По Значение.ВГраница() Цикл
                Значение[Н] = СокрЛП(Значение[Н]);
            КонецЦикла;
            
        Иначе
            Значение_ = Новый Массив;
            Значение_.Добавить(Значение);
            Значение = Значение_;
        КонецЕсли;
        
    КонецПопытки;
        
КонецПроцедуры

Процедура ПолучитьБулево(Значение) Экспорт
    
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
    
    Если Не ИзИсточника Тогда
        Значение = OPI_Инструменты.ЧислоВСтроку(Значение);
        Возврат;    
    КонецЕсли;
    
    Попытка 
        
        Если ТипЗнч(Значение) = Тип("Строка")
            Или ТипЗнч(Значение) = Тип("Число") 
            Или ТипЗнч(Значение) = Тип("Дата") Тогда
              
            Значение = OPI_Инструменты.ЧислоВСтроку(Значение);  
            Файл     = Новый Файл(Значение);
            
            Если Файл.Существует() Тогда
                
                ЧтениеТекста = Новый ЧтениеТекста(Значение);
                Значение     = ЧтениеТекста.Прочитать();
                ЧтениеТекста.Закрыть();
                
            ИначеЕсли СтрНайти(Значение, "://") Тогда
                
                ИВФ = ПолучитьИмяВременногоФайла();
                КопироватьФайл(Значение, ИВФ);
                
                ЧтениеТекста = Новый ЧтениеТекста(ИВФ);
                Значение     = ЧтениеТекста.Прочитать();
                ЧтениеТекста.Закрыть();
                
                УдалитьФайлы(ИВФ);
                
            Иначе
                
                Возврат;
                
            КонецЕсли;
            
        ИначеЕсли ТипЗнч(Значение) = Тип("ДвоичныеДанные") Тогда
            
            Значение = ПолучитьСтрокуИзДвоичныхДанных(Значение);
            
        ИначеЕсли ТипЗнч(Значение) = Тип("Массив")
            Или ТипЗнч(Значение) = Тип("Структура")
            Или ТипЗнч(Значение) = Тип("Соответствие") Тогда
                
            Значение = OPI_Инструменты.JSONСтрокой(Значение); 
            
        Иначе
            Возврат;
        КонецЕсли;
                  
    Исключение
        Значение = Строка(Значение);
        Возврат;
    КонецПопытки;
    
КонецПроцедуры

Процедура ПолучитьДату(Значение) Экспорт
  
    Попытка 
        
        Если ТипЗнч(Значение) = Тип("Дата") Тогда
            Возврат;
        Иначе         
            Значение = XMLЗначение(Тип("Дата"), Значение);                   
        КонецЕсли;
    
    Исключение
        ВызватьИсключение "Ошибка получения даты из параметра";
    КонецПопытки;
        
КонецПроцедуры

#КонецОбласти