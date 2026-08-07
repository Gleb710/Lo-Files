// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecentEntry {

/// Идентификатор записи (первичный ключ таблицы `recent_entries`).
 int get id;/// Идентификатор файла (`local_files.id`), к которому относится запись.
 int get fileId;/// Момент, когда файл был открыт пользователем.
 DateTime get openedAt;/// Статус синхронизации записи с backend-модулем Sync.
///
/// Задел под будущий модуль синхронизации (см. [SyncStatus]). В MVP
/// это поле всегда `null` и НЕ ДОЛЖНО использоваться в бизнес-логике.
 SyncStatus? get syncStatus;
/// Create a copy of RecentEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentEntryCopyWith<RecentEntry> get copyWith => _$RecentEntryCopyWithImpl<RecentEntry>(this as RecentEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,fileId,openedAt,syncStatus);

@override
String toString() {
  return 'RecentEntry(id: $id, fileId: $fileId, openedAt: $openedAt, syncStatus: $syncStatus)';
}


}

/// @nodoc
abstract mixin class $RecentEntryCopyWith<$Res>  {
  factory $RecentEntryCopyWith(RecentEntry value, $Res Function(RecentEntry) _then) = _$RecentEntryCopyWithImpl;
@useResult
$Res call({
 int id, int fileId, DateTime openedAt, SyncStatus? syncStatus
});




}
/// @nodoc
class _$RecentEntryCopyWithImpl<$Res>
    implements $RecentEntryCopyWith<$Res> {
  _$RecentEntryCopyWithImpl(this._self, this._then);

  final RecentEntry _self;
  final $Res Function(RecentEntry) _then;

/// Create a copy of RecentEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fileId = null,Object? openedAt = null,Object? syncStatus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as int,openedAt: null == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: freezed == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentEntry].
extension RecentEntryPatterns on RecentEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentEntry value)  $default,){
final _that = this;
switch (_that) {
case _RecentEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentEntry value)?  $default,){
final _that = this;
switch (_that) {
case _RecentEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int fileId,  DateTime openedAt,  SyncStatus? syncStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentEntry() when $default != null:
return $default(_that.id,_that.fileId,_that.openedAt,_that.syncStatus);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int fileId,  DateTime openedAt,  SyncStatus? syncStatus)  $default,) {final _that = this;
switch (_that) {
case _RecentEntry():
return $default(_that.id,_that.fileId,_that.openedAt,_that.syncStatus);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int fileId,  DateTime openedAt,  SyncStatus? syncStatus)?  $default,) {final _that = this;
switch (_that) {
case _RecentEntry() when $default != null:
return $default(_that.id,_that.fileId,_that.openedAt,_that.syncStatus);case _:
  return null;

}
}

}

/// @nodoc


class _RecentEntry implements RecentEntry {
  const _RecentEntry({required this.id, required this.fileId, required this.openedAt, this.syncStatus});
  

/// Идентификатор записи (первичный ключ таблицы `recent_entries`).
@override final  int id;
/// Идентификатор файла (`local_files.id`), к которому относится запись.
@override final  int fileId;
/// Момент, когда файл был открыт пользователем.
@override final  DateTime openedAt;
/// Статус синхронизации записи с backend-модулем Sync.
///
/// Задел под будущий модуль синхронизации (см. [SyncStatus]). В MVP
/// это поле всегда `null` и НЕ ДОЛЖНО использоваться в бизнес-логике.
@override final  SyncStatus? syncStatus;

/// Create a copy of RecentEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentEntryCopyWith<_RecentEntry> get copyWith => __$RecentEntryCopyWithImpl<_RecentEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,fileId,openedAt,syncStatus);

@override
String toString() {
  return 'RecentEntry(id: $id, fileId: $fileId, openedAt: $openedAt, syncStatus: $syncStatus)';
}


}

/// @nodoc
abstract mixin class _$RecentEntryCopyWith<$Res> implements $RecentEntryCopyWith<$Res> {
  factory _$RecentEntryCopyWith(_RecentEntry value, $Res Function(_RecentEntry) _then) = __$RecentEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, int fileId, DateTime openedAt, SyncStatus? syncStatus
});




}
/// @nodoc
class __$RecentEntryCopyWithImpl<$Res>
    implements _$RecentEntryCopyWith<$Res> {
  __$RecentEntryCopyWithImpl(this._self, this._then);

  final _RecentEntry _self;
  final $Res Function(_RecentEntry) _then;

/// Create a copy of RecentEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fileId = null,Object? openedAt = null,Object? syncStatus = freezed,}) {
  return _then(_RecentEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as int,openedAt: null == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: freezed == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus?,
  ));
}


}

// dart format on
