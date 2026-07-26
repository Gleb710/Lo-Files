## Требования к окружению
- Flutter SDK: 3.44.0 (fix)
- Dart SDK: идёт в комплекте с Flutter, отдельно не ставится (3.12.0)
- Android: minSdk = flutter.minSdkVersion
- iOS: (указать минимальную версию, если планируется)
- IDE: VS Code или Android Studio с плагином Flutter/Dart

---
## Первый запуск проекта
1. Клонировать репозиторий: git clone (https://github.com/Gleb710/Lo-Files.git), затем git checkout dev
2. Установить зависимости: flutter pub get
3. Сгенерировать код Drift (обязательно после клонирования и после 
   каждого изменения database.dart):
   dart run build_runner build --delete-conflicting-outputs
4. Запустить приложение: flutter run

---
## Особые требования проекта

### База данных (Drift)
- После КАЖДОГО изменения lib/core/database/database.dart нужно 
  перезапускать build_runner (шаг 3 выше) — иначе database.g.dart 
  устареет и приложение не соберётся.
- database.g.dart НЕ коммитится в git руками не редактируется — 
  генерируется автоматически (уточнить: файл сейчас закоммичен 
  в .gitignore или нет — если нет, добавить).
- БД называется 'lo_files_db' (задано в database.dart), 
  хранится локально на устройстве через drift_flutter.

### Разрешения (permissions)
- Пакет permission_handler требует разрешений на доступ к файлам:
  Android — добавить в AndroidManifest.xml (уточнить какие именно, 
  например READ_EXTERNAL_STORAGE / MANAGE_EXTERNAL_STORAGE для Android 11+)
  iOS — добавить в Info.plist (уточнить ключи, например 
  NSPhotoLibraryUsageDescription)
- Без этих разрешений функции файлового менеджера не работают 
  на реальном устройстве (могут работать в эмуляторе иначе).

### Ветки Git
- dev - основная ветка разработки
- main - только релизы

### Известные проблемы при сборке
- (заполнить по мере появления — например конфликты версий 
  sqlite3_flutter_libs на конкретной платформе)

## Полезные команды
- flutter clean — очистить кэш сборки при странных ошибках
- flutter pub get — переустановить зависимости после pull
- dart run build_runner build --delete-conflicting-outputs — 
  пересобрать Drift-код
- flutter doctor — проверить корректность настройки окружения
