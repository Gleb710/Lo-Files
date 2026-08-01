// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$File {

 int get id; String get name; String get path; FileType get type; int get size; DateTime get createdAt;/// Дополнительные метаданные объекта.
///
/// Задел под будущую систему плагинов (docs/architecture.md, раздел 9.1).
/// В MVP не используется активно — поле физически существует, чтобы
/// избежать изменения сигнатуры [File] после того, как на неё уже
/// будет ссылаться код остальных модулей (Storage, Viewer, Search,
/// Recent & Favorites).
 Map<String, dynamic>? get extraMetadata;
/// Create a copy of File
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileCopyWith<File> get copyWith => _$FileCopyWithImpl<File>(this as File, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is File&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path)&&(identical(other.type, type) || other.type == type)&&(identical(other.size, size) || other.size == size)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.extraMetadata, extraMetadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,path,type,size,createdAt,const DeepCollectionEquality().hash(extraMetadata));

@override
String toString() {
  return 'File(id: $id, name: $name, path: $path, type: $type, size: $size, createdAt: $createdAt, extraMetadata: $extraMetadata)';
}


}

/// @nodoc
abstract mixin class $FileCopyWith<$Res>  {
  factory $FileCopyWith(File value, $Res Function(File) _then) = _$FileCopyWithImpl;
@useResult
$Res call({
 int id, String name, String path, FileType type, int size, DateTime createdAt, Map<String, dynamic>? extraMetadata
});




}
/// @nodoc
class _$FileCopyWithImpl<$Res>
    implements $FileCopyWith<$Res> {
  _$FileCopyWithImpl(this._self, this._then);

  final File _self;
  final $Res Function(File) _then;

/// Create a copy of File
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? path = null,Object? type = null,Object? size = null,Object? createdAt = null,Object? extraMetadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FileType,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,extraMetadata: freezed == extraMetadata ? _self.extraMetadata : extraMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [File].
extension FilePatterns on File {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _File value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _File() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _File value)  $default,){
final _that = this;
switch (_that) {
case _File():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _File value)?  $default,){
final _that = this;
switch (_that) {
case _File() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String path,  FileType type,  int size,  DateTime createdAt,  Map<String, dynamic>? extraMetadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _File() when $default != null:
return $default(_that.id,_that.name,_that.path,_that.type,_that.size,_that.createdAt,_that.extraMetadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String path,  FileType type,  int size,  DateTime createdAt,  Map<String, dynamic>? extraMetadata)  $default,) {final _that = this;
switch (_that) {
case _File():
return $default(_that.id,_that.name,_that.path,_that.type,_that.size,_that.createdAt,_that.extraMetadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String path,  FileType type,  int size,  DateTime createdAt,  Map<String, dynamic>? extraMetadata)?  $default,) {final _that = this;
switch (_that) {
case _File() when $default != null:
return $default(_that.id,_that.name,_that.path,_that.type,_that.size,_that.createdAt,_that.extraMetadata);case _:
  return null;

}
}

}

/// @nodoc


class _File implements File {
  const _File({required this.id, required this.name, required this.path, required this.type, required this.size, required this.createdAt, final  Map<String, dynamic>? extraMetadata}): _extraMetadata = extraMetadata;
  

@override final  int id;
@override final  String name;
@override final  String path;
@override final  FileType type;
@override final  int size;
@override final  DateTime createdAt;
/// Дополнительные метаданные объекта.
///
/// Задел под будущую систему плагинов (docs/architecture.md, раздел 9.1).
/// В MVP не используется активно — поле физически существует, чтобы
/// избежать изменения сигнатуры [File] после того, как на неё уже
/// будет ссылаться код остальных модулей (Storage, Viewer, Search,
/// Recent & Favorites).
 final  Map<String, dynamic>? _extraMetadata;
/// Дополнительные метаданные объекта.
///
/// Задел под будущую систему плагинов (docs/architecture.md, раздел 9.1).
/// В MVP не используется активно — поле физически существует, чтобы
/// избежать изменения сигнатуры [File] после того, как на неё уже
/// будет ссылаться код остальных модулей (Storage, Viewer, Search,
/// Recent & Favorites).
@override Map<String, dynamic>? get extraMetadata {
  final value = _extraMetadata;
  if (value == null) return null;
  if (_extraMetadata is EqualUnmodifiableMapView) return _extraMetadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of File
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileCopyWith<_File> get copyWith => __$FileCopyWithImpl<_File>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _File&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path)&&(identical(other.type, type) || other.type == type)&&(identical(other.size, size) || other.size == size)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._extraMetadata, _extraMetadata));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,path,type,size,createdAt,const DeepCollectionEquality().hash(_extraMetadata));

@override
String toString() {
  return 'File(id: $id, name: $name, path: $path, type: $type, size: $size, createdAt: $createdAt, extraMetadata: $extraMetadata)';
}


}

/// @nodoc
abstract mixin class _$FileCopyWith<$Res> implements $FileCopyWith<$Res> {
  factory _$FileCopyWith(_File value, $Res Function(_File) _then) = __$FileCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String path, FileType type, int size, DateTime createdAt, Map<String, dynamic>? extraMetadata
});




}
/// @nodoc
class __$FileCopyWithImpl<$Res>
    implements _$FileCopyWith<$Res> {
  __$FileCopyWithImpl(this._self, this._then);

  final _File _self;
  final $Res Function(_File) _then;

/// Create a copy of File
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? path = null,Object? type = null,Object? size = null,Object? createdAt = null,Object? extraMetadata = freezed,}) {
  return _then(_File(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FileType,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,extraMetadata: freezed == extraMetadata ? _self._extraMetadata : extraMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
