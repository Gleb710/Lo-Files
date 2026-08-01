# Структура проекта Lo-Files

### Текущий статус
Архитектура клиента утверждена как feature-first с явным разделением на `core/` и `features/`. Для feature-модулей принят единый каркас `presentation/`, `domain/`, `data/`, `providers/`; для общих зависимостей используется `core/providers/`, а `core/di/` выполняет роль composition root.

### lib/ — весь код приложения

lib/
├── core/
│   ├── database/
│   │   ├── database.dart
│   │   ├── database.g.dart
│   │   └── daos/
│   ├── di/
│   │   └── app_providers_scope.dart
│   ├── providers/
│   │   ├── database_provider.dart
│   │   ├── entitlement_checker_provider.dart
│   │   └── event_bus_provider.dart
│   ├── events/
│   │   ├── app_event.dart
│   │   └── ...
│   ├── event_bus/
│   │   ├── event_bus.dart
│   │   └── riverpod_event_bus.dart
│   ├── entitlements/
│   │   ├── entitlement_checker.dart
│   │   └── stub_entitlement_checker.dart
│   ├── registries/
│   ├── network/
│   └── result/
├── features/
│   ├── account/
│   │   ├── presentation/
│   │   ├── domain/
│   │   ├── data/
│   │   └── providers/
│   ├── storage/
│   ├── file_list/
│   ├── search/
│   ├── viewer/
│   ├── recent_favorites/
│   ├── settings/
│   └── stub_features/
└── main.dart

ВАЖНО для будущих задач:
- Структура `features/` уже утверждена и не должна создаваться произвольно вне принятого каркаса.
- Глобальные Riverpod-провайдеры размещаются в `lib/core/providers/`.
- Локальные провайдеры размещаются в `lib/features/<feature>/providers/`.
- Если provider начинает использоваться более чем одним модулем, он переносится в `lib/core/providers/`.
- `core/di/` используется для сборки и подключения провайдеров уровня приложения, а не для хранения feature-scoped providers.
- `database.g.dart` никогда не редактируется вручную — перегенерируется командой: `dart run build_runner build`

### android/, ios/, linux/, macos/, windows/
Нативные платформенные обёртки, создаются автоматически Flutter.
Редактируются только для: иконок приложения, splash screen, 
разрешений (permissions), настроек min SDK. 
Код бизнес-логики здесь НЕ пишется.

### assets/icon/
Кастомные картинки бренда Lo-Files (иконка, сплэш). 
Единственный визуальный актив, уже не шаблонный.

### test/
Пока только widget_test.dart — шаблонный тест для demo-приложения.
Реальных тестов на функциональность нет.

### docs/
Документация проекта для команды и AI-ассистентов 
(architecture.md, ai_context.md, key_components.md, dev_conventions.md, 
overview.md, setup.md, этот файл).

### web/
Заготовка для веб-версии, создана автоматически. 
Веб не входит в MVP — не расширять без явного запроса.

### Подключённые пакеты (из pubspec.yaml)
- drift + sqlite3_flutter_libs — локальная база данных
- audioplayers — воспроизведение аудио
- video_player — воспроизведение видео
- permission_handler — доступ к файловой системе
- flutter_riverpod — DI и state management через Riverpod

### Что НЕ трогать
- Папки build/, .dart_tool/, .gradle/, .idea/ — временные, автогенерируемые
- database.g.dart — автогенерируемый
- Файлы внутри android/*/build/ — временные артефакты сборки

---
# Содержимое ключевых файлов

### lib/main.dart
Содержит: функцию main() и корневой виджет приложения (MyApp).
Сейчас: скорее всего ШАБЛОННЫЙ код flutter create (demo-кнопка счётчика).
Нужен сейчас: ДА, это точка входа, но требует полной переписки 
под реальный UI Lo-Files, когда утвердим первый экран.

### lib/core/database/database.dart
Содержит: описание таблиц Drift (@DriftDatabase), классы таблиц 
(например Files, Folders), DAO-методы для запросов к SQLite.
Нужен сейчас: ДА, это единственная реальная бизнес-логика в проекте.
Редактируется вручную при добавлении новых таблиц/полей.

### lib/core/database/database.g.dart
Содержит: автогенерированный код Drift (реализация методов доступа к БД).
Нужен сейчас: ДА, но НИКОГДА не редактируется руками — 
пересоздаётся командой dart run build_runner build при изменении database.dart.

### pubspec.yaml
Содержит: имя пакета, версию, список зависимостей (drift, sqlite3_flutter_libs, 
audioplayers, video_player, permission_handler) и путь к assets/icon/.
Нужен сейчас: ДА, редактируется при добавлении каждого нового пакета.

### pubspec.lock
Содержит: точные зафиксированные версии всех зависимостей и подзависимостей.
Нужен сейчас: НЕТ для ручного редактирования — генерируется автоматически 
командой flutter pub get, руками никогда не трогается.

### analysis_options.yaml
Содержит: правила линтера (какие ошибки/warning показывает IDE).
Нужен сейчас: ДА, но обычно настраивается один раз в начале проекта.

### test/widget_test.dart
Содержит: шаблонный тест, проверяющий demo-счётчик из шаблона Flutter.
Нужен сейчас: НЕТ — тестирует код, который будет удалён. 
Безопасно удалить или переписать при первом реальном экране.

### android/app/src/main/AndroidManifest.xml
Содержит: разрешения приложения (permissions), имя пакета, точку входа.
Нужен сейчас: ДА — здесь добавляются permissions для доступа к файлам 
(например READ_EXTERNAL_STORAGE), критично для функции файлового менеджера.

### android/app/build.gradle.kts
Содержит: minSdkVersion, targetSdkVersion, applicationId, версия приложения.
Нужен сейчас: ДА при первой настройке, дальше редактируется редко 
(например при поднятии minSdk под новый пакет).

### ios/Runner/Info.plist
Содержит: разрешения для iOS (например NSPhotoLibraryUsageDescription), 
имя приложения, версия.
Нужен сейчас: ДА, если планируется iOS-версия — аналог AndroidManifest.xml.

### assets/icon/*.png
Содержит: растровые изображения логотипа и сплэш-экрана Lo-Files.
Нужен сейчас: ДА, уже используются, финальные (не шаблонные).

### docs/*.md (ai_context.md, architecture.md и т.д.)
Содержит: документацию проекта для команды и AI.
Нужен сейчас: ДА, в процессе заполнения (текущая задача).

### .metadata, .flutter-plugins-dependencies
Содержит: служебная информация Flutter SDK о версии и плагинах.
Нужен сейчас: НЕТ для ручного редактирования, автогенерируется.

### build/, .dart_tool/, .gradle/, .idea/
Содержит: скомпилированные артефакты, кэш IDE, временные файлы сборки.
Нужен сейчас: НЕТ — не редактируется, не должен коммититься в git, 
безопасно удалить и пересобрать (flutter clean && flutter pub get).