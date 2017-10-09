﻿
&НаКлиенте
Перем КонтекстЯдра;

&НаКлиенте
Перем Утверждения;

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ВнешниеОбработки.Создать("C:\xUnitFor1C\xddTestRunner.epf", Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Инициализация(ОткрытьФорму("ВнешняяОбработка.xddTestRunner.Форма"));
	
	ТестКлиент = КонтекстЯдра.Плагин("ТестКлиенты").ТестКлиентПоУмолчанию();
	
	Для Каждого Описание Из ОписаниеДобавляемыхТестов(ТестКлиент) Цикл
		НоваяСтрока = КнопкиКомандногоИнтерфейса.Добавить();
		НоваяСтрока.ПредставлениеТеста = Описание.ПредставлениеТеста;
		НоваяСтрока.НавигационнаяСсылка = Описание.НавигационнаяСсылка;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНаборТестов(НаборТестов, КонтекстЯдра) Экспорт
	
	ТестКлиент = КонтекстЯдра.Плагин("ТестКлиенты").ТестКлиентПоУмолчанию();
	
	Для Каждого Описание Из ОписаниеДобавляемыхТестов(ТестКлиент) Цикл
		НаборТестов.Добавить(
		Описание.ИмяТеста,
		НаборТестов.ПараметрыТеста(Описание.НавигационнаяСсылка),
		Описание.ПредставлениеТеста);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗапускомТеста() Экспорт
	
	ЗакрытьВсеОткрытыеОкна();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗапускаТеста() Экспорт
	
	ЗакрытьВсеОткрытыеОкна();
	
КонецПроцедуры

&НаКлиенте
Функция ОписаниеДобавляемыхТестов(ТестКлиент)
	
	Результат = Новый Массив;
	
	ОсновноеОкно = ОсновноеОкно(ТестКлиент);
	КомандныйИнтерфейс = ОсновноеОкно.ПолучитьКомандныйИнтерфейс();
	ПанельРазделов = КомандныйИнтерфейс.НайтиОбъект(Тип("ТестируемаяГруппаКомандногоИнтерфейса"), НСтр("ru = 'Панель разделов'"));
	Для Каждого ТекКнопкаРаздел Из ПанельРазделов.НайтиОбъекты(Тип("ТестируемаяКнопкаКомандногоИнтерфейса")) Цикл
		ТекКнопкаРаздел.Нажать();
		ДобавитьОписаниеТеста(Результат, КомандныйИнтерфейс, ТекКнопкаРаздел.ТекстЗаголовка);
		ТекКнопкаРаздел.Нажать();
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ДобавитьОписаниеТеста(ОписаниеТестов, КомандныйИнтерфейс, ТекстЗаголовка)
	
	Для Каждого ТекРаздел Из КомандныйИнтерфейс.НайтиОбъекты(Тип("ТестируемаяГруппаКомандногоИнтерфейса")) Цикл
		
		Если ЭтоСлужебныйРаздел(ТекРаздел) Тогда 
			Продолжить;
		КонецЕсли;
		
		Для Каждого ТекКнопка Из ТекРаздел.ПолучитьПодчиненныеОбъекты() Цикл
			ДобавляемоеОписание = Новый Структура;
			ДобавляемоеОписание.Вставить("ПредставлениеТеста", СтрШаблон("%1_%2_%3", ТекстЗаголовка, ТекРаздел.ТекстЗаголовка, ТекКнопка.ТекстЗаголовка));
			ДобавляемоеОписание.Вставить("НавигационнаяСсылка", ТекКнопка.НавигационнаяСсылка);
			ДобавляемоеОписание.Вставить("ИмяТеста", ИмяТеста(ТекКнопка.НавигационнаяСсылка));
			ОписаниеТестов.Добавить(ДобавляемоеОписание);
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция ИмяТеста(ПараметрНавигационнаяСсылка)
	
	ПропускаемыеНавигационныеСсылки = Новый Массив;
	ПропускаемыеНавигационныеСсылки.Добавить("e1cib/command/ОбщаяКоманда.СтраницаМобильноеПриложениеНаAppStore");
	ПропускаемыеНавигационныеСсылки.Добавить("e1cib/command/ОбщаяКоманда.СтраницаМобильноеПриложениеНаGooglePlay");
	ПропускаемыеНавигационныеСсылки.Добавить("e1cib/command/ОбщаяКоманда.СтраницаПродуктаНаСайте1С");
	ПропускаемыеНавигационныеСсылки.Добавить("e1cib/command/ОбщаяКоманда.СтраницаЧтоНовогоВВерсииВидео");
	
	Если ПропускаемыеНавигационныеСсылки.Найти(ПараметрНавигационнаяСсылка) = Неопределено Тогда
		Возврат "ТестДолжен_ПерейтиПоКнопкеКомандногоИнтерфейса";
	Иначе
		Возврат "ТестДолжен_ПропуститьВыполнение";
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Функция ЭтоСлужебныйРаздел(ГруппаКомандногоИнтерфейса)
	
	ЗаголовкиСлужебныхРазделов = Новый Массив;
	ЗаголовкиСлужебныхРазделов.Добавить(НСтр("ru = 'Панель разделов'"));
	ЗаголовкиСлужебныхРазделов.Добавить(НСтр("ru = 'Панель инструментов'"));
	ЗаголовкиСлужебныхРазделов.Добавить(НСтр("ru = 'Панель открытых'"));
	ЗаголовкиСлужебныхРазделов.Добавить(НСтр("ru = 'Меню функций'"));
	
	Для Каждого ТекЗаголовок Из ЗаголовкиСлужебныхРазделов Цикл
		Если НРег(ГруппаКомандногоИнтерфейса.ТекстЗаголовка) = НРег(ТекЗаголовок) Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

&НаКлиенте
Процедура КнопкиКомандногоИнтерфейсаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ПередЗапускомТеста();
	ТестДолжен_ПерейтиПоКнопкеКомандногоИнтерфейса(Элементы.КнопкиКомандногоИнтерфейса.ТекущиеДанные.НавигационнаяСсылка);
	ПослеЗапускаТеста();
	
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ПропуститьВыполнение(ПараметрНавигационнаяСсылка) Экспорт
	
	Возврат;
	
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ПерейтиПоКнопкеКомандногоИнтерфейса(ПараметрНавигационнаяСсылка) Экспорт
	
	ТестКлиент = КонтекстЯдра.Плагин("ТестКлиенты").ТестКлиентПоУмолчанию();
	ОсновноеОкно = ОсновноеОкно(ТестКлиент);
	ОсновноеОкно.ВыполнитьКоманду(ПараметрНавигационнаяСсылка);
	
	ИдентифицироватьОкноПредупреждение(ПереходПоКнопкеКомандногоИнтерфейса(), ТестКлиент);
	
	ОписанияШаговСценария = Новый Массив;
	ОписанияШаговСценария.Добавить(КликПоПервойСтрокеТаблицыФормы());
	ОписанияШаговСценария.Добавить(КликПоПоследнейСтрокеТаблицыФормы());
	
	ОкноСТаблицейФормы= ТестКлиент.ПолучитьАктивноеОкно();
	
	Для Каждого ШагСценария Из ОписанияШаговСценария Цикл
		ВыполнитьШагПроверкиТаблицыФормы(ОкноСТаблицейФормы, ШагСценария, ТестКлиент);
		ИдентифицироватьОкноПредупреждение(ШагСценария, ТестКлиент);
	КонецЦикла;
	
	ЗакрытьВсеОткрытыеОкна();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьШагПроверкиТаблицыФормы(ОкноСТаблицейФормы, ШагСценария, ТестКлиент)
	
	ТаблицаФормы = ОкноСТаблицейФормы.НайтиОбъект(Тип("ТестируемаяТаблицаФормы"));
	Если ТаблицаФормы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ТаблицаФормы.ТекущаяДоступность() Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ТаблицаФормы.ТекущаяВидимость() Тогда
		Возврат;
	КонецЕсли;
	
	ПерейтиКЗаданнойСтрокеТаблицыФормы(ШагСценария, ТаблицаФормы, ТестКлиент);
	
	Если Не ЗначениеЗаполнено(ТаблицаФормы.ПолучитьВыделенныеСтроки()) Тогда
		Возврат;
	КонецЕсли;
	
	ТаблицаФормы.Выбрать();
	
	ИдентифицироватьОкноПредупреждение(ШагСценария, ТестКлиент);
	
	ТекущееОкно = ТестКлиент.ПолучитьАктивноеОкно();
	Если ПриКликеВТаблицеФормыНовоеОкноНеОткрылось(ТекущееОкно, ОкноСТаблицейФормы) Тогда
		Возврат;
	КонецЕсли;
	
	НажатьКнопкуЗаписать(ШагСценария, ТекущееОкно, ТестКлиент);
	
	ТекущееОкно.Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиКЗаданнойСтрокеТаблицыФормы(ШагСценария, ТаблицаФормы, ТестКлиент)
	
	Если ШагСценария = КликПоПервойСтрокеТаблицыФормы() Тогда
		
		ТаблицаФормы.ПерейтиКПервойСтроке();
		
	ИначеЕсли ШагСценария = КликПоПоследнейСтрокеТаблицыФормы() Тогда
		
		ТаблицаФормы.ПерейтиКПоследнейСтроке();
		
	Иначе
		
		ВызватьИсключение СтрШаблон("Поведение для шага ""%1"" не определено", ШагСценария);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПриКликеВТаблицеФормыНовоеОкноНеОткрылось(ТекущееОкно, ОкноСТаблицейФормы)
	
	Возврат ТекущееОкно = ОкноСТаблицейФормы;
	
КонецФункции

&НаКлиенте
Процедура НажатьКнопкуЗаписать(ШагСценария, ТекущееОкно, ТестКлиент)
	
	КнопкаЗаписать = ТекущееОкно.НайтиОбъект(Тип("ТестируемаяКнопкаФормы"), "Записать");
	Если КнопкаЗаписать = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Не КнопкаЗаписать.ТекущаяВидимость() Тогда
		Возврат;
	КонецЕсли;
	
	Если Не КнопкаЗаписать.ТекущаяДоступность() Тогда
		Возврат;
	КонецЕсли;
	
	КнопкаЗаписать.Нажать();
	
	ИдентифицироватьОкноПредупреждение(
	СтрШаблон("%1: Кнопка ""Записать""", ШагСценария),
	ТестКлиент);
	
КонецПроцедуры

&НаКлиенте
Функция ПереходПоКнопкеКомандногоИнтерфейса()
	
	Возврат "Переход по кнопке командного интерфейса";
	
КонецФункции

&НаКлиенте
Функция КликПоПервойСтрокеТаблицыФормы()
	
	Возврат "Клик по первой строке таблицы формы";
	
КонецФункции

&НаКлиенте
Функция КликПоПоследнейСтрокеТаблицыФормы()
	
	Возврат "Клик по последней строке таблицы формы";
	
КонецФункции

&НаКлиенте
Процедура ИдентифицироватьОкноПредупреждение(ШагСценария, ТестКлиент)
	
	ОкноПредупреждение = ТестКлиент.НайтиОбъект(Тип("ТестируемоеОкноКлиентскогоПриложения"), "1С:Предприятие");
	Если ТипЗнч(ОкноПредупреждение) <> Тип("ТестируемоеОкноКлиентскогоПриложения") Тогда
		Возврат;
	КонецЕсли;
	
	ТекстИсключения = ТекстИсключения(ОкноПредупреждение);
	ЗакрытьВсеОткрытыеОкна();
	
	ВызватьИсключение СтрШаблон("[%1] %2", ШагСценария, ТекстИсключения);
	
КонецПроцедуры

&НаКлиенте
Функция ТекстИсключения(ОкноПредупреждение)
	
	ТекстыЗаголовков = Новый Массив;
	Для Каждого ТекОбъект Из ОкноПредупреждение.НайтиОбъекты(Тип("ТестируемоеПолеФормы")) Цикл
		ТекстыЗаголовков.Добавить(ТекОбъект.ТекстЗаголовка);
	КонецЦикла;
	
	Возврат СтрСоединить(ТекстыЗаголовков, " ");
	
КонецФункции

&НаКлиенте
Функция ОсновноеОкно(ТестКлиент)
	
	Для Каждого ТестируемоеОкно Из ТестКлиент.ПолучитьПодчиненныеОбъекты() Цикл
		Если ТестируемоеОкно.Основное Тогда
			Возврат ТестируемоеОкно;
		КонецЕсли;
	КонецЦикла;
	
КонецФункции

&НаКлиенте
Процедура ЗакрытьВсеОткрытыеОкна()
	
	ТестКлиент = КонтекстЯдра.Плагин("ТестКлиенты").ТестКлиентПоУмолчанию();
	
	ОкноПредупреждение = ТестКлиент.НайтиОбъект(Тип("ТестируемоеОкноКлиентскогоПриложения"), НСтр("ru = '1С:Предприятие'"));
	НажатьПодходящуюКнопку(ОкноПредупреждение);
	
	ОткрытыеОкна = ТестКлиент.НайтиОбъекты(Тип("ТестируемоеОкноКлиентскогоПриложения"));
	Для Каждого ТекОкно Из ОткрытыеОкна Цикл
		Если ТекОкно.Основное Тогда
			Продолжить;
		КонецЕсли;
		
		Попытка
			ТекОкно.Закрыть();
		Исключение
		КонецПопытки;
		
		ОкноПредупреждение = ТестКлиент.НайтиОбъект(Тип("ТестируемоеОкноКлиентскогоПриложения"), НСтр("ru = '1С:Предприятие'"));
		НажатьПодходящуюКнопку(ОкноПредупреждение);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура НажатьПодходящуюКнопку(ОкноПриложения)
	
	Если ТипЗнч(ОкноПриложения) <> Тип("ТестируемоеОкноКлиентскогоПриложения") Тогда
		Возврат;
	КонецЕсли;
	
	Кнопки = ОкноПриложения.НайтиОбъекты(Тип("ТестируемаяКнопкаФормы"));
	Если Не ЗначениеЗаполнено(Кнопки) Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ПолеФормы Из ОкноПриложения.НайтиОбъекты(Тип("ТестируемоеПолеФормы")) Цикл
		Если СтрНачинаетсяС(НРег(ПолеФормы.ТекстЗаголовка), "данные были изменены") Тогда
			Кнопки[1].Нажать();
			Возврат;
		КонецЕсли;
	КонецЦикла;
	
	Кнопки[0].Нажать();
	
КонецПроцедуры

