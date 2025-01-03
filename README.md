# CollectionOS

КоллекшонОС это фреймворк коллекций для OneScript

## Особенности
Начиная с версии OneScript 2.0 появилась возможность обходить собственные классы коллекции циклом `Для каждого`, особенность описанная ниже актуальна для более ранних версий движка:

Так как в OneScript нет возможности сделать класс обходимым, то все представленные коллекции нельзя обойти циклом `Для каждого`, вместо этого вы можете воспользоваться итератором:

```bsl
СписокМассив = Новый СписокМассив;
СписокМассив.Добавить(1);
СписокМассив.Добавить(2);
СписокМассив.Добавить(3);

Итератор = СписокМассив.Итератор();

Пока Итератор.ЕстьСледующий() Цикл

    Элемент = Итератор.Следующий();

    Сообщить(Элемент);

КонецЦикла;

// > 1
// > 2
// > 3
```

## Диаграмма классов:

### Обходимое
---

```mermaid
classDiagram

Обходимое <|-- ЧитаемаяКоллекция
ЧитаемаяКоллекция <|-- Коллекция

ЧитаемаяКоллекция <|.. ФиксированнаяКоллекция
Коллекция <|.. СинхронизированнаяКоллекция

class Обходимое {
    <<Интерфейс>>
    +Итератор() ЧитающийИтератор
    +ДляКаждого(Алгоритм: Действие|Строка, Контекст:Структура|Сценарий) Ничто
}

class ЧитаемаяКоллекция {
    <<Интерфейс>>
    +Содержит(Элемент: Произвольный) Булево
    +СодержитВсе(Коллекция: ЧитаемыйКоллекция) Булево
    +Пусто() Булево
    +ПроцессорКоллекции() ПроцессорКоллекций
    +Количество() Число
}

class Коллекция {
    <<Интерфейс>>
    +Итератор() Итератор
    +Добавить(Элемент: Произвольный) Булево
    +ДобавитьВсе(Коллекция: ЧитаемыйКоллекция) Булево
    +Очистить() Ничто
    +Удалить(Элемент: Произвольный) Булево
    +УдалитьВсе(Коллекция: ЧитаемыйКоллекция) Булево
    +УдалитьЕсли(Предикат: Действие|Строка, Контекст:Структура|Сценарий) Булево
    +СохранитьВсе(Коллекция: ЧитаемыйКоллекция) Булево
    +ВМассив() Массив
}

class ФиксированнаяКоллекция {
    -ПриСозданииОбъекта(Коллекция: ЧитаемаяКоллекция)
}

class СинхронизированнаяКоллекция {
    -ПриСозданииОбъекта(Коллекция: Коллекция)
}
```

### Множество
---

```mermaid
classDiagram

ЧитаемаяКоллекция <|-- ЧитаемоеМножество
ЧитаемоеМножество <|-- Множество
Коллекция <|-- Множество

ЧитаемоеМножество <|.. ФиксированноеМножество
Множество <|.. МножествоСоответствие
Множество <|.. СинхронизированноеМножество

class ЧитаемоеМножество {
    <<Интерфейс>>
}

class Множество {
    <<Интерфейс>>
}

class ФиксированноеМножество {
    -ПриСозданииОбъекта(Коллекция: ЧитаемаяКоллекция)
}

class МножествоСоответствие {
    -ПриСозданииОбъекта(Коллекция: ЧитаемаяКоллекция)
}

class СинхронизированноеМножество {
    -ПриСозданииОбъекта(Коллекция: Множество)
}
```

### Список
---

```mermaid
classDiagram

ЧитаемаяКоллекция <|-- ЧитаемыйСписок
Коллекция <|-- Список
ЧитаемыйСписок <|-- Список
ЧитаемыйСписок <|.. ФиксированныйСписок

Список <|.. СписокМассив
Список <|.. СинхронизированныйСписок

class ЧитаемыйСписок {
    <<Интерфейс>>
    +Получить(Индекс: Число) Произвольный
    +Индекс(Элемент: Произвольный) Число
    +ПоследнийИндекс(Элемент: Произвольный) Число
    +ВГраница() Число
}

class Список {
    <<Интерфейс>>
    +Вставить(Индекс: Число, Элемент: Произвольный) Булево
    +ВставитьВсе(Индекс: Число, Коллекция: ЧитаемыйКоллекция) Булево
    +ЗаменитьВсе(Алгоритм: Действие|Строка, Контекст:Структура|Сценарий) Ничто
    +Сортировать(СравнениеЗначений: Действие|Строка, Контекст:Структура|Сценарий) Ничто
    +УдалитьПоИндексу(Индекс: Число) Произвольный
    +Установить(Индекс: Число, Значение: Произвольный) Произвольный
}

class ФиксированныйСписок {
    -ПриСозданииОбъекта(Коллекция: ЧитаемаяКоллекция)
}

class СписокМассив {
    -ПриСозданииОбъекта(Коллекция: ЧитаемаяКоллекция)
}

class СинхронизированныйСписок {
    -ПриСозданииОбъекта(Коллекция: Список)
}

```

### Очередь
---

```mermaid
classDiagram

ЧитаемаяКоллекция <|-- ЧитаемаяОчередь
ЧитаемаяОчередь <|-- Очередь
Коллекция <|-- Очередь

Очередь <|.. ОчередьМассив
Очередь <|.. ПриоритетнаяОчередь
Очередь <|.. ОчередьОтложенных
Очередь <|.. СинхронизированнаяОчередь

class ЧитаемаяОчередь {
    <<Интерфейс>>
    +Подсмотреть() Опциональный~Произвольный~
}

class Очередь {
    <<Интерфейс>>
    +Положить() Булево
    +Взять() Опциональный~Произвольный~
}

class ОчередьМассив {
    -ПриСозданииОбъекта(Коллекция: ЧитаемаяКоллекция)
}

class ПриоритетнаяОчередь {
    -ПриСозданииОбъекта(Коллекция: ЧитаемаяКоллекция)
}

class ОчередьОтложенных {
    -ПриСозданииОбъекта(Коллекция: ЧитаемаяКоллекция)
}

class СинхронизированнаяОчередь {
    -ПриСозданииОбъекта(Коллекция: Очередь)
}

```

### Карта
---

```mermaid
classDiagram

ЧитаемаяКарта <|-- Карта

ЧитаемаяКарта <|.. ФиксированнаяКарта
Карта <|.. КартаСоответствие

Карта <|.. СинхронизированнаяКарта

class ЧитаемаяКарта {
    <<Интерфейс>>
    +СодержитКлюч(Ключ: Произвольный) Булево
    +СодержитЗначение(Значение: Произвольный) Булево
    +ДляКаждого(Алгоритм: Действие|Строка, Контекст:Структура|Сценарий) Ничто
    +Получить(Ключ: Произвольный) Опциональный~Произвольный~
    +ПолучитьИлиУмолчание(Ключ: Произвольный, ЗначениеПоУмолчанию: Произвольный) Произвольный
    +Пусто() Булево
    +Ключи() ЧитаемоеМножество~Произвольный~
    +Значения() ЧитаемыйСписок~Произвольный~
    +КлючиИЗначения() ЧитаемоеМножество~Произвольный~
    +Количество() Число
}

class Карта {
    <<Интерфейс>>
    +Очистить() Ничто
    +Вставить(Ключ: Произвольный, Значение: Произвольный) Опциональный~Произвольный~
    +ВставитьВсе(Карта: ЧитаемыйКарта) Ничто
    +ВставитьЕслиОтсутствует(Ключ: Произвольный, Значение: Произвольный) Опциональный~Произвольный~
    +ВычислитьБезусловно(Ключ: Произвольный, ФункцияПереназначения: Действие|Строка, Контекст:Структура|Сценарий) Опциональный~Произвольный~
    +ВычислитьЕслиОтсутствует(Ключ: Произвольный, ФункцияНазначения: Действие|Строка, Контекст:Структура|Сценарий) Опциональный~Произвольный~
    +ВычислитьЕслиПрисутствует(Ключ: Произвольный, ФункцияПереназначения: Действие|Строка, Контекст:Структура|Сценарий) Опциональный~Произвольный~
    +Слить(Ключ: Произвольный, Значение: Произвольный, ФункцияПереназначения: Действие|Строка, Контекст:Структура|Сценарий) Опциональный~Произвольный~
    +Заменить(Ключ: Произвольный, Значение: Произвольный) Опциональный~Произвольный~
    +ЗаменитьЕслиЗначение(Ключ: Произвольный, ПрошлоеЗначение: Произвольный, Значение: Произвольный) Булево
    +ЗаменитьВсе(ФункцияПереназначения: Действие|Строка, Контекст:Структура|Сценарий) Булево
    +Удалить(Ключ: Произвольный) Опциональный~Произвольный~
}

class ФиксированнаяКарта {
    -ПриСозданииОбъекта(Карта: ЧитаемаяКарта)
}

class КартаСоответствие {
    -ПриСозданииОбъекта(Карта: ЧитаемаяКарта)
}

class СинхронизированнаяКарта {
    -ПриСозданииОбъекта(Карта: Карта)
}
```

### Итератор
---

```mermaid
classDiagram

ЧитающийИтератор <|-- Итератор

ЧитающийИтератор <|-- ЧитающийСписокИтератор
ЧитающийСписокИтератор <|-- СписокИтератор

ЧитающийСписокИтератор <|.. ФиксированныйСписокИтератор
СписокИтератор <|.. СписокИтераторМассив

Итератор <|.. ИтераторМассив

ЧитающийИтератор <|.. ФиксированныйИтератор
Итератор <|.. ИтераторСоответствие

Итератор <|.. ИтераторКлючСоответствие

Итератор <|.. ИтераторЗначениеСоответствие

class ЧитающийИтератор {
    <<Интерфейс>>
    +ЕстьСледующий() Булево
    +Следующий() Произвольный
    +ДляКаждогоОставшегося(Действие: Действие|Строка, Контекст:Структура|Сценарий) Ничто
}

class Итератор {
    <<Интерфейс>>
    +Удалить() Ничто
}

class ЧитающийСписокИтератор {
    <<Интерфейс>>
    +ЕстьПредыдущий() Булево
    +Предыдущий() Произвольный
    +СледующийИндекс() Число
    +ПредыдущийИндекс() Число
}

class СписокИтератор {
    <<Интерфейс>>
    +Установить(Элемент) Ничто
    +Вставить(Элемент) Ничто
}

class ФиксированныйСписокИтератор {
    -ПриСозданииОбъекта(Итератор: СписокИтератор) Ничто
}

class СписокИтераторМассив {
    -ПриСозданииОбъекта(Массив: Массив, Источник: Обходимое|Карта) Ничто
}

class ИтераторМассив {
    -ПриСозданииОбъекта(Массив: Массив, Источник: Обходимое|Карта) Ничто
}

class ФиксированныйИтератор {
    -ПриСозданииОбъекта(Итератор: Итератор) Ничто
}

class ИтераторСоответствие {
    -ПриСозданииОбъекта(Соответствие: Соответствие, Источник: Обходимое|Карта) Ничто
}

class ИтераторКлючСоответствие {
    -ПриСозданииОбъекта(Соответствие: Соответствие, Источник: Обходимое|Карта) Ничто
}

class ИтераторЗначениеСоответствие {
    -ПриСозданииОбъекта(Соответствие: Соответствие, Источник: Обходимое|Карта) Ничто
}
```
