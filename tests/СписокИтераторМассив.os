#Использовать asserts
#Использовать ".."
#Использовать "./ТестМодуль"

Перем Рефлектор;               // Рефлектор
Перем ДляКаждогоВыполнилсяРаз; // Количество раз которое выполнился метод ДляКаждого

&Тест
Процедура ИтераторСоздается() Экспорт

	// Когда
	Результат = Новый СписокИтераторМассив(Новый Массив, ЭтотОбъект);

	// Тогда

	Ожидаем.Что(Результат).ИмеетТип("СписокИтераторМассив");

КонецПроцедуры

&Тест
Процедура ИтераторПодписанНаМодификациюКоллекции() Экспорт
	
	// Дано

	Итератор = Новый СписокИтераторМассив(Новый Массив, ЭтотОбъект);

	// Когда
	
	ВызватьСобытие("КоллекцияМодифицирована", Новый Массив);

	// Тогда
	
	Ожидаем.Что(Рефлектор.ПолучитьСвойство(Итератор, "КоллекцияМодифицирована")).ЭтоИстина();

КонецПроцедуры

&Тест
Процедура ИтераторНеИнвалидируетсяПриМутацииСамимСобой() Экспорт
	
	// Дано

	Итератор = Новый СписокИтераторМассив(Новый Массив, ЭтотОбъект);

	// Когда
	
	Параметры = Новый Массив;
	Параметры.Добавить(Итератор);

	ВызватьСобытие("КоллекцияМодифицирована", Параметры);

	// Тогда
	
	Ожидаем.Что(Рефлектор.ПолучитьСвойство(Итератор, "КоллекцияМодифицирована")).ЭтоЛожь();

КонецПроцедуры

&Тест
Процедура ЕстьСледующий() Экспорт
	
	// Дано
	
	Коллекция = Новый Массив;
	Коллекция.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);

	// Когда

	Результат = Итератор.ЕстьСледующий();

	// Тогда

	Ожидаем.Что(Результат).ЭтоИстина();

КонецПроцедуры

&Тест
Процедура НетСледующего() Экспорт
	
	// Дано
	
	Итератор = Новый СписокИтераторМассив(Новый Массив, ЭтотОбъект);

	// Когда

	Результат = Итератор.ЕстьСледующий();

	// Тогда

	Ожидаем.Что(Результат).ЭтоЛожь();

КонецПроцедуры

&Тест
Процедура Следующий() Экспорт
	
	// Дано
	
	Коллекция = Новый Массив;
	Коллекция.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);

	// Когда

	Результат = Итератор.Следующий();

	// Тогда

	Ожидаем.Что(Результат).Равно(1);

КонецПроцедуры

&Тест
Процедура СледующийВызываетИсключениеПриКонкурентнойМодификации() Экспорт
	
	// Дано
	
	Массив = Новый Массив;
	Массив.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Массив, ЭтотОбъект);
	Рефлектор.УстановитьСвойство(Итератор, "КоллекцияМодифицирована", Истина);

	// Тогда

	Ожидаем.Что(Итератор)
		.Метод("Следующий")
		.ВыбрасываетИсключение("Коллекция была изменена в процессе обхода");

КонецПроцедуры

&Тест
Процедура СледующийВызываетИсключениеПриВыходеЗаГраницы() Экспорт
	
	// Дано
	
	Итератор = Новый СписокИтераторМассив(Новый Массив, ЭтотОбъект);

	// Тогда

	Ожидаем.Что(Итератор)
		.Метод("Следующий")
		.ВыбрасываетИсключение("Значение индекса выходит за пределы диапазона");

КонецПроцедуры

&Тест
Процедура Удалить() Экспорт
	
	// Дано
	
	Коллекция = Новый Массив;
	Коллекция.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	Итератор.Следующий();

	// Когда

	Итератор.Удалить(); 

	// Тогда

	Ожидаем.Что(Коллекция).ИмеетДлину(0);

КонецПроцедуры

&Тест
Процедура УдалитьВызываетИсключениеПриКонкурентнойМодификации() Экспорт
	
	// Дано
	
	Массив = Новый Массив;
	Массив.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Массив, ЭтотОбъект);
	Итератор.Следующий();

	// Когда
	
	Рефлектор.УстановитьСвойство(Итератор, "КоллекцияМодифицирована", Истина);

	// Тогда

	Ожидаем.Что(Итератор)
		.Метод("Удалить")
		.ВыбрасываетИсключение("Коллекция была изменена в процессе обхода");

КонецПроцедуры

&Тест
Процедура УдалитьВызываетИсключениеПриНеустановленномЭлементе() Экспорт
	
	// Дано
	
	Итератор = Новый СписокИтераторМассив(Новый Массив, ЭтотОбъект);

	// Тогда

	Ожидаем.Что(Итератор)
		.Метод("Удалить")
		.ВыбрасываетИсключение("Итератор не указывает на элемент коллекции");

КонецПроцедуры

&Тест
Процедура ДляКаждогоОставшегося() Экспорт
	
	// Дано
	
	ДляКаждогоВыполнилсяРаз = 0;

	Коллекция = Новый Массив;
	Коллекция.Добавить(0);
	Коллекция.Добавить(1);
	Коллекция.Добавить(2);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	
	Итератор.Следующий();

	// Когда

	Итератор.ДляКаждогоОставшегося(Новый Действие(ЭтотОбъект, "ДействиеДляКаждогоОставшегося"));

	// Тогда

	Ожидаем.Что(ДляКаждогоВыполнилсяРаз).Равно(2);
	Ожидаем.Что(Итератор.ЕстьСледующий()).ЭтоЛожь();

КонецПроцедуры

&Тест
Процедура ДляКаждогоОставшегосяЛямбда() Экспорт
	
	// Дано
	
	ТестМодуль.ДляКаждогоВыполнилсяРаз = 0;
	ТестМодуль.СуммаЭлементов          = 0;

	Коллекция = Новый Массив;
	Коллекция.Добавить(0);
	Коллекция.Добавить(1);
	Коллекция.Добавить(2);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	
	Итератор.Следующий();

	// Когда

	Итератор.ДляКаждогоОставшегося(
		"Элемент -> ТестМодуль.ДляКаждогоВыполнилсяРаз = ТестМодуль.ДляКаждогоВыполнилсяРаз + 1;
		|	ТестМодуль.СуммаЭлементов = ТестМодуль.СуммаЭлементов + Элемент;"
	);

	// Тогда

	Ожидаем.Что(ТестМодуль.ДляКаждогоВыполнилсяРаз).Равно(2);
	Ожидаем.Что(ТестМодуль.СуммаЭлементов).Равно(3);
	Ожидаем.Что(Итератор.ЕстьСледующий()).ЭтоЛожь();

КонецПроцедуры

&Тест
Процедура ДляКаждогоОставшегосяЛямбдаКонтекстСтруктура() Экспорт
	
	// Дано
	
	Контекст = Новый Структура("ДляКаждогоВыполнилсяРаз, СуммаЭлементов", 0, 0);

	Коллекция = Новый Массив;
	Коллекция.Добавить(0);
	Коллекция.Добавить(1);
	Коллекция.Добавить(2);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	
	Итератор.Следующий();

	// Когда

	Итератор.ДляКаждогоОставшегося(
		"Элемент -> Контекст.ДляКаждогоВыполнилсяРаз = Контекст.ДляКаждогоВыполнилсяРаз + 1;
		|	Контекст.СуммаЭлементов = Контекст.СуммаЭлементов + Элемент;",
		Новый Структура("Контекст", Контекст)
	);

	// Тогда

	Ожидаем.Что(Контекст.ДляКаждогоВыполнилсяРаз).Равно(2);
	Ожидаем.Что(Контекст.СуммаЭлементов).Равно(3);
	Ожидаем.Что(Итератор.ЕстьСледующий()).ЭтоЛожь();

КонецПроцедуры

&Тест
Процедура ДляКаждогоОставшегосяЛямбдаКонтекстОбъект() Экспорт
	
	// Дано
	
	ТестМодуль.ДляКаждогоВыполнилсяРаз = 0;
	ТестМодуль.СуммаЭлементов          = 0;

	Коллекция = Новый Массив;
	Коллекция.Добавить(0);
	Коллекция.Добавить(1);
	Коллекция.Добавить(2);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	
	Итератор.Следующий();

	// Когда

	Итератор.ДляКаждогоОставшегося(
		"Элемент -> ДляКаждогоВыполнилсяРаз = ДляКаждогоВыполнилсяРаз + 1;
		|	СуммаЭлементов = СуммаЭлементов + Элемент;",
		ТестМодуль
	);

	// Тогда

	Ожидаем.Что(ТестМодуль.ДляКаждогоВыполнилсяРаз).Равно(2);
	Ожидаем.Что(ТестМодуль.СуммаЭлементов).Равно(3);
	Ожидаем.Что(Итератор.ЕстьСледующий()).ЭтоЛожь();

КонецПроцедуры

&Тест
Процедура ПриМутацииИтераторомИнвалидируютсяДругиеИтераторы() Экспорт
	
	// Дано
	
	ДляКаждогоВыполнилсяРаз = 0;

	Коллекция = Новый Массив;
	Коллекция.Добавить(0);
	Коллекция.Добавить(1);
	Коллекция.Добавить(2);

	ИтераторМутирующий       = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	ИтераторИнвалидирующийся = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	
	// Когда
	
	ИтераторМутирующий.Следующий();
	ИтераторМутирующий.Удалить();

	// Тогда

	Ожидаем.Что(Рефлектор.ПолучитьСвойство(ИтераторИнвалидирующийся, "КоллекцияМодифицирована")).ЭтоИстина();
	Ожидаем.Что(Рефлектор.ПолучитьСвойство(ИтераторМутирующий, "КоллекцияМодифицирована")).ЭтоЛожь();

КонецПроцедуры

Процедура ДействиеДляКаждогоОставшегося(Элемент) Экспорт
	
	ДляКаждогоВыполнилсяРаз = ДляКаждогоВыполнилсяРаз + 1;

	Ожидаем.Что(Элемент).Равно(ДляКаждогоВыполнилсяРаз);

КонецПроцедуры

&Тест
Процедура ЕстьПредыдущий() Экспорт
	
	// Дано
	
	Коллекция = Новый Массив;
	Коллекция.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	Итератор.Следующий();

	// Когда

	Результат = Итератор.ЕстьПредыдущий();

	// Тогда

	Ожидаем.Что(Результат).ЭтоИстина();

КонецПроцедуры

&Тест
Процедура НетПредыдущего() Экспорт
	
	// Дано
	
	Итератор = Новый СписокИтераторМассив(Новый Массив, ЭтотОбъект);

	// Когда

	Результат = Итератор.ЕстьПредыдущий();

	// Тогда

	Ожидаем.Что(Результат).ЭтоЛожь();

КонецПроцедуры

&Тест
Процедура Предыдущий() Экспорт
	
	// Дано
	
	Коллекция = Новый Массив;
	Коллекция.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	Итератор.Следующий();

	// Когда

	Результат = Итератор.Предыдущий();

	// Тогда

	Ожидаем.Что(Результат).Равно(1);

КонецПроцедуры

&Тест
Процедура ПредыдущийВызываетИсключениеПриКонкурентнойМодификации() Экспорт
	
	// Дано
	
	Массив = Новый Массив;
	Массив.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Массив, ЭтотОбъект);
	Итератор.Следующий();
	Рефлектор.УстановитьСвойство(Итератор, "КоллекцияМодифицирована", Истина);

	// Тогда

	Ожидаем.Что(Итератор)
		.Метод("Предыдущий")
		.ВыбрасываетИсключение("Коллекция была изменена в процессе обхода");

КонецПроцедуры

&Тест
Процедура ПредыдущийВызываетИсключениеПриВыходеЗаГраницы() Экспорт
	
	// Дано
	
	Итератор = Новый СписокИтераторМассив(Новый Массив, ЭтотОбъект);

	// Тогда

	Ожидаем.Что(Итератор)
		.Метод("Предыдущий")
		.ВыбрасываетИсключение("Значение индекса выходит за пределы диапазона");

КонецПроцедуры

&Тест
Процедура СледующийИндекс() Экспорт
	
	// Дано
	
	Коллекция = Новый Массив;
	Коллекция.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	Итератор.Следующий();

	// Когда

	Результат = Итератор.СледующийИндекс();

	// Тогда

	Ожидаем.Что(Результат).Равно(1);

КонецПроцедуры

&Тест
Процедура ПредыдущийИндекс() Экспорт
	
	// Дано
	
	Коллекция = Новый Массив;
	Коллекция.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	Итератор.Следующий();

	// Когда

	Результат = Итератор.ПредыдущийИндекс();

	// Тогда

	Ожидаем.Что(Результат).Равно(0);

КонецПроцедуры

&Тест
Процедура Установить() Экспорт
	
	// Дано
	
	Коллекция = Новый Массив;
	Коллекция.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	Итератор.Следующий();

	// Когда

	Итератор.Установить(2);

	// Тогда

	Ожидаем.Что(Коллекция)
		.ИмеетДлину(1)
		.Содержит(2);

КонецПроцедуры

&Тест
Процедура УстановитьВызываетИсключениеПриКонкурентнойМодификации() Экспорт
	
	// Дано
	
	Массив = Новый Массив;
	Массив.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Массив, ЭтотОбъект);
	Итератор.Следующий();

	// Когда

	Рефлектор.УстановитьСвойство(Итератор, "КоллекцияМодифицирована", Истина);

	Параметры = Новый Массив;
	Параметры.Добавить(1);

	// Тогда

	Ожидаем.Что(Итератор)
		.Метод("Установить", Параметры)
		.ВыбрасываетИсключение("Коллекция была изменена в процессе обхода");

КонецПроцедуры

&Тест
Процедура УстановитьВызываетИсключениеПриНеустановленномЭлементе() Экспорт
	
	// Дано
	
	Итератор = Новый СписокИтераторМассив(Новый Массив, ЭтотОбъект);

	Параметры = Новый Массив;
	Параметры.Добавить(1);

	// Тогда

	Ожидаем.Что(Итератор)
		.Метод("Установить", Параметры)
		.ВыбрасываетИсключение("Итератор не указывает на элемент коллекции");

КонецПроцедуры

&Тест
Процедура Вставить() Экспорт
	
	// Дано
	
	Коллекция = Новый Массив;
	Коллекция.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Коллекция, ЭтотОбъект);
	Итератор.Следующий();

	// Когда

	Итератор.Вставить(2);

	// Тогда

	Ожидаем.Что(Коллекция)
		.ИмеетДлину(2)
		.Содержит(1)
		.Содержит(2);

КонецПроцедуры

&Тест
Процедура ВставитьВызываетИсключениеПриКонкурентнойМодификации() Экспорт
	
	// Дано
	
	Массив = Новый Массив;
	Массив.Добавить(1);

	Итератор = Новый СписокИтераторМассив(Массив, ЭтотОбъект);
	Итератор.Следующий();

	// Когда
	
	Рефлектор.УстановитьСвойство(Итератор, "КоллекцияМодифицирована", Истина);

	Параметры = Новый Массив;
	Параметры.Добавить(1);

	// Тогда

	Ожидаем.Что(Итератор)
		.Метод("Вставить", Параметры)
		.ВыбрасываетИсключение("Коллекция была изменена в процессе обхода");

КонецПроцедуры

Рефлектор = Новый Рефлектор;
