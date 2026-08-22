// lib/features/storage/domain/repositories/file_repository.dart

import '../../../../core/result/result.dart';
import '../models/file.dart';

/// Контракт репозитория для работы с файлами виртуального хранилища.
///
/// [FileRepository] — это интерфейс уровня Domain-слоя, который объявляет
/// операции CRUD для файлов, но не содержит никакой реализации, связанной
/// с конкретной БД (Drift), сетью или файловой системой устройства.
/// Реализация появится в Data-слое на неделе 2 как `DriftFileRepository`,
/// работающая с локальной SQLite-таблицей `local_files`.
///
/// ## Точка расширения для облачных хранилищ
/// Этот интерфейс спроектирован так, чтобы в будущем облачное хранилище
/// (Google Drive, OneDrive) могло стать альтернативной реализацией того
/// же интерфейса без изменения кода, который его использует (см.
/// docs/architecture.md, раздел 10 — Repository Interface). Presentation-
/// слой и use case'ы зависят только от этого контракта, а не от конкретной
/// реализации.
///
/// ## Обработка ошибок
/// Все методы возвращают `Result<T>` (docs/architecture.md, раздел 3.4 —
/// Result / Envelope Pattern, пункт А). Это означает, что вызывающий код
/// обязан явно обработать оба исхода: успех (`Result.success`) или ошибку
/// (`Result.failure` с `errorCode` и `errorMessage`). Исключения не
/// выбрасываются на границах слоёв use case — любые ошибки Drift, сети
/// или файловой системы должны быть перехвачены в Data-слое и завёрнуты
/// в `Result.failure` с соответствующим кодом ошибки.
///
/// ## Типы идентификаторов
/// - `fileId` — `String` (не `int`), так как в будущем может потребоваться
///   использовать UUID или аналог для кросс-платформенной совместимости
///   с облачными API.
/// - `folderId` — также `String`, по той же причине.
/// - `targetFolderId` в [moveFile] может быть `null` только если это
///   означает перемещение в корень виртуального хранилища (аналогично
///   `Folder.parentId == null` в доменной модели).
abstract class FileRepository {
  /// Возвращает список файлов в указанной папке.
  ///
  /// Если [folderId] равен `null`, возвращает файлы корневой папки
  /// виртуального хранилища (аналог `Folder.parentId == null`).
  ///
  /// Возвращает `Result.success` со списком файлов (пустой список, если
  /// папка пуста) или `Result.failure` с кодом ошибки (например,
  /// 'folder_not_found', если [folderId] указан, но не существует).
  Future<Result<List<File>>> getFiles(String? folderId);

  /// Создаёт новый файл в хранилище.
  ///
  /// [file] — доменная модель файла, которая должна быть сохранена.
  /// В Data-слое [file] будет преобразован в storage-модель `LocalFiles`
  /// через отдельный маппер (см. docs/architecture.md, раздел 3.7 —
  /// Domain Model vs Storage Model vs DTO vs View Model).
  ///
  /// Возвращает `Result.success` с сохранённой доменной моделью (возможно,
  /// с обновлёнными полями, такими как сгенерированный `id` или
  /// `createdAt`) или `Result.failure` с кодом ошибки (например,
  /// 'duplicate_name', если файл с таким именем уже существует в целевой
  /// папке, или 'folder_not_found', если целевая папка не существует).
  Future<Result<File>> createFile(File file);

  /// Переименовывает файл с указанным [fileId].
  ///
  /// [newName] — новое имя файла (без пути, только базовое имя).
  ///
  /// Возвращает `Result.success` с обновлённой доменной моделью или
  /// `Result.failure` с кодом ошибки (например, 'file_not_found', если
  /// [fileId] не существует, или 'duplicate_name', если новое имя уже
  /// занято в той же папке).
  Future<Result<File>> renameFile(String fileId, String newName);

  /// Перемещает файл с указанным [fileId] в целевую папку.
  ///
  /// [targetFolderId] — идентификатор целевой папки. Если `null`, означает
  /// перемещение в корень виртуального хранилища (аналог
  /// `Folder.parentId == null`).
  ///
  /// Возвращает `Result.success` с обновлённой доменной моделью или
  /// `Result.failure` с кодом ошибки (например, 'file_not_found', если
  /// [fileId] не существует, или 'folder_not_found', если
  /// [targetFolderId] указан, но не существует).
  Future<Result<File>> moveFile(String fileId, String? targetFolderId);

  /// Удаляет файл с указанным [fileId] из хранилища.
  ///
  /// Возвращает `Result.success` с удалённой доменной моделью (если нужно
  /// для отката операции) или `Result.failure` с кодом ошибки (например,
  /// 'file_not_found', если [fileId] не существует).
  Future<Result<File>> deleteFile(String fileId);
}