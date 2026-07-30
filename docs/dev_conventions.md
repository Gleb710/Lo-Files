# Стандарты и правила разработки

> Файл: `docs/dev_conventions.md`  
> Назначение: справочник для ИИ-агента и разработчиков — как называть объекты проекта, какой стиль кода принят, как принимаются архитектурные решения, как работать с репозиторием.  
> Основа: `docs/architecture.md`, технический проект «ContentCore» (раздел 5 «Определение семантики и синтаксиса языка»), «Руководство программиста», PRD.

---

## 1. Правила именования

## 1.1 Файлы и папки (клиент, Dart/Flutter)

|Объект|Правило|Правильно|Неправильно|
|---|---|---|---|
|Папка модуля|snake_case, существительное в ед. числе|`storage/`, `viewer/`, `recent_favorites/`|`Storage/`, `viewerModule/`|
|Папка слоя внутри модуля|всегда `presentation/`, `domain/`, `data/`|`modules/search/domain/`|`modules/search/logic/`|
|Файл класса/виджета|snake_case, суффикс отражает роль|`image_viewer_screen.dart`, `search_repository.dart`|`ImageViewerScreen.dart`, `searchRepo.dart`|
|Файл интерфейса (контракт)|snake_case, без суффикса `_impl`|`entitlement_checker.dart`|`entitlement_checker_interface.dart`|
|Файл реализации интерфейса|snake_case, приставка = конкретная реализация|`stub_entitlement_checker.dart`|`entitlement_checker_2.dart`|
|Файл теста|имя тестируемого файла + `_test`|`search_repository_test.dart`|`test_search_repository.dart`|

### Дополнительное правило: размещение Riverpod providers

- Глобальные providers, используемые более чем в одном feature-модуле, размещаются в `lib/core/providers/`.
- Локальные providers, используемые только внутри одного feature-модуля, размещаются в `lib/features/<feature>/providers/`, где `<feature>` — имя папки модуля (например, `storage`, `account`, `search`, `viewer`).
- Если provider из feature-модуля начинает использоваться вторым модулем, он должен быть перенесён из `lib/features/<feature>/providers/` в `lib/core/providers/`.
- Прямой импорт provider'а из feature-модуля A в feature-модуль B запрещён; общий provider в таком случае выносится в `core/providers`.
- Папка `lib/core/di/` используется как composition root: для сборки, подключения и override провайдеров уровня приложения, но не как место хранения feature-scoped providers.

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
|Класс (Dart и TS)|PascalCase, существительное|`FileEntity`, `ViewerRegistry`|`fileEntity`|
|Интерфейс/контракт|PascalCase, без префикса `I`|`EntitlementChecker`|`IEntitlementChecker`|
|Enum|PascalCase для типа, единый стиль значений; по ТП значения типов объектов — lowerCamelCase|`enum ObjectType { file, folder, archive, image, video, audio, document, table, presentation }`|`enum object_type { File, FOLDER }`|
|DTO-класс|PascalCase + суффикс `Dto`|`CreateFolderDto`|`CreateFolderData`|
|Domain-модель|PascalCase, без технических суффиксов|`File`, `Folder`, `License`|`FileModel`|
|Storage-модель|PascalCase + суффикс `Row`/`Table` (для отличия от Domain)|`FileRow`, `FavoriteRow`|использование `File` для Drift-таблицы напрямую|
|View-модель|PascalCase + суффикс `ViewModel` (единый стиль)|`FileListItemViewModel`|`FileListItemVM2`|
|Use case (команда)|PascalCase, глагол + существительное|`OpenObject`, `MoveObject`, `ActivatePlugin`, `BuildExportPackage`|`ObjectOpener`, `DoMove`|
|Use case (запрос)|PascalCase, префикс `Get`/`List`/`Search`|`GetObjectById`, `SearchObjects`, `ListFolderItems`|`ObjectByIdFetcher`|

## 1.4 Методы, переменные, константы

|Объект|Правило|Правильно|Неправильно|
|---|---|---|---|
|Метод|camelCase, глагол/глагольная конструкция, async → `Future<T>`/`Promise<T>`|`isFeatureAvailable()`, `resolveViewer()`|`IsFeatureAvailable()`|
|Переменная|camelCase, существительное по содержимому|`fileExtension`, `currentUser`|`fe`, `temp`|
|Булева переменная/метод|префикс `is`/`has`/`can` (прямое требование ТП)|`isFavorite`, `hasOfflineCopy`, `canEdit`|`favorite`, `editable`|
|Константа|camelCase (Dart) / UPPER_SNAKE_CASE (TS-конфиг)|`maxFileSizeBytes` / `MAX_FILE_SIZE_BYTES`|`MAXFILESIZE`|
|Приватное поле класса|camelCase с ведущим `_` (Dart)|`_builders`|`builders_`|
|Тип `any`/`dynamic`|запрещён везде, кроме явно обоснованных случаев сериализации на границе API (по ТП)|обоснованный `Map<String, dynamic>` в DTO|бесконтрольный `dynamic` в Domain-слое|

## 1.5 API, события, база данных

|Объект|Правило|Правильно|Неправильно|
|---|---|---|---|
|REST-эндпоинт|версионированный путь, множественное число|`/api/v1/users`, `/api/v1/licenses/check/:featureId`|`/api/getUser`|
|Поле API-конверта|lowerCamelCase, единообразно в пределах эндпоинта (по ТП, раздел 5.2)|`requestId`, `errorCode`, `clientId`|смешение `request_id` и `errorCode`|
|Доменное событие|PascalCase, глагол в прошедшем времени, без префикса `Event`|`FileOpened`, `ObjectCreated`, `PluginInstalled`|`EventFileOpened`|
|Команда (запрос на изменение)|PascalCase, повелительная форма|`CreateObject`, `RenameObject`, `StartSync`|`ObjectCreationRequest`|
|Таблица БД|snake_case, множественное число|`recent_entries`, `favorites`, `files`|`RecentEntry`|
|Столбец БД|snake_case|`created_at`, `sync_status`|`createdAt`|
|Схема БД (namespace модуля)|snake_case = имя backend-модуля|`auth`, `users`, `billing`|`Auth_Schema`|

- Все доменные события клиента наследуются от базового `AppEvent`, размещённого в `lib/core/events/app_event.dart`.

## 1.6 Общие принципы

- Имя отражает **назначение**, а не реализацию (`ViewerRegistry`, а не `MapBasedRegistry`).
    
- Сокращения запрещены, кроме общепринятых: `Dto`, `Id`, `Url`, `Api`.
    
- Имя файла = имя главного класса, переведённое в нужный регистр.
    
- Суффиксы `_impl`, `_v2`, `_new`, `_old`, `_temp`, `_copy` запрещены в постоянном коде.
    

---

## 2. Принятый стиль кода

Раздел основан на разделе 5 технического проекта («Определение семантики и синтаксиса языка») и распространяется на весь проект.

## 2.1 Типизация

- Строгая типизация везде, где возможно; `dynamic`/`any` — только на границе сериализации JSON (DTO), нигде больше.
    
- Идентификаторы и текстовые атрибуты — `String`; числовые параметры — `int`/`double`; временные метки — `DateTime` (внутри кода) или ISO 8601 UTC строка (на границе API); признаки состояния — `bool`; перечисляемые состояния (тип объекта, статус синхронизации, статус лицензии) — только `enum`, никогда не «магические строки».
    

## 2.2 Асинхронность

- Все операции ввода-вывода (файлы, сеть, БД) — асинхронные: `Future<T>` в Dart, `Promise<T>`/`async` в TypeScript.
    
- Синхронные заглушки/моки допустимы только в тестах.
    

## 2.3 Обработка ошибок

- Внутренние методы возвращают `Result<T>` (см. `docs/architecture.md`, раздел 3.4) вместо выброса необработанных исключений на границах слоёв use case.
    
- Сетевые ошибки на клиенте преобразуются в понятные пользователю сообщения на уровне Presentation, а не показываются как raw stack trace (требование PRD и Руководства программиста).
    
- В логах backend'а обязательно фиксируется `requestId`, чтобы можно было проследить конкретный запрос от клиента до ошибки в логах (раздел про диагностику в Руководстве программиста).
    

## 2.4 Разделение форм данных

Domain-модель, Storage-модель, DTO и View-модель — четыре разных класса для одной сущности, преобразование только через мапперы (см. `docs/architecture.md`, раздел 3.7). Использовать один класс сразу для БД, сети и отображения запрещено.

## 2.5 Комментарии и документация кода

- Публичные интерфейсы (contracts) в `domain/` и `core/` обязательно сопровождаются кратким doc-комментарием, объясняющим назначение метода и когда он вызывается.
    
- Комментарии в духе «что делает код» (пересказ кода словами) избыточны — комментарий должен объяснять «зачем», а не «что».
    

## 2.6 Локализация и текстовые строки

- Никакие пользовательские строки не хардкодятся в коде экранов — только через `.arb`-файлы (`flutter_localizations` + `intl`), даже если в MVP используется один язык (русский).
    

## 2.7 Форматирование

- Dart: официальный `dart format` (стандартный форматтер), без кастомных правил ширины строки.
    
- TypeScript: Prettier + ESLint с конфигурацией NestJS по умолчанию.
    
- Единый форматтер обязателен для CI (даже в MVP, если CI настроен) — не допускается расхождение стиля между тремя разработчиками команды.