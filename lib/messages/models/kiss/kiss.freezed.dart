// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'kiss.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Kiss _$KissFromJson(Map<String, dynamic> json) {
  return _Kiss.fromJson(json);
}

/// @nodoc
mixin _$Kiss {
  String get type => throw _privateConstructorUsedError;
  String? get imageFile => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KissCopyWith<Kiss> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KissCopyWith<$Res> {
  factory $KissCopyWith(Kiss value, $Res Function(Kiss) then) =
      _$KissCopyWithImpl<$Res>;
  $Res call({String type, String? imageFile, String? message});
}

/// @nodoc
class _$KissCopyWithImpl<$Res> implements $KissCopyWith<$Res> {
  _$KissCopyWithImpl(this._value, this._then);

  final Kiss _value;
  // ignore: unused_field
  final $Res Function(Kiss) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? imageFile = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      imageFile: imageFile == freezed
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_KissCopyWith<$Res> implements $KissCopyWith<$Res> {
  factory _$$_KissCopyWith(_$_Kiss value, $Res Function(_$_Kiss) then) =
      __$$_KissCopyWithImpl<$Res>;
  @override
  $Res call({String type, String? imageFile, String? message});
}

/// @nodoc
class __$$_KissCopyWithImpl<$Res> extends _$KissCopyWithImpl<$Res>
    implements _$$_KissCopyWith<$Res> {
  __$$_KissCopyWithImpl(_$_Kiss _value, $Res Function(_$_Kiss) _then)
      : super(_value, (v) => _then(v as _$_Kiss));

  @override
  _$_Kiss get _value => super._value as _$_Kiss;

  @override
  $Res call({
    Object? type = freezed,
    Object? imageFile = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_Kiss(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      imageFile: imageFile == freezed
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Kiss extends _Kiss {
  _$_Kiss({required this.type, this.imageFile, this.message}) : super._();

  factory _$_Kiss.fromJson(Map<String, dynamic> json) => _$$_KissFromJson(json);

  @override
  final String type;
  @override
  final String? imageFile;
  @override
  final String? message;

  @override
  String toString() {
    return 'Kiss(type: $type, imageFile: $imageFile, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Kiss &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.imageFile, imageFile) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(imageFile),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_KissCopyWith<_$_Kiss> get copyWith =>
      __$$_KissCopyWithImpl<_$_Kiss>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_KissToJson(
      this,
    );
  }
}

abstract class _Kiss extends Kiss {
  factory _Kiss(
      {required final String type,
      final String? imageFile,
      final String? message}) = _$_Kiss;
  _Kiss._() : super._();

  factory _Kiss.fromJson(Map<String, dynamic> json) = _$_Kiss.fromJson;

  @override
  String get type;
  @override
  String? get imageFile;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_KissCopyWith<_$_Kiss> get copyWith => throw _privateConstructorUsedError;
}
