import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// Доменная модель пользователя Lo-Files.
///
/// Поле [isGuest] используется redirect-логикой go_router для определения,
/// пускать ли пользователя на основной экран без полноценной сессии.
/// В MVP backend не реализуется, поэтому модель хранится только локально
/// в user_profile_cache и не содержит email, hashedPassword или других
/// backend-полей.
@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String displayName,
    required bool isGuest,
  }) = _User;

  factory User.guest({
    required String id,
  }) =>
      User(
        id: id,
        displayName: 'Гость',
        isGuest: true,
      );
}