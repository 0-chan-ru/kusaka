<p align="center">
  <img src="https://dl.dropboxusercontent.com/u/43313258/instant_0chan.png" alt="Instant 0chan"/>
</p>
# Instant 0chan

Набор для быстрого развертывания нульчана на движке, использовавшемся на Nullch.org (форк Kusaba X).
## Функции
* Пользовательские доски (2.0чан) с максимальной свободой действий:
  * Полноценная модерация
  * Кастомные стили для досок
  * Раздельные спамлисты для каждой из досок
  * Автозамена
  * ~~Коровья пизда~~
  * Баннеры
* Мгновенное обновление тредов
* Исправлены баги Kusaba X
* Главная страница на HTML5 с возможностью кастомизации
* Полная совместимость с куклоскриптом
* Тач-интерфейс (с превью по клику)
* Подсветка кода
* LaTEX
* Эмбеды Youtube, Vimeo и Coub, не нагружающие страницу
* Баннеры
* Кириллическая протухающая капча с генератором произносимых слов
* Улучшенный парсинг
* Фильтры флуда и спама, детектирующие замену букв
* Дайсы, useragent, катриболы
* Множество мелких улучшений в клиентском и серверном коде
* Полный набор нульчановских досок в комплекте

### Выпилено
* Watched threads (через эту фичу можно было досить Kusaba X)
* Типы досок "Upload" и "Рисовач". Возможно, они появятся впоследствии.

## Требования

### Для базового функционала

* Apache
  * [mod_cloudflare](https://www.cloudflare.com/resources-downloads)  (для корректной работы с Cloudflare и кантриболлов). **Без MC баны из-под Cloudflare будут работать некорректно!** (как это было на zerochan.in). [Установка mod_cloudflare на CPanel.](http://tltech.com/info/installing-mod_cloudflare-on-cpanel/) 
* PHP
* MySQL


Особых требований к версиям нет, должно встать на среднестатичтический виртуальный хостинг. Читайте ошибки, если что-то не заработает. Теоретически возможна работа с базами SQLite и PostgreSQL, но это не тестировалось, и дампы базы данных для них еще нужно написать. Вместо Apache можно использовать Nginx (что тоже не тестировалось), но для него придется дописывать [обнаружение реальных IP](http://centminmod.com/nginx_configure_cloudflare.html).

### Для расширенного функционала

* PHP 5.3+ (для 2.0 и мгновенных обновлений)
* Аккаунт на [Areyouahuman](http://portal.areyouahuman.com/signup/basic) (капча для 2.0)
* Node.JS (для мгновенных обновлений)
* Либо соглашение с сервисом [ploosmeenoos](mailto:admin@ploosmeenoos.tk "Оставляйте свои зайвки здесь") (для мгновенных обновлений если нет Node.js)
* Cloudflare (для кантриболлов)

## Установка

### Конфигурация

Файл `config.php` в корневой папке содержит основную конфигурацию, которую нужно выполнить в первую очередь.
 
* **KU_DBTYPE** `(=mysqli)`: тип базы данных 
* **KU_DBHOST**, **KU_DBDATABASE**, **KU_DBUSERNAME**, **KU_DBPASSWORD**: данные для доступа к БД.
* **KU_NAME**: название сайта.
* **KU_SLOGAN**: слоган сайта.
* **KU_WEBFOLDER**: подпапка кусабы на вашем сайте, если она лежит не в корне. (Например, для http://example.com/board/b KU_WEBFOLDER = `"/board/"`).
* **KU_REACT_ENA** `(true | false)`: включает/выключает мгновенные обновления. Смотри "Настройка мгновенных обновлений" ниже.
* **KU_CSSVER**, **KU_CSSVER** `(любая строка)`: версии CSS и JS, отдаваемые клиенту. При внесении изменений в CSS или JS, рекомендуется инкрементировать версию и пересобрать все файлы.
* **KU_CAPTCHALIFE** `(число)`: время жизни капчи в секундах.
* **KU_20_BOARDSLIMIT** `(число)`: сколько досок может иметь пользователь 2.0-ча.
* **KU_20_CLOUDTIME** `(strtotime-совместимая строка со знаком минус)`: период времени, за который подсчитываются посты на 2.0 досках при сортировке.
* **KU_USERAGENT_ENABLED**: список досок, на которых работает `##useragent##`

### Процесс установки

* Убедитесь, что база данных, указанная в конфигурации, создана.
* Скопируйте файлы из папки `UTIL` (кроме `updates.js`) в корневую папку.
* Запустите `install.php`. После проверки доступности базы данных вам предложат импортировать данные в базу.
* После дампа базы данных введите логин и пароль администратора.
* Удалите файлы, скопированные из папки `UTIL`.
* Зарегистрируйте свой сайт на [Areyouahuman](http://portal.areyouahuman.com/signup/basic). 
* Вставьте `Publisher Key` и `Scoring Key` в `/inc/AYAH/ayah_config.php`.

#### Треки с главной страницы

Треки не включены в репозиторий; скачать их можно [отсюда](https://dl.dropboxusercontent.com/u/43313258/loops.zip). Скопируйте их в `/pages/loops/`. 

### Установка мгновенных обновлений

* Скопируйте `updates.js` в папку, в которой собираетесь запускать Node.js
* Находясь в этой папке, выполните "`npm install` [`express`](https://www.npmjs.org/package/express) [`socket.io`](https://www.npmjs.org/package/socket.io)"
* Наберите случайную строку в `srvtoken`. Присвойте это же значение `$cf['KU_REACT_SRVTOKEN']` в `config.php`.
* Задайте порт и IP (`node_port`, `node_ip`), на которых будет работать процесс `node`. Внесите эти значения в `config.php` в форме URL (`KU_LOCAL_REACT_API` и `KU_CLI_REACT_API`).
* Запустите процесс `node updates.js`
  * Для стабильной работы `node.js` в продакшене нужно воспользоваться одним из способов по демонизации и мониторингу этого процесса. Например, "[`nohup`](http://ru.wikipedia.org/wiki/Nohup) [`always`](https://github.com/edwardhotchkiss/always‎) `updates.js &`" (предварительно должен быть установлен `always` (`npm install always -g`)). Есть и другие способы.
* Активируйте фичу (в `config.php`: `KU_REACT_ENA = true`).
* Пересоберите все файлы и папки.
* Если запустить node нет возможности, я могу предоставить [мгновенные обновления как сервис](mailto:admin@ploosmeenoos.tk "Оставляйте свои зайвки здесь").

### Кастомизация

* Логотипы сайта и 2.0-ча располагаются в папке `/images/`.
* Для редактирования паттерна на главной странице выполните команду `editmode();` из консоли браузера на главной странице. Нарисуйте нужный паттерн и нажмите "Получить паттерн". Скопируйте паттерн и размеры паттерна в `/pages/patterns/main.php` (или другой файл).
* Данные для доната располагаются в `/pages/contents/donate.php`. По умолчанию там указаны [кошельки ЕФГ](http://web.archive.org/web/20121028010659/http://0chan.ru/?donate).
* Чтобы добавить собственные лупы на главную, их нужно скопировать в `/pages/loops/`, после чего внести в список `loops` в `/pages/index.js`. Файлы должны быть в формате OGG.

## Управление сайтом

### manage.php
* Derp

### Управление версиями и кэшем

* При изменении CSS или JS файлов рекомендуется инкрементировать `KU_CSSVER` и `KU_JSVER` в файле `config.php` после чего пересобирать все файлы.
* При изменении других файлов, если вы используете Cloudflare, необходимо [вручную удалить файл из кэша](http://blog.cloudflare.com/introducing-single-file-purge). Если вы не уверены, что пользователям отдается свежая версия ресурсов или если что-то пошло не так, очищайте кэш Cloudflare полностью.

##TODO

* Дописать README (лол)