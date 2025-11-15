// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecipeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RecipeCategory? category) getRandomRecipe,
    required TResult Function(String name) getRecipeByName,
    required TResult Function() reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RecipeCategory? category)? getRandomRecipe,
    TResult? Function(String name)? getRecipeByName,
    TResult? Function()? reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RecipeCategory? category)? getRandomRecipe,
    TResult Function(String name)? getRecipeByName,
    TResult Function()? reset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRandomRecipe value) getRandomRecipe,
    required TResult Function(_GetRecipeByName value) getRecipeByName,
    required TResult Function(_Reset value) reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRandomRecipe value)? getRandomRecipe,
    TResult? Function(_GetRecipeByName value)? getRecipeByName,
    TResult? Function(_Reset value)? reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRandomRecipe value)? getRandomRecipe,
    TResult Function(_GetRecipeByName value)? getRecipeByName,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeEventCopyWith<$Res> {
  factory $RecipeEventCopyWith(
    RecipeEvent value,
    $Res Function(RecipeEvent) then,
  ) = _$RecipeEventCopyWithImpl<$Res, RecipeEvent>;
}

/// @nodoc
class _$RecipeEventCopyWithImpl<$Res, $Val extends RecipeEvent>
    implements $RecipeEventCopyWith<$Res> {
  _$RecipeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GetRandomRecipeImplCopyWith<$Res> {
  factory _$$GetRandomRecipeImplCopyWith(
    _$GetRandomRecipeImpl value,
    $Res Function(_$GetRandomRecipeImpl) then,
  ) = __$$GetRandomRecipeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RecipeCategory? category});
}

/// @nodoc
class __$$GetRandomRecipeImplCopyWithImpl<$Res>
    extends _$RecipeEventCopyWithImpl<$Res, _$GetRandomRecipeImpl>
    implements _$$GetRandomRecipeImplCopyWith<$Res> {
  __$$GetRandomRecipeImplCopyWithImpl(
    _$GetRandomRecipeImpl _value,
    $Res Function(_$GetRandomRecipeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecipeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = freezed}) {
    return _then(
      _$GetRandomRecipeImpl(
        freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as RecipeCategory?,
      ),
    );
  }
}

/// @nodoc

class _$GetRandomRecipeImpl implements _GetRandomRecipe {
  const _$GetRandomRecipeImpl(this.category);

  @override
  final RecipeCategory? category;

  @override
  String toString() {
    return 'RecipeEvent.getRandomRecipe(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRandomRecipeImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of RecipeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetRandomRecipeImplCopyWith<_$GetRandomRecipeImpl> get copyWith =>
      __$$GetRandomRecipeImplCopyWithImpl<_$GetRandomRecipeImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RecipeCategory? category) getRandomRecipe,
    required TResult Function(String name) getRecipeByName,
    required TResult Function() reset,
  }) {
    return getRandomRecipe(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RecipeCategory? category)? getRandomRecipe,
    TResult? Function(String name)? getRecipeByName,
    TResult? Function()? reset,
  }) {
    return getRandomRecipe?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RecipeCategory? category)? getRandomRecipe,
    TResult Function(String name)? getRecipeByName,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (getRandomRecipe != null) {
      return getRandomRecipe(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRandomRecipe value) getRandomRecipe,
    required TResult Function(_GetRecipeByName value) getRecipeByName,
    required TResult Function(_Reset value) reset,
  }) {
    return getRandomRecipe(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRandomRecipe value)? getRandomRecipe,
    TResult? Function(_GetRecipeByName value)? getRecipeByName,
    TResult? Function(_Reset value)? reset,
  }) {
    return getRandomRecipe?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRandomRecipe value)? getRandomRecipe,
    TResult Function(_GetRecipeByName value)? getRecipeByName,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (getRandomRecipe != null) {
      return getRandomRecipe(this);
    }
    return orElse();
  }
}

abstract class _GetRandomRecipe implements RecipeEvent {
  const factory _GetRandomRecipe(final RecipeCategory? category) =
      _$GetRandomRecipeImpl;

  RecipeCategory? get category;

  /// Create a copy of RecipeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetRandomRecipeImplCopyWith<_$GetRandomRecipeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetRecipeByNameImplCopyWith<$Res> {
  factory _$$GetRecipeByNameImplCopyWith(
    _$GetRecipeByNameImpl value,
    $Res Function(_$GetRecipeByNameImpl) then,
  ) = __$$GetRecipeByNameImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$GetRecipeByNameImplCopyWithImpl<$Res>
    extends _$RecipeEventCopyWithImpl<$Res, _$GetRecipeByNameImpl>
    implements _$$GetRecipeByNameImplCopyWith<$Res> {
  __$$GetRecipeByNameImplCopyWithImpl(
    _$GetRecipeByNameImpl _value,
    $Res Function(_$GetRecipeByNameImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecipeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$GetRecipeByNameImpl(
        null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$GetRecipeByNameImpl implements _GetRecipeByName {
  const _$GetRecipeByNameImpl(this.name);

  @override
  final String name;

  @override
  String toString() {
    return 'RecipeEvent.getRecipeByName(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRecipeByNameImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of RecipeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetRecipeByNameImplCopyWith<_$GetRecipeByNameImpl> get copyWith =>
      __$$GetRecipeByNameImplCopyWithImpl<_$GetRecipeByNameImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RecipeCategory? category) getRandomRecipe,
    required TResult Function(String name) getRecipeByName,
    required TResult Function() reset,
  }) {
    return getRecipeByName(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RecipeCategory? category)? getRandomRecipe,
    TResult? Function(String name)? getRecipeByName,
    TResult? Function()? reset,
  }) {
    return getRecipeByName?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RecipeCategory? category)? getRandomRecipe,
    TResult Function(String name)? getRecipeByName,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (getRecipeByName != null) {
      return getRecipeByName(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRandomRecipe value) getRandomRecipe,
    required TResult Function(_GetRecipeByName value) getRecipeByName,
    required TResult Function(_Reset value) reset,
  }) {
    return getRecipeByName(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRandomRecipe value)? getRandomRecipe,
    TResult? Function(_GetRecipeByName value)? getRecipeByName,
    TResult? Function(_Reset value)? reset,
  }) {
    return getRecipeByName?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRandomRecipe value)? getRandomRecipe,
    TResult Function(_GetRecipeByName value)? getRecipeByName,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (getRecipeByName != null) {
      return getRecipeByName(this);
    }
    return orElse();
  }
}

abstract class _GetRecipeByName implements RecipeEvent {
  const factory _GetRecipeByName(final String name) = _$GetRecipeByNameImpl;

  String get name;

  /// Create a copy of RecipeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetRecipeByNameImplCopyWith<_$GetRecipeByNameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetImplCopyWith<$Res> {
  factory _$$ResetImplCopyWith(
    _$ResetImpl value,
    $Res Function(_$ResetImpl) then,
  ) = __$$ResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetImplCopyWithImpl<$Res>
    extends _$RecipeEventCopyWithImpl<$Res, _$ResetImpl>
    implements _$$ResetImplCopyWith<$Res> {
  __$$ResetImplCopyWithImpl(
    _$ResetImpl _value,
    $Res Function(_$ResetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecipeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetImpl implements _Reset {
  const _$ResetImpl();

  @override
  String toString() {
    return 'RecipeEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RecipeCategory? category) getRandomRecipe,
    required TResult Function(String name) getRecipeByName,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RecipeCategory? category)? getRandomRecipe,
    TResult? Function(String name)? getRecipeByName,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RecipeCategory? category)? getRandomRecipe,
    TResult Function(String name)? getRecipeByName,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetRandomRecipe value) getRandomRecipe,
    required TResult Function(_GetRecipeByName value) getRecipeByName,
    required TResult Function(_Reset value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetRandomRecipe value)? getRandomRecipe,
    TResult? Function(_GetRecipeByName value)? getRecipeByName,
    TResult? Function(_Reset value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetRandomRecipe value)? getRandomRecipe,
    TResult Function(_GetRecipeByName value)? getRecipeByName,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class _Reset implements RecipeEvent {
  const factory _Reset() = _$ResetImpl;
}
