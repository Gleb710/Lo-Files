// lib/core/result/result.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

/// Универсальный контейнер результата операции для внутреннего использования
/// в Domain- и Data-слоях.
///
/// [Result<T>] — это альтернатива выбрасыванию исключений на границах слоёв
/// use case и репозиториев. Вместо того чтобы полагаться на try/catch,
/// вызывающий код явно обрабатывает оба исхода: успех ([success] == true,
/// [data] содержит результат) или ошибку ([success] == false, [errorCode]
/// и [errorMessage] описывают проблему).
///
/// ## Соответствие архитектурному документу
/// Этот тип реализует контракт из docs/architecture.md, раздел 3.4
/// (Result / Envelope Pattern — пункт А):
/// ```
/// Result<T> {
///   success: bool,
///   data: T?,
///   errorCode: String?,
///   errorMessage: String?
/// }
/// ```
/// Смешивать этот контракт с API-конвертом (пункт Б того же раздела)
/// нельзя: [Result<T>] используется только для внутренних методов и
/// use case'ов, а не для сетевого обмена клиент↔backend.
///
/// ## Почему freezed, а не простой класс
/// - Неизменяемость по умолчанию (все поля final).
/// - Автоматическая генерация `copyWith`, `==`, `hashCode`, `toString`.
/// - Явные фабричные конструкторы `Result.success` и `Result.failure`
///   вместо ручного заполнения четырёх полей, что снижает вероятность
///   ошибки (например, забыть установить [success] в false при ошибке).
/// - Консистентность с остальными доменными моделями проекта
///   (`File`, `Folder`, `User`, `RecentEntry`, `FavoriteEntry`),
///   которые уже используют `@freezed`.
@freezed
abstract class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success(T data) = ResultSuccess<T>;

  const factory Result.failure({
    required String errorCode,
    required String errorMessage,
  }) = ResultFailure<T>;

  /// Возвращает true, если операция завершилась успешно.
  ///
  /// Для [ResultSuccess] всегда true, для [ResultFailure] всегда false.
  bool get success => this is ResultSuccess<T>;

  /// Данные результата, если операция успешна, иначе null.
  ///
  /// Для [ResultSuccess] содержит результат, для [ResultFailure] всегда null.
  T? get data => (this as ResultSuccess<T>?)?.data;

  /// Код ошибки, если операция завершилась неудачей, иначе null.
  ///
  /// Для [ResultFailure] содержит код ошибки (например, 'file_not_found',
  /// 'folder_not_empty'), для [ResultSuccess] всегда null.
  String? get errorCode => (this as ResultFailure<T>?)?.errorCode;

  /// Человекочитаемое сообщение об ошибке, если операция завершилась
  /// неудачей, иначе null.
  ///
  /// Для [ResultFailure] содержит описание проблемы, для [ResultSuccess]
  /// всегда null.
  String? get errorMessage => (this as ResultFailure<T>?)?.errorMessage;
}