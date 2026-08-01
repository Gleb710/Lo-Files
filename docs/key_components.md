# Ключевые компоненты проекта

Документ описывает файлы с реальной логикой и связи между ними. Обновляется при добавлении каждого нового крупного файла.

***

## 1. Известные пробелы (Known Gaps)

- Repository-слой для большинства модулей ещё не реализован — UI не должен обращаться к `AppDatabase` напрямую, а должен работать через промежуточный Repository.
- DAO-классов для `Favorites`, `RecentEntries`, `Folders`, `UserProfileCache` и других будущих таблиц ещё нет — вся логика запросов будет добавляться позже.
- Foreign key связи `Favorites.fileId` / `RecentEntries.fileId` с `LocalFiles.id` уже заданы на уровне схемы, включая каскадное поведение там, где оно предусмотрено.
- State management для UI-модулей ещё не финализирован — сейчас используется архитектурная заготовка на Riverpod.
- Навигация на уровне готового приложения ещё не полностью развернута — `go_router` используется как выбранный путь, но реальная экранная структура ещё будет расти.
- `main.dart` пока содержит шаблонный код Flutter create и не является реальным UI приложения.

***

## 2. Куда добавлять новый функционал

- Новая таблица БД → `lib/data/local/tables/`, затем `dart run build_runner build`.
- Новый метод запроса к БД (когда появится DAO) → отдельный файл вида `lib/data/local/daos/[name]_dao.dart`, не в `database.dart`.
- Новая доменная модель → `lib/features/<module>/domain/models/`.
- Новая бизнес-логика фичи → в соответствующий модуль `lib/features/<module>/domain/` или `data/` по роли.
- Новая бизнес-логика общего назначения → уточнить у команды перед созданием файла.
- Не писать SQL-запросы напрямую в UI-виджетах.
- `lib/core/database/database.dart` — только сборочный файл схемы Drift, сами таблицы живут в `lib/data/local/tables/`.

***

## 3. Диаграмма зависимостей

```text
UI / Presentation
   │
   ▼
Repository layer
   │
   ▼
AppDatabase (database.dart) ── uses ──> drift_flutter (driftDatabase)
   │
   ├── LocalFiles (файлы и папки виртуального хранилища)
   ├── Favorites (fileId → LocalFiles.id, с uniqueKeys на fileId)
   ├── RecentEntries (fileId → LocalFiles.id)
   ├── Folders (self-reference через parentId)
   └── UserProfileCache (singleton-кэш локального профиля / guest mode)
```

Пока Repository-слой не реализован, UI не должен ходить напрямую в `AppDatabase`.

***

## 4. Список крупных файлов

- `lib/core/database/database.dart` — сборка Drift-БД и точка подключения к локальному хранилищу.
- `lib/main.dart` — точка входа приложения, пока шаблонный Flutter create.
- `lib/features/storage/domain/models/file.dart` — доменная модель файла.
- `lib/features/storage/domain/models/file_type.dart` — enum поддерживаемых типов файла.
- `lib/features/storage/domain/models/folder.dart` — доменная модель папки виртуального хранилища.
- `lib/features/account/domain/models/user.dart` — доменная модель пользователя / гостевого режима.
- `lib/features/recent_favorites/domain/models/recent_entry.dart` — доменная модель recent-записи.
- `lib/features/recent_favorites/domain/models/favorite_entry.dart` — доменная модель избранного.
- `lib/features/recent_favorites/domain/models/sync_status.dart` — enum статуса синхронизации для будущего Sync.

***

## 5. Список главных файлов

- `lib/main.dart` — entry point приложения.
- `lib/core/database/database.dart` — сборочный файл локальной схемы и единственная точка подключения к Drift-хранилищу на текущем этапе.
- `lib/features/storage/domain/models/file.dart` — центральная сущность файлового пространства.
- `lib/features/storage/domain/models/folder.dart` — ключевая сущность иерархии виртуального хранилища.
- `lib/features/account/domain/models/user.dart` — локальная MVP-модель пользователя / гостя.
- `lib/features/recent_favorites/domain/models/recent_entry.dart` — модель недавних файлов.
- `lib/features/recent_favorites/domain/models/favorite_entry.dart` — модель избранного.
- `lib/data/local/tables/local_files_table.dart` — основная storage-таблица файлов и элементов виртуального хранилища.
- `lib/data/local/tables/folders_table.dart` — storage-таблица папок с self-reference.
- `lib/data/local/tables/recent_entries_table.dart` — storage-таблица недавних файлов.
- `lib/data/local/tables/favorites_table.dart` — storage-таблица избранного.
- `lib/data/local/tables/user_profile_cache_table.dart` — singleton-кэш профиля гостевого режима.

***

## 6. Описание файлов

### `lib/core/database/database.dart`

**Роль в архитектуре**: Data Layer — сборочный файл схемы Drift и единственная точка подключения к локальному хранилищу (SQLite через Drift).

**Что внутри**:
- `@DriftDatabase` регистрирует все локальные таблицы.
- `AppDatabase` — главный класс БД.
- Подключение через `drift_flutter` (`driftDatabase(name: 'lo_files_db')`) — нативное хранение, кроссплатформенно.
- `AppDatabase.forTesting(super.executor)` используется для тестов с in-memory executor.

**Зависит от**: пакеты `drift`, `drift_flutter`.

**От него зависят**: будущий Repository-слой и DAO-слой.

**Правила изменения**:
- Не добавлять сюда сами таблицы — только импорты и регистрацию в `@DriftDatabase(...)`.
- При изменении набора таблиц или их полей обновлять генерацию `database.g.dart` через `build_runner`.
- `Favorites.fileId` и `RecentEntries.fileId` должны ссылаться на `LocalFiles.id`.
- `Folders.parentId` — self-reference на `Folders.id`, `null` означает корень виртуального пространства.
- `UserProfileCache` используется как singleton-кэш локального профиля, одна активная запись на устройство.
- Не обращаться к `AppDatabase` напрямую из UI.

***

### `lib/main.dart`

**Роль в архитектуре**: точка входа приложения.

**Что внутри**: пока шаблонный код Flutter create, не относится к реальному функционалу Lo-Files.

**Зависит от**: —.

**От него зависят**: весь UI приложения после переписывания точки входа.

**Правила изменения**:
- Будет полностью переписан при добавлении первого реального экрана и подключении роутера.
- Не дорабатывать шаблонный код — заменить полностью.

***

### `lib/features/storage/domain/models/file.dart`

**Роль в архитектуре**: Domain Layer — центральная сущность файла.

**Что внутри**:
- `File` — immutable доменная модель файла.
- Поля: `id`, `name`, `path`, `type`, `size`, `createdAt`, `extraMetadata`.

**Зависит от**: `freezed_annotation`, `file_type.dart`.

**От него зависят**: поиск, viewer, recent/favorites, storage-логика.

**Правила изменения**:
- Не добавлять сюда Drift/DAO/HTTP-логику.
- `extraMetadata` — резерв под будущие плагины и расширения, не использовать как бизнес-условие MVP.
- Любое изменение поля должно рассматриваться как потенциально касающееся нескольких модулей.
- `File` — domain-модель; storage-эквивалентом является `LocalFiles`.

***

### `lib/features/storage/domain/models/file_type.dart`

**Роль в архитектуре**: Domain Layer — enum поддерживаемых типов файла MVP.

**Что внутри**:
- `FileType` со значениями: `txt`, `docx`, `mp3`, `mp4`, `jpeg`, `png`.

**Зависит от**: ничего.

**От него зависят**: `File`, viewer-логика, поиск, фильтрация.

**Правила изменения**:
- Новые типы добавлять только при реальном расширении MVP.
- Не смешивать с расширением файла как строкой — это именно логический тип, а не raw extension.

***

### `lib/features/storage/domain/models/folder.dart`

**Роль в архитектуре**: Domain Layer — модель папки виртуального хранилища.

**Что внутри**:
- `Folder` — immutable доменная модель папки.
- Поля: `id`, `name`, `parentId`, `createdAt`.

**Зависит от**: `freezed_annotation`.

**От него зависят**: навигация по дереву папок, Storage module, move/rename/delete логика.

**Правила изменения**:
- `parentId == null` означает корневую папку виртуального пространства Lo-Files, а не корень системной ФС.
- Не добавлять сюда файловую систему устройства или путь к OS-root.
- Изменение сигнатуры должно учитывать иерархию дерева.
- `Folder` — domain-модель; storage-эквивалентом является `Folders`.

***

### `lib/features/account/domain/models/user.dart`

**Роль в архитектуре**: Domain Layer — локальная модель пользователя / гостевого режима.

**Что внутри**:
- `User` — immutable доменная модель.
- Поля: `id`, `displayName`, `isGuest`.
- Вспомогательная фабрика `User.guest(...)` может использоваться для дефолтного сценария MVP.

**Зависит от**: `freezed_annotation`.

**От него зависят**: гостевой режим, redirect-логика `go_router`, локальный профиль пользователя.

**Правила изменения**:
- Не добавлять backend-поля (`email`, `hashedPassword`, `accessToken`, `refreshToken`) в MVP.
- `isGuest` — ключевой признак гостевого режима.
- Модель должна храниться локально в `UserProfileCache` или аналогичном локальном хранилище.
- `User` — domain-модель; storage-эквивалентом является `UserProfileCache`.

***

### `lib/features/recent_favorites/domain/models/recent_entry.dart`

**Роль в архитектуре**: Domain Layer — запись о недавно открытом файле.

**Что внутри**:
- `RecentEntry` — immutable доменная модель.
- Поля: `id`, `fileId`, `openedAt`, `syncStatus`.

**Зависит от**: `freezed_annotation`, `sync_status.dart`.

**От него зависят**: экран недавних файлов, история открытий, future sync.

**Правила изменения**:
- `syncStatus` — резерв под будущую синхронизацию, не использовать в MVP-бизнес-логике.
- Модель не должна ссылаться на Drift напрямую.
- `fileId` — связь с `File`/storage слоем, а не прямой доступ к БД.
- `RecentEntry` — domain-модель; storage-эквивалентом является `RecentEntries`.

***

### `lib/features/recent_favorites/domain/models/favorite_entry.dart`

**Роль в архитектуре**: Domain Layer — запись об избранном файле.

**Что внутри**:
- `FavoriteEntry` — immutable доменная модель.
- Поля: `id`, `fileId`, `addedAt`, `syncStatus`.

**Зависит от**: `freezed_annotation`, `sync_status.dart`.

**От него зависят**: экран избранного, toggle favorite, future sync.

**Правила изменения**:
- `syncStatus` — задел под будущий Sync-модуль, не использовать в MVP-решениях.
- Не смешивать с storage-моделью таблицы `Favorites`.
- Модель должна оставаться чистой domain-сущностью.
- `FavoriteEntry` — domain-модель; storage-эквивалентом является `Favorites`.

***

### `lib/features/recent_favorites/domain/models/sync_status.dart`

**Роль в архитектуре**: Domain Layer — enum статуса синхронизации будущего Sync.

**Что внутри**:
- `SyncStatus` со значениями `pending`, `synced`, `failed`.

**Зависит от**: ничего.

**От него зависят**: `RecentEntry`, `FavoriteEntry`, будущий Sync-модуль.

**Правила изменения**:
- Не использовать в MVP как бизнес-источник истины.
- Не расширять без появления реального Sync-сценария.

***

### `lib/data/local/tables/local_files_table.dart`

**Роль в архитектуре**: Data Layer — storage-таблица локальных файлов и элементов виртуального хранилища.

**Что внутри**:
- `LocalFiles` — таблица файлов и папок. Поля: `id`, `name`, `path`, `extension` (nullable), `sizeInBytes`, `createdAt`, `modifiedAt`, `isFolder` (default false), `parentId` (nullable, self-reference для древовидной структуры).

**Зависит от**: пакеты `drift`.

**От него зависят**: `Favorites`, `RecentEntries`, `Folders` и будущий Repository-слой.

**Правила изменения**:
- Новую таблицу или поле добавлять здесь только если это именно storage-структура файлового пространства.
- `parentId` — self-reference на `LocalFiles.id`, `null` означает корень виртуального пространства.
- Не использовать как domain-модель напрямую.
- Не обращаться к этой таблице напрямую из UI.

***

### `lib/data/local/tables/folders_table.dart`

**Роль в архитектуре**: Data Layer — storage-таблица папок виртуального хранилища.

**Что внутри**:
- `Folders` — таблица папок. Поля: `id`, `name`, `parentId`, `createdAt`.
- `parentId` — self-reference на `Folders.id`, `null` означает корень виртуального пространства.

**Зависит от**: пакеты `drift`.

**От него зависят**: Storage module, навигация по дереву, будущий FolderRepository.

**Правила изменения**:
- Не добавлять системные пути ОС в эту таблицу.
- Не смешивать с domain-моделью `Folder`.
- Каскадное удаление допустимо, если оно соответствует принятой логике удаления дерева.

***

### `lib/data/local/tables/recent_entries_table.dart`

**Роль в архитектуре**: Data Layer — storage-таблица недавних файлов.

**Что внутри**:
- `RecentEntries` — таблица недавних файлов. Поля: `id`, `fileId`, `openedAt`, `syncStatus` (nullable, зарезервировано).
- `fileId` — foreign key на `LocalFiles.id`.

**Зависит от**: пакеты `drift`.

**От него зависят**: Recent module и будущий RecentRepository.

**Правила изменения**:
- `syncStatus` хранить как резерв под будущий Sync.
- Не использовать это поле в MVP-логике.
- Не смешивать с domain-моделью `RecentEntry`.

***

### `lib/data/local/tables/favorites_table.dart`

**Роль в архитектуре**: Data Layer — storage-таблица избранного.

**Что внутри**:
- `Favorites` — таблица избранного. Поля: `id`, `fileId`, `addedAt`, `syncStatus` (nullable, зарезервировано).
- `fileId` — foreign key на `LocalFiles.id`.
- `fileId` уникален на уровне схемы.

**Зависит от**: пакеты `drift`.

**От него зависят**: Favorites module и будущий FavoritesRepository.

**Правила изменения**:
- Не допускать дублирования одного файла в избранном.
- `syncStatus` хранить только как резерв.
- Не смешивать с domain-моделью `FavoriteEntry`.

***

### `lib/data/local/tables/user_profile_cache_table.dart`

**Роль в архитектуре**: Data Layer — singleton-кэш локального профиля / гостевого режима.

**Что внутри**:
- `UserProfileCache` — таблица локального профиля. Поля: `id`, `displayName`, `isGuest`, `entitlementsCache` (nullable, зарезервировано).
- Используется как единственная активная запись на устройство в MVP.

**Зависит от**: пакеты `drift`.

**От него зависят**: guest mode, redirect-логика `go_router`, будущий AccountRepository.

**Правила изменения**:
- Хранить только локальное состояние профиля, без backend-полей.
- `isGuest` — основной MVP-флаг гостевого режима.
- `entitlementsCache` не использовать как источник истины в MVP.

***

## 7. Связи между ключевыми сущностями

- `File` — центральная сущность, используемая почти всеми модулями; storage-эквивалент: `LocalFiles`.
- `Folder` определяет иерархию виртуального хранилища через `parentId`; storage-эквивалент: `Folders`.
- `User` определяет гостевой режим и локальный профиль; storage-эквивалент: `UserProfileCache`.
- `RecentEntry` и `FavoriteEntry` работают поверх `File`; storage-эквиваленты: `RecentEntries` и `Favorites`.
- `SyncStatus` существует как резерв для будущей синхронизации, но не управляет MVP-логикой.
- `Files` как отдельная таблица удалена и не используется.

***

## 8. Правила добавления новых крупных файлов

- Если файл является частью ядра логики, его нужно добавить в этот документ.
- Если файл меняет зависимости между модулями, обновить раздел "Связи между ключевыми сущностями".
- Если файл относится к доменной модели, его роль должна быть описана отдельно.
- Если файл автогенерируемый (`*.freezed.dart`, `*.g.dart`), не включать его как источник истины.
- Если добавляется новая storage-таблица, она должна появиться в `lib/data/local/tables/` и быть отражена в `database.dart` только как импорт и регистрация.