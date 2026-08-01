# Структура проекта Lo-Files

### Текущий статус
Проект уже вышел за рамки чистого шаблона Flutter: кроме стандартных платформенных папок и базовой точки входа, в `lib/` уже существуют `core/`, `data/local/` и feature-структура с доменными моделями в `features/`.

На текущем этапе реализуются:
- локальная Drift-база данных;
- базовые доменные модели;
- документация и подготовка архитектурных правил;
- генерация кода через `build_runner` / `freezed`.

Архитектура проекта строится по feature-based подходу с `presentation/`, `domain/`, `data/` внутри модулей.  
Локальная storage-структура вынесена отдельно в `lib/data/local/tables/`, а `lib/core/database/database.dart` используется как сборочный файл схемы Drift.

***

## `lib/` — весь код приложения

```text
lib/
├── core/
│   ├── database/
│   │   ├── database.dart      # Сборка Drift-схемы, точка подключения к локальной БД
│   │   └── database.g.dart    # АВТОГЕНЕРИРУЕТСЯ, не редактировать руками
│   ├── di/                   # если/когда появятся провайдеры уровня приложения
│   ├── event_bus/            # если/когда появится шина событий
│   ├── entitlements/         # EntitlementChecker и заглушки
│   └── registries/           # Viewer/File Action/Screen registries
├── data/
│   └── local/
│       ├── tables/
│       │   ├── local_files_table.dart
│       │   ├── folders_table.dart
│       │   ├── recent_entries_table.dart
│       │   ├── favorites_table.dart
│       │   └── user_profile_cache_table.dart
│       └── repositories/     # если/когда появятся локальные репозитории
├── features/
│   ├── account/
│   │   └── domain/
│   │       └── models/
│   │           └── user.dart
│   ├── recent_favorites/
│   │   └── domain/
│   │       └── models/
│   │           ├── favorite_entry.dart
│   │           ├── recent_entry.dart
│   │           └── sync_status.dart
│   └── storage/
│       └── domain/
│           └── models/
│               ├── file.dart
│               ├── file_type.dart
│               └── folder.dart
└── main.dart                  # точка входа, пока шаблонный код
```

### Важные правила для `lib/`

- `features/` — это основная feature-структура приложения.
- `core/` — общие механизмы, не привязанные к одному модулю.
- `data/local/tables/` — место для всех локальных Drift-таблиц.
- `database.g.dart` никогда не редактируется вручную — только через генерацию.
- `database.dart` — только сборочный файл схемы Drift, сами таблицы живут в `data/local/tables/`.
- Domain-модели лежат в `features/<module>/domain/models/`.
- Generated-файлы `*.freezed.dart` и `*.g.dart` не считаются источником истины.

***

## Android / iOS / Linux / macOS / Windows

Нативные платформенные обёртки создаются автоматически Flutter.

```text
android/
ios/
linux/
macos/
windows/
```

### Что здесь меняется
- иконки приложения;
- splash screen;
- permissions;
- min SDK / target SDK;
- platform-specific настройки, если они нужны для работы файлового менеджера.

### Что здесь не делать
- не писать бизнес-логику;
- не хранить domain-модели;
- не добавлять туда код feature-модулей.

***

## `assets/icon/`

Кастомные картинки бренда Lo-Files.

```text
assets/icon/
```

### Содержимое
- иконка приложения;
- сплэш-изображения;
- финальные графические ассеты проекта.

### Правила
- Это финальные ассеты, не шаблон Flutter create.
- Если добавляется новый визуальный ассет, он должен быть подключён через `pubspec.yaml`.

***

## `test/`

Папка тестов проекта.

```text
test/
```

### Что уже может лежать здесь
- unit-тесты для domain-моделей;
- тесты на `copyWith` / `==` / создание объектов;
- тесты иерархии `Folder`;
- тесты гостевого пользователя `User`;
- тесты `File` и других моделей;
- тесты локальных репозиториев, если они уже созданы.

### Что не держать
- шаблонные тесты Flutter create, если они уже не отражают реальный код;
- тесты, завязанные на generated-файлы как на источник истины.

***

## `docs/`

Документация проекта для команды и AI.

```text
docs/
├── architecture.md
├── ai_context.md
├── key_components.md
├── dev_conventions.md
├── overview.md
├── setup.md
└── project_structure.md
```

### Назначение
- `overview.md` — цель, стек, MVP, аудитория;
- `architecture.md` — архитектура, слои, паттерны, модули;
- `project_structure.md` — структура директорий и глубина погружения;
- `key_components.md` — крупные логические файлы и их связи;
- `dev_conventions.md` — соглашения по коду и именованию;
- `setup.md` — окружение, версии и запуск;
- `ai_context.md` — навигация по документации и правила для ИИ.

***

## `pubspec.yaml` и `pubspec.lock`

### `pubspec.yaml`
Содержит:
- имя пакета;
- версию;
- зависимости (`drift`, `drift_flutter`, `freezed_annotation`, `audioplayers`, `video_player`, `permission_handler` и др.);
- путь к `assets/`.

### `pubspec.lock`
Содержит:
- зафиксированные версии зависимостей;
- автогенерируется;
- вручную не редактируется.

***

## `analysis_options.yaml`

Содержит правила линтера.

### Нужен для
- единообразия стиля;
- контроля качества кода;
- предотвращения случайных архитектурных нарушений.

***

## Flutter-служебные файлы

```text
.metadata
.flutter-plugins-dependencies
```

### Назначение
- служебная информация Flutter SDK;
- список подключённых плагинов;
- автогенерируемые данные.

### Правила
- не редактировать вручную;
- не считать частью доменной архитектуры.

***

## Что не трогать

```text
build/
.dart_tool/
.gradle/
.idea/
```

### Причина
Это временные, кэшируемые и автогенерируемые артефакты.

### Правила
- не редактировать;
- не коммитить;
- можно безопасно удалить и пересобрать через `flutter clean && flutter pub get`.

***

# Содержимое ключевых файлов

## `lib/main.dart`

Содержит:
- функцию `main()`;
- корневой виджет приложения.

Сейчас:
- либо шаблон Flutter create;
- либо точка входа, которая будет переписана под реальный UI.

Нужно сейчас:
- да, это точка входа, но она не является финальной архитектурной реализацией.

***

## `lib/core/database/database.dart`

Содержит:
- импорты всех локальных Drift-таблиц из `lib/data/local/tables/`;
- класс `AppDatabase`;
- подключение к SQLite через `drift_flutter`.

Текущая роль:
- единственная реальная точка доступа к локальному хранилищу на уровне Data Layer;
- сборочный файл схемы, а не место хранения объявлений таблиц.

### Что уже логически связано с ним
- `LocalFiles` — основная таблица файлов и папок;
- `Folders` — таблица папок;
- `Favorites` — таблица избранного;
- `RecentEntries` — таблица недавних файлов;
- `UserProfileCache` — singleton-кэш локального профиля гостя.

### Правила
- расширять только через build_runner;
- не обращаться к нему напрямую из UI;
- не смешивать schema-логику с domain-моделями;
- сами таблицы не хранить здесь, а держать в `lib/data/local/tables/`.

***

## `lib/features/storage/domain/models/file.dart`

Содержит:
- доменную immutable-модель `File`;
- поля: `id`, `name`, `path`, `type`, `size`, `createdAt`, `extraMetadata`.

Нужен сейчас:
- да, это центральная сущность Storage module и почти всего приложения.

***

## `lib/features/storage/domain/models/file_type.dart`

Содержит:
- enum `FileType`.

Нужен сейчас:
- да, это типизация поддерживаемых MVP-форматов.

***

## `lib/features/storage/domain/models/folder.dart`

Содержит:
- доменную immutable-модель `Folder`;
- поля: `id`, `name`, `parentId`, `createdAt`.

Нужен сейчас:
- да, это основа иерархии виртуального хранилища.

***

## `lib/features/account/domain/models/user.dart`

Содержит:
- доменную immutable-модель `User`;
- поля: `id`, `displayName`, `isGuest`.

Нужен сейчас:
- да, это основа гостевого режима и локального профиля.

***

## `lib/features/recent_favorites/domain/models/recent_entry.dart`

Содержит:
- доменную immutable-модель `RecentEntry`.

Нужен сейчас:
- да, это логика истории открытий файлов.

***

## `lib/features/recent_favorites/domain/models/favorite_entry.dart`

Содержит:
- доменную immutable-модель `FavoriteEntry`.

Нужен сейчас:
- да, это логика избранного.

***

## `lib/features/recent_favorites/domain/models/sync_status.dart`

Содержит:
- enum `SyncStatus`.

Нужен сейчас:
- да, как резерв под будущую синхронизацию.

***

## `lib/data/local/tables/local_files_table.dart`

Содержит:
- storage-таблицу `LocalFiles`;
- поля: `id`, `name`, `path`, `extension`, `sizeInBytes`, `createdAt`, `modifiedAt`, `isFolder`, `parentId`.

Нужен сейчас:
- да, это основная storage-таблица файлов и элементов виртуального хранилища.

***

## `lib/data/local/tables/folders_table.dart`

Содержит:
- storage-таблицу `Folders`;
- поля: `id`, `name`, `parentId`, `createdAt`.

Нужен сейчас:
- да, это storage-таблица папок с self-reference.

***

## `lib/data/local/tables/recent_entries_table.dart`

Содержит:
- storage-таблицу `RecentEntries`;
- поля: `id`, `fileId`, `openedAt`, `syncStatus` (nullable, зарезервировано).

Нужен сейчас:
- да, это storage-таблица недавних файлов.

***

## `lib/data/local/tables/favorites_table.dart`

Содержит:
- storage-таблицу `Favorites`;
- поля: `id`, `fileId`, `addedAt`, `syncStatus` (nullable, зарезервировано);
- уникальность `fileId` на уровне схемы.

Нужен сейчас:
- да, это storage-таблица избранного.

***

## `lib/data/local/tables/user_profile_cache_table.dart`

Содержит:
- storage-таблицу `UserProfileCache`;
- поля: `id`, `displayName`, `isGuest`, `entitlementsCache` (nullable, зарезервировано).

Нужен сейчас:
- да, это singleton-кэш профиля гостевого режима.

***

## `lib/features/*/domain/models/*.freezed.dart`

Содержит:
- автогенерируемый код `freezed`.

### Правила
- не редактировать руками;
- пересоздавать `build_runner`;
- не использовать как источник истины.

***

## `android/app/src/main/AndroidManifest.xml`

Содержит:
- permissions;
- точку входа Android-приложения.

Нужен сейчас:
- да, если нужно управление доступом к хранилищу.

***

## `android/app/build.gradle.kts`

Содержит:
- `minSdk`;
- `targetSdk`;
- `applicationId`;
- версию приложения.

Нужен сейчас:
- да, если меняются системные требования или зависимости.

***

## `ios/Runner/Info.plist`

Содержит:
- permissions iOS;
- описание использования системных ресурсов.

Нужен сейчас:
- да, если планируется iOS-версия.

***

# Подключённые пакеты (из pubspec.yaml)

- `drift` + `drift_flutter` — локальная база данных.
- `sqlite3_flutter_libs` — SQLite-биндинги.
- `freezed` + `freezed_annotation` — immutable-модели и генерация boilerplate.
- `audioplayers` — воспроизведение аудио.
- `video_player` — воспроизведение видео.
- `permission_handler` — доступ к файловой системе.

***

# Что не трогать

- `build/`, `.dart_tool/`, `.gradle/`, `.idea/` — временные, автогенерируемые.
- `database.g.dart` и `*.freezed.dart` — генерируемые файлы.
- Файлы внутри `android/*/build/` — временные артефакты сборки.

***

# Краткая карта текущего состояния

## Уже есть как ключевые domain-сущности
- `File`
- `FileType`
- `Folder`
- `User`
- `RecentEntry`
- `FavoriteEntry`
- `SyncStatus`

## Уже есть как ключевые storage-сущности
- `LocalFiles`
- `Folders`
- `RecentEntries`
- `Favorites`
- `UserProfileCache`

## Что это означает для структуры
- `features/` уже является основной рабочей структурой для домена.
- `core/` содержит общие механизмы.
- `data/local/tables/` содержит все текущие Drift-таблицы.
- `database.dart` — только сборочный файл.
- `main.dart` пока не финален и будет переписываться по мере появления реальных экранов.

***

Если хочешь, следующим сообщением я так же **приведу `overview.md` и `ai_context.md` к такому же актуальному виду**.