# Стандарты и правила разработки

> Файл: `docs/dev_conventions.md`  
> Назначение: справочник для ИИ-агента и разработчиков — как называть объекты проекта, какой стиль кода принят, как принимаются архитектурные решения, как работать с репозиторием.  
> Основа: `docs/architecture.md`, технический проект «ContentCore» (раздел 5 «Определение семантики и синтаксиса языка»), «Руководство программиста», PRD.

---

## 1. Правила именования

## 1.1 Файлы и папки (клиент, Dart/Flutter)

|Объект|Правило|Правильно|Неправильно|
|---|---|---|---|
|Папка модуля|snake_case, существительное в ед. числе|`storage/`, `viewer/`, `recent_favorites/`, `account/`|`Storage/`, `viewerModule/`|
|Папка слоя внутри модуля|всегда `presentation/`, `domain/`, `data/`|`modules/search/domain/`|`modules/search/logic/`|
|Папка доменных моделей|`models/` внутри `domain/`|`features/storage/domain/models/`|`features/storage/domain/entities/` без необходимости|
|Файл класса/виджета|snake_case, суффикс отражает роль|`image_viewer_screen.dart`, `search_repository.dart`|`ImageViewerScreen.dart`, `searchRepo.dart`|
|Файл доменной модели|snake_case, имя соответствует имени класса|`file.dart`, `folder.dart`, `user.dart`|`file_model.dart`, если класс назван `File`|
|Файл интерфейса (контракт)|snake_case, без суффикса `_impl`|`entitlement_checker.dart`|`entitlement_checker_interface.dart`|
|Файл реализации интерфейса|snake_case, приставка = конкретная реализация|`stub_entitlement_checker.dart`|`entitlement_checker_2.dart`|
|Файл теста|имя тестируемого файла + `_test`|`search_repository_test.dart`|`test_search_repository.dart`|

## 1.2 Файлы и папки (backend, TypeScript/NestJS)

|Объект|Правило|Правильно|Неправильно|
|---|---|---|---|
|Папка модуля|kebab/snake_case, множественное число|`modules/users/`, `modules/licenses/`|`modules/User/`|
|Файл контроллера|kebab-case + `.controller.ts`|`auth.controller.ts`|`AuthController.ts`|
|Файл сервиса|kebab-case + `.service.ts`|`licenses.service.ts`|`licenseSvc.ts`|
|Файл модуля NestJS|kebab-case + `.module.ts`|`client-config.module.ts`|`ClientConfigModule.ts`|
|Файл миграции БД|timestamp + описание|`1732600000000-create-auth-schema.ts`|`migration1.ts`|
|Схема БД (SQL)|snake_case + `.schema.sql`|`billing.schema.sql`|`BillingSchema.sql`|

## 1.3 Классы, интерфейсы, типы

|Объект|Правило|Правильно|Неправильно|
|---|---|---|---|
|Класс (Dart и TS)|PascalCase, существительное|`File`, `Folder`, `User`, `ViewerRegistry`|`fileEntity`|
|Интерфейс/контракт|PascalCase, без префикса `I`|`EntitlementChecker`|`IEntitlementChecker`|
|Enum|PascalCase для типа, значения lowerCamelCase|`enum ObjectType { file, folder, archive, image, video, audio, document, table, presentation }`|`enum object_type { File, FOLDER }`|
|Enum доменного типа файла|PascalCase, фиксированные значения по MVP|`enum FileType { txt, docx, mp3, mp4, jpeg, png }`|`TXT`, `Mp3`, `fileTypeTxt`|
|Enum статуса синхронизации|PascalCase, значения lowerCamelCase|`enum SyncStatus { pending, synced, failed }`|`PendingSync`, `SYNCED`|
|DTO-класс|PascalCase + суффикс `Dto`|`CreateFolderDto`|`CreateFolderData`|
|Domain-модель|PascalCase, без технических суффиксов|`File`, `Folder`, `User`, `RecentEntry`, `FavoriteEntry`|`FileModel`|
|Storage-модель|PascalCase + суффикс `Row`/`Table`|`FileRow`, `FavoriteRow`|использование `File` для Drift-таблицы напрямую|
|View-модель|PascalCase + суффикс `ViewModel`|`FileListItemViewModel`|`FileListItemVM2`|
|Use case (команда)|PascalCase, глагол + существительное|`OpenObject`, `MoveObject`, `ActivatePlugin`, `BuildExportPackage`|`ObjectOpener`, `DoMove`|
|Use case (запрос)|PascalCase, префикс `Get`/`List`/`Search`|`GetObjectById`, `SearchObjects`, `ListFolderItems`|`ObjectByIdFetcher`|

## 1.4 Методы, переменные, константы

|Объект|Правило|Правильно|Неправильно|
|---|---|---|---|
|Метод|camelCase, глагол/глагольная конструкция, async → `Future<T>`/`Promise<T>`|`isFeatureAvailable()`, `resolveViewer()`|`IsFeatureAvailable()`|
|Переменная|camelCase, существительное по содержимому|`fileExtension`, `currentUser`|`fe`, `temp`|
|Булева переменная/метод|префикс `is`/`has`/`can`|`isFavorite`, `hasOfflineCopy`, `canEdit`|`favorite`, `editable`|
|Константа|camelCase (Dart) / UPPER_SNAKE_CASE (TS-конфиг)|`maxFileSizeBytes` / `MAX_FILE_SIZE_BYTES`|`MAXFILESIZE`|
|Приватное поле класса|camelCase с ведущим `_` (Dart)|`_builders`|`builders_`|
|Тип `any`/`dynamic`|запрещён везде, кроме явно обоснованных случаев сериализации на границе API|обоснованный `Map<String, dynamic>` в DTO|бесконтрольный `dynamic` в Domain-слое|

## 1.5 API, события, база данных

|Объект|Правило|Правильно|Неправильно|
|---|---|---|---|
|REST-эндпоинт|версионированный путь, множественное число|`/api/v1/users`, `/api/v1/licenses/check/:featureId`|`/api/getUser`|
|Поле API-конверта|lowerCamelCase, единообразно в пределах эндпоинта|`requestId`, `errorCode`, `clientId`|смешение `request_id` и `errorCode`|
|Доменное событие|PascalCase, глагол в прошедшем времени, без префикса `Event`|`FileOpened`, `ObjectCreated`, `PluginInstalled`|`EventFileOpened`|
|Команда (запрос на изменение)|PascalCase, повелительная форма|`CreateObject`, `RenameObject`, `StartSync`|`ObjectCreationRequest`|
|Таблица БД|snake_case, множественное число|`recent_entries`, `favorites`, `files`, `folders`|`RecentEntry`|
|Столбец БД|snake_case|`created_at`, `sync_status`|`createdAt`|
|Схема БД (namespace модуля)|snake_case = имя backend-модуля|`auth`, `users`, `billing`|`Auth_Schema`|

## 1.6 Общие принципы

- Имя отражает **назначение**, а не реализацию (`ViewerRegistry`, а не `MapBasedRegistry`).
- Сокращения запрещены, кроме общепринятых: `Dto`, `Id`, `Url`, `Api`.
- Имя файла = имя главного класса, переведённое в нужный регистр.
- Суффиксы `_impl`, `_v2`, `_new`, `_old`, `_temp`, `_copy` запрещены в постоянном коде.
- Domain-модели не должны называться `*Model`, если это не view-model и не DTO.
- Для MVP-guest режима используется `User`, а не `GuestUser`, если это одна и та же сущность с полем `isGuest`.

---

## 2. Принятый стиль кода

Раздел основан на разделе 5 технического проекта («Определение семантики и синтаксиса языка») и распространяется на весь проект.

## 2.1 Типизация

- Строгая типизация везде, где возможно; `dynamic`/`any` — только на границе сериализации JSON (DTO), нигде больше.
- Идентификаторы и текстовые атрибуты — `String`; числовые параметры — `int`/`double`; временные метки — `DateTime` (внутри кода) или ISO 8601 UTC строка (на границе API); признаки состояния — `bool`; перечисляемые состояния — только `enum`.
- `FileType` должен быть enum с фиксированным набором значений MVP, а не строкой.
- `SyncStatus` должен быть enum-заготовкой под будущую синхронизацию, но не участвовать в MVP-логике.
- `Folder.parentId == null` означает корень виртуального хранилища Lo-Files, а не системную файловую систему.
- `User.isGuest` — это MVP-маркер гостевого режима, а не полноценная авторизация.
- `File.extraMetadata` допускает `Map<String, dynamic>?`, но только как контейнер расширяемых метаданных без бизнес-логики в MVP.

## 2.2 Асинхронность

- Все операции ввода-вывода (файлы, сеть, БД) — асинхронные: `Future<T>` в Dart, `Promise<T>`/`async` в TypeScript.
- Синхронные заглушки/моки допустимы только в тестах.

## 2.3 Обработка ошибок

- Внутренние методы возвращают `Result<T>` (см. `docs/architecture.md`, раздел 3.4) вместо выброса необработанных исключений на границах слоёв use case.
- Сетевые ошибки на клиенте преобразуются в понятные пользователю сообщения на уровне Presentation, а не показываются как raw stack trace.
- В логах backend'а обязательно фиксируется `requestId`, чтобы можно было проследить конкретный запрос от клиента до ошибки в логах.

## 2.4 Разделение форм данных

Domain-модель, Storage-модель, DTO и View-модель — четыре разных класса для одной сущности, преобразование только через мапперы. Использовать один класс сразу для БД, сети и отображения запрещено.

Для текущего проекта это означает:
- `File` — доменная модель.
- `Folder` — доменная модель.
- `User` — доменная модель гостевого режима/профиля.
- `RecentEntry` и `FavoriteEntry` — доменные модели списков recent/favorites.
- `LocalFiles`, `Folders`, `RecentEntries`, `Favorites`, `UserProfileCache` — storage-модели в Drift-слое.

## 2.5 Freezed и генерация кода

- Для single-class моделей в `freezed` 3.x использовать форму `@freezed abstract class ... with _$...`.
- После изменения freezed-моделей обязательно запускать `dart run build_runner build --delete-conflicting-outputs`.
- Сгенерированные файлы `*.freezed.dart` и `*.g.dart` не редактируются вручную.
- Если генерация падает из-за конфликтов версий, сначала проверять `pubspec.yaml` и совместимость `freezed`, `freezed_annotation`, `build_runner`, `drift`, `drift_dev`.

## 2.6 Комментарии и документация кода

- Публичные интерфейсы (contracts) в `domain/` и `core/` обязательно сопровождаются кратким doc-комментарием, объясняющим назначение метода и когда он вызывается.
- Для доменных моделей требуется doc-комментарий, если поле отражает будущую функциональность или может быть неправильно понято командой.
- Комментарии в духе «что делает код» (пересказ кода словами) избыточны — комментарий должен объяснять «зачем», а не «что».
- Для `extraMetadata`, `syncStatus`, `isGuest` и `parentId` желательно явно пояснять смысл в контексте MVP.

## 2.7 Локализация и текстовые строки

- Никакие пользовательские строки не хардкодятся в коде экранов — только через `.arb`-файлы (`flutter_localizations` + `intl`), даже если в MVP используется один язык (русский).
- В доменных моделях допускаются только внутренние значения и дефолты, не являющиеся UI-текстом.

## 2.8 Форматирование

- Dart: официальный `dart format` (стандартный форматтер), без кастомных правил ширины строки.
- TypeScript: Prettier + ESLint с конфигурацией NestJS по умолчанию.
- Единый форматтер обязателен для CI (даже в MVP, если CI настроен) — не допускается расхождение стиля между тремя разработчиками команды.

---

## 3. Работа с репозиторием

- Любая новая доменная модель сначала должна быть согласована с `architecture.md` и `project_structure.md`.
- Новые файлы доменных моделей добавляются в `features/<module>/domain/models/`.
- Storage-таблицы Drift добавляются в `lib/data/local/tables/`, а `lib/core/database/database.dart` только регистрирует их.
- При добавлении freezed-модели сразу планируется генерация кода и unit-тест.
- `build_runner` должен запускаться после любых изменений в `freezed`-моделях.
- Не смешивать изменения domain-моделей с миграциями Drift в одном шаге без необходимости.
- Generated-файлы не редактировать вручную и не использовать их как источник истины.

---

## 4. Памятка по текущим сущностям MVP

### 4.1 Storage module
- `File` — центральная сущность файла.
- `FileType` — набор поддерживаемых типов файла MVP.
- `Folder` — узел дерева виртуального хранилища.
- `parentId == null` — корень виртуального хранилища.
- `LocalFiles` — storage-таблица файлов.
- `Folders` — storage-таблица папок.

### 4.2 Recent & Favorites module
- `RecentEntry` и `FavoriteEntry` — записи списков последних и избранного.
- `SyncStatus` — зарезервированное поле под будущую синхронизацию, не использовать в MVP-бизнес-логике.
- `RecentEntries` и `Favorites` — storage-таблицы списка recent/favorites.

### 4.3 Account module
- `User` — локальная MVP-модель профиля/гостя.
- `isGuest` — основной признак гостевого режима.
- `UserProfileCache` — storage-кэш профиля и единственной активной записи аккаунта в MVP.
- Backend-поля (email, password, tokens и т.п.) в MVP не добавляются.

---

## 5. Архитектурные решения

- Если существует риск смешать storage и domain, приоритет у domain-модели.
- Если поле нужно “на будущее”, но оно влияет на сигнатуру модели, лучше заложить его сразу и явно задокументировать.
- Для перечисляемых статусов и типов использовать enum, а не строки.
- Guest mode оформлять через `User.isGuest`, а не через отдельный временный флаг в UI.
- Виртуальное хранилище всегда отделено от системной файловой системы.