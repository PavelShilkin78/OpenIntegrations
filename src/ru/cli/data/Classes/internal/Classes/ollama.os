﻿Функция ПолучитьСостав() Экспорт

    ТаблицаСостава = Новый ТаблицаЗначений();
    ТаблицаСостава.Колонки.Добавить("Библиотека");
    ТаблицаСостава.Колонки.Добавить("Модуль");
    ТаблицаСостава.Колонки.Добавить("Метод");
    ТаблицаСостава.Колонки.Добавить("МетодПоиска");
    ТаблицаСостава.Колонки.Добавить("Параметр");
    ТаблицаСостава.Колонки.Добавить("Описание");
    ТаблицаСостава.Колонки.Добавить("ОписаниеМетода");
    ТаблицаСостава.Колонки.Добавить("Область");

    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьВерсию";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬВЕРСИЮ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Получает версию Ollama";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьВерсию";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬВЕРСИЮ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтвет";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Генерирует ответ по заданному текстовому запросу";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтвет";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТ";
    НоваяСтрока.Параметр    = "--model";
    НоваяСтрока.Описание    = "Имя модели";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтвет";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТ";
    НоваяСтрока.Параметр    = "--prompt";
    НоваяСтрока.Описание    = "Текст запроса";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтвет";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТ";
    НоваяСтрока.Параметр    = "--options";
    НоваяСтрока.Описание    = "Доп. параметры. См. ПолучитьСтруктуруПараметровЗапроса (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтвет";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтветВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Получает очередной ответ от модели в соответствии с историей сообщений
    |
    |    Пример указания параметра типа массив:
    |    --param ""['Val1','Val2','Val3']""
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтветВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--model";
    НоваяСтрока.Описание    = "Имя модели";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтветВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--msgs";
    НоваяСтрока.Описание    = "История сообщений. См. ПолучитьСтруктуруСообщенияКонтекста";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтветВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--options";
    НоваяСтрока.Описание    = "Доп. параметры. См. ПолучитьСтруктуруПараметровЗапроса (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьОтветВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬОТВЕТВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьПредставления";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬПРЕДСТАВЛЕНИЯ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Получает представления (embeddings) для заданных вводных
    |
    |    Пример указания параметра типа массив:
    |    --param ""['Val1','Val2','Val3']""
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьПредставления";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬПРЕДСТАВЛЕНИЯ";
    НоваяСтрока.Параметр    = "--model";
    НоваяСтрока.Описание    = "Имя модели";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьПредставления";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬПРЕДСТАВЛЕНИЯ";
    НоваяСтрока.Параметр    = "--input";
    НоваяСтрока.Описание    = "Строка или массив строк запросов";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьПредставления";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬПРЕДСТАВЛЕНИЯ";
    НоваяСтрока.Параметр    = "--options";
    НоваяСтрока.Описание    = "Доп. параметры. См. ПолучитьСтруктуруПараметровПредставлений (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьПредставления";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬПРЕДСТАВЛЕНИЯ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруПараметровЗапроса";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУПАРАМЕТРОВЗАПРОСА";
    НоваяСтрока.Параметр    = "--empty";
    НоваяСтрока.Описание    = "Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Получает структуру дополнительных параметров для обработки запроса";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруПараметровПредставлений";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУПАРАМЕТРОВПРЕДСТАВЛЕНИЙ";
    НоваяСтрока.Параметр    = "--empty";
    НоваяСтрока.Описание    = "Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Получает структуру дополнительных параметров для обработки запросов получения представлений";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруПараметровВКонтексте";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУПАРАМЕТРОВВКОНТЕКСТЕ";
    НоваяСтрока.Параметр    = "--empty";
    НоваяСтрока.Описание    = "Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Получает структуру дополнительных параметров для обработки запроса в контексте";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруСообщенияКонтекста";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУСООБЩЕНИЯКОНТЕКСТА";
    НоваяСтрока.Параметр    = "--role";
    НоваяСтрока.Описание    = "Источник сообщения: system, user, assistant, tool";
    НоваяСтрока.Область     = "Обработка запросов";
    НоваяСтрока.ОписаниеМетода   = "Получает структуру сообщения для списка сообщений запроса в контексте
    |
    |    Пример указания параметра типа массив:
    |    --param ""['Val1','Val2','Val3']""
    |";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруСообщенияКонтекста";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУСООБЩЕНИЯКОНТЕКСТА";
    НоваяСтрока.Параметр    = "--text";
    НоваяСтрока.Описание    = "Текст сообщения";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруСообщенияКонтекста";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУСООБЩЕНИЯКОНТЕКСТА";
    НоваяСтрока.Параметр    = "--images";
    НоваяСтрока.Описание    = "Список картинок в формате Base64 (для многомодальных моделей, вроде llava) (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруСообщенияКонтекста";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУСООБЩЕНИЯКОНТЕКСТА";
    НоваяСтрока.Параметр    = "--tools";
    НоваяСтрока.Описание    = "Список инструментов в формате JSON, которые модель должна использовать (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Обработка запросов";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСписокМоделей";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСПИСОКМОДЕЛЕЙ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Работа с моделями";
    НоваяСтрока.ОписаниеМетода   = "Получает список локальных моделей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСписокМоделей";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСПИСОКМОДЕЛЕЙ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСписокЗапущенныхМоделей";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСПИСОКЗАПУЩЕННЫХМОДЕЛЕЙ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Работа с моделями";
    НоваяСтрока.ОписаниеМетода   = "Получает список запущенных моделей";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСписокЗапущенныхМоделей";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСПИСОКЗАПУЩЕННЫХМОДЕЛЕЙ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьИнформациюОМодели";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬИНФОРМАЦИЮОМОДЕЛИ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Работа с моделями";
    НоваяСтрока.ОписаниеМетода   = "Получает информацию о выбранной модели";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьИнформациюОМодели";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬИНФОРМАЦИЮОМОДЕЛИ";
    НоваяСтрока.Параметр    = "--model";
    НоваяСтрока.Описание    = "Имя модели";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьИнформациюОМодели";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬИНФОРМАЦИЮОМОДЕЛИ";
    НоваяСтрока.Параметр    = "--verbose";
    НоваяСтрока.Описание    = "Возврат полной информации о модели (необяз. по ум. - Да)";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьИнформациюОМодели";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬИНФОРМАЦИЮОМОДЕЛИ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "СоздатьМодель";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬМОДЕЛЬ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Работа с моделями";
    НоваяСтрока.ОписаниеМетода   = "Создает новую модель с заданными настройками";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "СоздатьМодель";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬМОДЕЛЬ";
    НоваяСтрока.Параметр    = "--model";
    НоваяСтрока.Описание    = "Имя модели";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "СоздатьМодель";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬМОДЕЛЬ";
    НоваяСтрока.Параметр    = "--settings";
    НоваяСтрока.Описание    = "Настройки модели. См. ПолучитьСтруктуруНастроекМодели";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "СоздатьМодель";
    НоваяСтрока.МетодПоиска = "СОЗДАТЬМОДЕЛЬ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "КопироватьМодель";
    НоваяСтрока.МетодПоиска = "КОПИРОВАТЬМОДЕЛЬ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Работа с моделями";
    НоваяСтрока.ОписаниеМетода   = "Копирует существующую модель";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "КопироватьМодель";
    НоваяСтрока.МетодПоиска = "КОПИРОВАТЬМОДЕЛЬ";
    НоваяСтрока.Параметр    = "--model";
    НоваяСтрока.Описание    = "Имя существующей модели";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "КопироватьМодель";
    НоваяСтрока.МетодПоиска = "КОПИРОВАТЬМОДЕЛЬ";
    НоваяСтрока.Параметр    = "--name";
    НоваяСтрока.Описание    = "Имя новой модели";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "КопироватьМодель";
    НоваяСтрока.МетодПоиска = "КОПИРОВАТЬМОДЕЛЬ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "УдалитьМодель";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬМОДЕЛЬ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Работа с моделями";
    НоваяСтрока.ОписаниеМетода   = "Удаляет существующую модель";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "УдалитьМодель";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬМОДЕЛЬ";
    НоваяСтрока.Параметр    = "--model";
    НоваяСтрока.Описание    = "Имя модели";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "УдалитьМодель";
    НоваяСтрока.МетодПоиска = "УДАЛИТЬМОДЕЛЬ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ЗагрузитьМодельВПамять";
    НоваяСтрока.МетодПоиска = "ЗАГРУЗИТЬМОДЕЛЬВПАМЯТЬ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Работа с моделями";
    НоваяСтрока.ОписаниеМетода   = "Загружает выбранную модель в оперативную память";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ЗагрузитьМодельВПамять";
    НоваяСтрока.МетодПоиска = "ЗАГРУЗИТЬМОДЕЛЬВПАМЯТЬ";
    НоваяСтрока.Параметр    = "--model";
    НоваяСтрока.Описание    = "Имя модели";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ЗагрузитьМодельВПамять";
    НоваяСтрока.МетодПоиска = "ЗАГРУЗИТЬМОДЕЛЬВПАМЯТЬ";
    НоваяСтрока.Параметр    = "--keep";
    НоваяСтрока.Описание    = "Время удержания модели в памяти в секундах (необяз. по ум. - 300)";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ЗагрузитьМодельВПамять";
    НоваяСтрока.МетодПоиска = "ЗАГРУЗИТЬМОДЕЛЬВПАМЯТЬ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ВыгрузитьМодельИзПамяти";
    НоваяСтрока.МетодПоиска = "ВЫГРУЗИТЬМОДЕЛЬИЗПАМЯТИ";
    НоваяСтрока.Параметр    = "--url";
    НоваяСтрока.Описание    = "URL сервера Ollama";
    НоваяСтрока.Область     = "Работа с моделями";
    НоваяСтрока.ОписаниеМетода   = "Выгружает выбранную модель из памяти";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ВыгрузитьМодельИзПамяти";
    НоваяСтрока.МетодПоиска = "ВЫГРУЗИТЬМОДЕЛЬИЗПАМЯТИ";
    НоваяСтрока.Параметр    = "--model";
    НоваяСтрока.Описание    = "Имя модели";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ВыгрузитьМодельИзПамяти";
    НоваяСтрока.МетодПоиска = "ВЫГРУЗИТЬМОДЕЛЬИЗПАМЯТИ";
    НоваяСтрока.Параметр    = "--headers";
    НоваяСтрока.Описание    = "Доп заголовки запроса, если необходимо (необяз. по ум. - Пустое значение)";
    НоваяСтрока.Область     = "Работа с моделями";


    НоваяСтрока = ТаблицаСостава.Добавить();
    НоваяСтрока.Библиотека  = "ollama";
    НоваяСтрока.Модуль      = "OPI_Ollama";
    НоваяСтрока.Метод       = "ПолучитьСтруктуруНастроекМодели";
    НоваяСтрока.МетодПоиска = "ПОЛУЧИТЬСТРУКТУРУНАСТРОЕКМОДЕЛИ";
    НоваяСтрока.Параметр    = "--empty";
    НоваяСтрока.Описание    = "Истина > структура с пустыми значениями, Ложь > в значениях будут описания полей (необяз. по ум. - Нет)";
    НоваяСтрока.Область     = "Работа с моделями";
    НоваяСтрока.ОписаниеМетода   = "Получает структуру настроек для создания новой модели";

    Возврат ТаблицаСостава;
КонецФункции

