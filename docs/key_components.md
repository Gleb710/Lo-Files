Документ описывает файлы с реальной логикой (не UI-разметку) 
и связи между ними. Обновляется при добавлении каждого нового 
крупного файла.

---

# 1. Известные пробелы (Known Gaps)

- Нет Repository-слоя — в будущем UI не должен обращаться к AppDatabase 
  напрямую, а только через промежуточный Repository.
- Foreign key связи не настроены явно: Favorites.fileId и 
  RecentEntries.fileId — обычные IntColumn, без references() 
  и без CASCADE при удалении файла.
- DAO-классов нет — методы запросов (getAllFiles, addFavorite и т.д.) 
  ещё не написаны, вся логика запросов будет добавляться позже.
- State management выбран: Riverpod. Архитектурное правило разделения global и feature-scoped providers уже принято, но большинство реальных providers и их связей пока ещё не реализованы.
- Навигация (роутер) не создана.
- main.dart — шаблонный код flutter create, не реальный UI приложения.

---
# 2. Куда добавлять новый функционал

- Новая таблица БД → lib/core/database/database.dart, 
  затем dart run build_runner build.
- Новый метод запроса к БД (когда появится DAO) → отдельный файл 
  вида lib/core/database/daos/[название]_dao.dart, НЕ прямо в database.dart.
- Новая бизнес-логика фичи → в соответствующий модуль `lib/features/<feature>/` с разделением на `presentation/`, `domain/`, `data/`, `providers/`.
- Новый глобальный Riverpod-provider → `lib/core/providers/[name]_provider.dart`.
- Новый локальный provider модуля → `lib/features/<feature>/providers/[name]_provider.dart`.
- Если provider начинает использоваться более чем одним модулем, он переносится из `features/<feature>/providers/` в `core/providers/`.
- НЕ писать SQL-запросы напрямую в UI-виджетах.

---
# 3. Диаграмма зависимостей

UI (main.dart, шаблонный) 
   │
   ▼
[ПРОБЕЛ: Repository-слой не создан]
   │
   ▼
AppDatabase (database.dart) ──uses──> drift_flutter (driftDatabase)
   │
   ├── LocalFiles (файлы и папки, self-reference через parentId)
   ├── Favorites (fileId → LocalFiles.id, БЕЗ явного foreign key)
   └── RecentEntries (fileId → LocalFiles.id, БЕЗ явного foreign key)

---
# 4. Список крупных файлов (файлы с функциями)

- lib/core/database/database.dart — схема БД, DAO (пока отсутствуют)
- lib/core/providers/database_provider.dart — глобальный provider для AppDatabase
- lib/core/providers/event_bus_provider.dart — глобальный provider для EventBus
- lib/core/providers/entitlement_checker_provider.dart — глобальный provider для EntitlementChecker
- lib/core/events/app_event.dart — базовый sealed class для всех событий приложения
- lib/core/event_bus/event_bus.dart — контракт шины событий
- lib/core/event_bus/riverpod_event_bus.dart — in-process реализация EventBus на клиенте

---
# 5. Список главных/основных файлов

- lib/main.dart — точка входа приложения; уже используется для подключения `ProviderScope` и дальнейшей сборки DI уровня приложения

---
# 6. Описание файлов

## lib/core/database/database.dart

**Роль в архитектуре**: Data Layer — единственная точка доступа 
к локальному хранилищу (SQLite через Drift).

**Что внутри**:
- `LocalFiles` — таблица файлов и папок. Поля: id, name, path, 
  extension (nullable), sizeInBytes, createdAt, modifiedAt, 
  isFolder (default false), parentId (nullable, для древовидной 
  структуры папок — папка ссылается сама на себя через parentId).
- `Favorites` — таблица избранного. Поля: id, fileId, addedAt.
- `RecentEntries` — таблица недавних файлов. Поля: id, fileId, openedAt.
- `AppDatabase` — главный класс БД, аннотация @DriftDatabase 
  регистрирует все три таблицы. schemaVersion = 1.
- Подключение через drift_flutter (driftDatabase(name: 'lo_files_db')) — 
  используется нативное хранение, кроссплатформенно.

**Зависит от**: пакеты drift, drift_flutter (pubspec.yaml).

**От него зависят**: пока ничего в коде — Repository-слой, 
который должен читать/писать через AppDatabase, ещё не написан.

**Правила изменения**:
- Новую таблицу или поле добавлять здесь, затем обязательно запускать 
  build_runner для пересборки database.g.dart.
- При изменении существующей таблицы — увеличивать schemaVersion 
  и добавлять миграцию (onUpgrade), иначе БД пользователей с более 
  старой версией приложения перестанет работать.
- Favorites.fileId и RecentEntries.fileId логически ссылаются на 
  LocalFiles.id, но это не закреплено через references() — 
  при добавлении новой логики учитывать, что "битые" ссылки возможны.

## lib/main.dart

**Роль в архитектуре**: Точка входа приложения (entry point).

**Что внутри**: На данный момент — шаблонный код flutter create 
(демо-счётчик), не относится к реальному функционалу Lo-Files.

**Зависит от**: —

**От него зависят**: весь UI приложения будет расти из этого файла 
после создания первого реального экрана.

**Правила изменения**: Будет полностью переписан при добавлении 
первого экрана и подключении роутера — не дорабатывать шаблонный 
код, полностью заменить.

---
### ШАБЛОН

**Роль в архитектуре**: Data Layer — единственная точка доступа к 
локальному хранилищу (Drift/SQLite).

**Что внутри**:
- Таблицы: (перечислить, когда появятся — например Files, Folders, Favorites)
- DAO-классы для CRUD-операций

**Зависит от**: sqlite3_flutter_libs, drift (pubspec.yaml)

**От него зависят**: любой Repository-слой, который будет читать/писать 
файлы через эту БД (пока Repository-слоя нет — ЭТО ПРОБЕЛ, см. "known gaps")

**Правила изменения**: 
- Новую таблицу добавлять сюда, затем запускать build_runner
- НЕ обращаться к этому файлу напрямую из UI-виджетов — 
  всегда через промежуточный слой (когда он появится)