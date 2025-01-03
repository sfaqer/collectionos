#Использовать fluent
#Использовать optional
#Использовать reflector

#Использовать "../../../internal"

Перем Очередь;              // Внутренняя приоритетная очередь
Перем ИнтерфейсОтложенный;  // Интерфейс
Перем Блокировка;           // Блокировка на синхронизированном представлении внутренней очереди

Функция Итератор() Экспорт
	Возврат Очередь.Итератор();
КонецФункции

Процедура ДляКаждого(Знач Алгоритм, Контекст = Неопределено) Экспорт
	Очередь.ДляКаждого(Алгоритм, Контекст);
КонецПроцедуры

Функция Содержит(Элемент) Экспорт
	Возврат Очередь.Содержит(Элемент);
КонецФункции

Функция СодержитВсе(Коллекция) Экспорт
	Возврат Очередь.СодержитВсе(Коллекция);
КонецФункции

Функция Пусто() Экспорт
	Возврат Очередь.Пусто();
КонецФункции

Функция ПроцессорКоллекции() Экспорт
	Возврат Очередь.ПроцессорКоллекции();
КонецФункции

Функция Количество() Экспорт
	Возврат Очередь.Количество();
КонецФункции

Функция ВМассив() Экспорт
	Возврат Очередь.ВМассив();
КонецФункции

Функция Подсмотреть() Экспорт

	Возврат Очередь.Подсмотреть()
		.Развернуть("(Отложенный) -> ?(Отложенный.Задержка() <= 0, Новый Опциональный(Отложенный), Опциональные.Пустой());");

КонецФункции

Функция Добавить(Элемент) Экспорт
	Возврат Положить(Элемент);
КонецФункции

Функция ДобавитьВсе(Коллекция) Экспорт

	Блокировка.Заблокировать();

	Попытка

		БылДобавленХотяБыОдинЭлемент = Ложь;

		Итератор = Коллекция.Итератор();

		Пока Итератор.ЕстьСледующий() Цикл

			БылДобавленХотяБыОдинЭлемент = Добавить(Итератор.Следующий())
				Или БылДобавленХотяБыОдинЭлемент;

		КонецЦикла;

		Блокировка.Разблокировать();

	Исключение

		Блокировка.Разблокировать();
		ВызватьИсключение;

	КонецПопытки;

	Возврат БылДобавленХотяБыОдинЭлемент;

КонецФункции

Процедура Очистить() Экспорт
	Очередь.Очистить();
КонецПроцедуры

Функция Удалить(Элемент) Экспорт
	Возврат Очередь.Удалить(Элемент);
КонецФункции

Функция УдалитьВсе(Коллекция) Экспорт
	Возврат Очередь.УдалитьВсе(Коллекция);
КонецФункции

Функция УдалитьЕсли(Предикат, Контекст = Неопределено) Экспорт
	Возврат Очередь.УдалитьЕсли(Предикат, Контекст);
КонецФункции

Функция СохранитьВсе(Коллекция) Экспорт
	Возврат Очередь.СохранитьВсе(Коллекция);
КонецФункции

Функция Положить(Элемент) Экспорт

	Если Элемент = Неопределено Тогда
		ВызватьИсключение "Очередь не может содержать Неопределено";
	КонецЕсли;

	_ = Новый РефлекторОбъекта(Элемент) // BSLLS:UnusedLocalVariable-off
		.РеализуетИнтерфейс(ИнтерфейсОтложенный, Истина);
	Возврат Очередь.Положить(Элемент);

КонецФункции

Функция Взять(Знач Таймаут = 0) Экспорт

	Конец = ТекущаяУниверсальнаяДатаВМиллисекундах() + Таймаут;
	Результат = Неопределено;

	Пока Истина Цикл

		Блокировка.Заблокировать();

		Попытка

			Элемент = Очередь.Подсмотреть();

			Если Элемент.Фильтровать("Элемент -> Элемент.Задержка() <= 0 ").СодержитЗначение() Тогда
				Результат = Очередь.Взять();
			КонецЕсли;

		Исключение

			Блокировка.Разблокировать();
			ВызватьИсключение;

		КонецПопытки;

		Блокировка.Разблокировать();

		Если ТекущаяУниверсальнаяДатаВМиллисекундах() >= Конец И Результат = Неопределено Тогда
			Результат = Опциональные.Пустой();
		КонецЕсли;

		Если Результат <> Неопределено Тогда
			Возврат Результат;
		КонецЕсли;

		Приостановить(100);

	КонецЦикла;

КонецФункции

Процедура ОбработкаПолученияПредставления(Представление, СтандартнаяОбработка) // BSLLS:UnusedLocalMethod-off
	КоллекцииСлужебный.ОбработчикПолученияПредставленияКоллекции(ЭтотОбъект, Представление, СтандартнаяОбработка);
КонецПроцедуры

Функция ПолучитьИтератор() // BSLLS:UnusedLocalMethod-off
	Возврат Новый СлужебныйИтераторДляДвижка(Итератор());
КонецФункции

&Обходимое
&Реализует("Очередь")
Процедура ПриСозданииОбъекта(Коллекция = Неопределено)

	ИнтерфейсОтложенный = Новый ИнтерфейсОбъекта()
		.Ф("Задержка");

	Очередь = Новый СинхронизированнаяОчередь(
		Новый ПриоритетнаяОчередь(
			"(Первый, Второй) -> { 
			|	Возврат СравнениеЗначений
			|		.ОбратныйПорядок()
			|		.Выполнить(
			|			Первый.Задержка(),
			|			Второй.Задержка()
			|		);
			|}"
		)
	);

	Блокировка = Новый БлокировкаРесурса(Очередь);

	Если Коллекция <> Неопределено Тогда
		ДобавитьВсе(Коллекция);
	КонецЕсли;

КонецПроцедуры
