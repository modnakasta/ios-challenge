# liteKasta

## Что это и зачем?

Это приложение для iOS, в нём можно посмотреть акции, проходящие сейчас на [Касте](https://modnakasta.ua). Приложение сделано из фрагментов "[большого](https://itunes.apple.com/app/apple-store/id547622923?mt=8)" iOS приложения Касты. Кода там немного, зато весь взаправду – это тот код и те технологии, которые мы действительно используем.

Также это приглашение поработать вместе. Ниже записаны несколько идей улучшения приложения, присылайте нам merge request к репозиторию с реализацией _любого_ из них. 

## Задачи

### "Скоро в продаже"

В приложении пользователь видит, какие акции проходят на сайте [Касты](https://modnakasta.ua) в настоящее время. Мы хотели бы информировать его и о приближающихся акциях из будущего:

![wut?](/coming-soon-sketch.png "Скоро в продаже")

Мы думаем, что лучше всего будет разместить этот блок между баннерами третьей и четвертой акции.

[Вот подробный макет](https://www.figma.com/file/IM6WCtHuW5toS8NWjG97NcFQ/Coming-soon) (для просмотра расстояний, размеров, цветов и т.п., может понадобиться регистрация на Figma).

По тэпу на кнопку "Все предстоящие акции" следует открыть ссылку `https://modnakasta.ua/#soon`.

### Скрывать виртуальные акции

Сейчас, приложение показывает _все_ активные акции. В том числе, служебные "виртуальные" акции, которые пользователю видеть не следовало бы. Пример такой акции – акция "Black" в самом конце списка. У виртуальных акций есть специальная отметка в JSON-ответе сервера. Хотелось бы исправить приложение таким образом, чтобы она перестало показывать виртуальные акции пользователю. 

### Работа над ошибками

Когда случается ошибка связи или декодирования ответа сервера, приложение показывает пользователю кнопку "Повторить?" – без особых разъяснений и церемоний. Хотелось бы сделать этот сценарий более дружелюбным к пользователю. Нам кажется, что хорошим примером реализации отображения ошибок связи могло бы выступить приложение App Store для iOS.

## Вопросы, предложения?

[Пишите!](mailto:z.khymych@modnakasta.ua)

