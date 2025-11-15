// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ingredients_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$IngredientsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String ingredient) toggleIngredient,
    required TResult Function() getRecipeByIngredients,
    required TResult Function() clearSelection,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String ingredient)? toggleIngredient,
    TResult? Function()? getRecipeByIngredients,
    TResult? Function()? clearSelection,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String ingredient)? toggleIngredient,
    TResult Function()? getRecipeByIngredients,
    TResult Function()? clearSelection,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggleIngredient value) toggleIngredient,
    required TResult Function(_GetRecipeByIngredients value)
    getRecipeByIngredients,
    required TResult Function(_ClearSelection value) clearSelection,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleIngredient value)? toggleIngredient,
    TResult? Function(_GetRecipeByIngredients value)? getRecipeByIngredients,
    TResult? Function(_ClearSelection value)? clearSelection,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleIngredient value)? toggleIngredient,
    TResult Function(_GetRecipeByIngredients value)? getRecipeByIngredients,
    TResult Function(_ClearSelection value)? clearSelection,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientsEventCopyWith<$Res> {
  factory $IngredientsEventCopyWith(
    IngredientsEvent value,
    $Res Function(IngredientsEvent) then,
  ) = _$IngredientsEventCopyWithImpl<$Res, IngredientsEvent>;
}

/// @nodoc
class _$IngredientsEventCopyWithImpl<$Res, $Val extends IngredientsEvent>
    implements $IngredientsEventCopyWith<$Res> {
  _$IngredientsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IngredientsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ToggleIngredientImplCopyWith<$Res> {
  factory _$$ToggleIngredientImplCopyWith(
    _$ToggleIngredientImpl value,
    $Res Function(_$ToggleIngredientImpl) then,
  ) = __$$ToggleIngredientImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String ingredient});
}

/// @nodoc
class __$$ToggleIngredientImplCopyWithImpl<$Res>
    extends _$IngredientsEventCopyWithImpl<$Res, _$ToggleIngredientImpl>
    implements _$$ToggleIngredientImplCopyWith<$Res> {
  __$$ToggleIngredientImplCopyWithImpl(
    _$ToggleIngredientImpl _value,
    $Res Function(_$ToggleIngredientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IngredientsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ingredient = null}) {
    return _then(
      _$ToggleIngredientImpl(
        null == ingredient
            ? _value.ingredient
            : ingredient // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ToggleIngredientImpl implements _ToggleIngredient {
  const _$ToggleIngredientImpl(this.ingredient);

  @override
  final String ingredient;

  @override
  String toString() {
    return 'IngredientsEvent.toggleIngredient(ingredient: $ingredient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleIngredientImpl &&
            (identical(other.ingredient, ingredient) ||
                other.ingredient == ingredient));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ingredient);

  /// Create a copy of IngredientsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleIngredientImplCopyWith<_$ToggleIngredientImpl> get copyWith =>
      __$$ToggleIngredientImplCopyWithImpl<_$ToggleIngredientImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String ingredient) toggleIngredient,
    required TResult Function() getRecipeByIngredients,
    required TResult Function() clearSelection,
  }) {
    return toggleIngredient(ingredient);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String ingredient)? toggleIngredient,
    TResult? Function()? getRecipeByIngredients,
    TResult? Function()? clearSelection,
  }) {
    return toggleIngredient?.call(ingredient);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String ingredient)? toggleIngredient,
    TResult Function()? getRecipeByIngredients,
    TResult Function()? clearSelection,
    required TResult orElse(),
  }) {
    if (toggleIngredient != null) {
      return toggleIngredient(ingredient);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggleIngredient value) toggleIngredient,
    required TResult Function(_GetRecipeByIngredients value)
    getRecipeByIngredients,
    required TResult Function(_ClearSelection value) clearSelection,
  }) {
    return toggleIngredient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleIngredient value)? toggleIngredient,
    TResult? Function(_GetRecipeByIngredients value)? getRecipeByIngredients,
    TResult? Function(_ClearSelection value)? clearSelection,
  }) {
    return toggleIngredient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleIngredient value)? toggleIngredient,
    TResult Function(_GetRecipeByIngredients value)? getRecipeByIngredients,
    TResult Function(_ClearSelection value)? clearSelection,
    required TResult orElse(),
  }) {
    if (toggleIngredient != null) {
      return toggleIngredient(this);
    }
    return orElse();
  }
}

abstract class _ToggleIngredient implements IngredientsEvent {
  const factory _ToggleIngredient(final String ingredient) =
      _$ToggleIngredientImpl;

  String get ingredient;

  /// Create a copy of IngredientsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleIngredientImplCopyWith<_$ToggleIngredientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetRecipeByIngredientsImplCopyWith<$Res> {
  factory _$$GetRecipeByIngredientsImplCopyWith(
    _$GetRecipeByIngredientsImpl value,
    $Res Function(_$GetRecipeByIngredientsImpl) then,
  ) = __$$GetRecipeByIngredientsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetRecipeByIngredientsImplCopyWithImpl<$Res>
    extends _$IngredientsEventCopyWithImpl<$Res, _$GetRecipeByIngredientsImpl>
    implements _$$GetRecipeByIngredientsImplCopyWith<$Res> {
  __$$GetRecipeByIngredientsImplCopyWithImpl(
    _$GetRecipeByIngredientsImpl _value,
    $Res Function(_$GetRecipeByIngredientsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IngredientsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetRecipeByIngredientsImpl implements _GetRecipeByIngredients {
  const _$GetRecipeByIngredientsImpl();

  @override
  String toString() {
    return 'IngredientsEvent.getRecipeByIngredients()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRecipeByIngredientsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String ingredient) toggleIngredient,
    required TResult Function() getRecipeByIngredients,
    required TResult Function() clearSelection,
  }) {
    return getRecipeByIngredients();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String ingredient)? toggleIngredient,
    TResult? Function()? getRecipeByIngredients,
    TResult? Function()? clearSelection,
  }) {
    return getRecipeByIngredients?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String ingredient)? toggleIngredient,
    TResult Function()? getRecipeByIngredients,
    TResult Function()? clearSelection,
    required TResult orElse(),
  }) {
    if (getRecipeByIngredients != null) {
      return getRecipeByIngredients();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggleIngredient value) toggleIngredient,
    required TResult Function(_GetRecipeByIngredients value)
    getRecipeByIngredients,
    required TResult Function(_ClearSelection value) clearSelection,
  }) {
    return getRecipeByIngredients(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleIngredient value)? toggleIngredient,
    TResult? Function(_GetRecipeByIngredients value)? getRecipeByIngredients,
    TResult? Function(_ClearSelection value)? clearSelection,
  }) {
    return getRecipeByIngredients?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleIngredient value)? toggleIngredient,
    TResult Function(_GetRecipeByIngredients value)? getRecipeByIngredients,
    TResult Function(_ClearSelection value)? clearSelection,
    required TResult orElse(),
  }) {
    if (getRecipeByIngredients != null) {
      return getRecipeByIngredients(this);
    }
    return orElse();
  }
}

abstract class _GetRecipeByIngredients implements IngredientsEvent {
  const factory _GetRecipeByIngredients() = _$GetRecipeByIngredientsImpl;
}

/// @nodoc
abstract class _$$ClearSelectionImplCopyWith<$Res> {
  factory _$$ClearSelectionImplCopyWith(
    _$ClearSelectionImpl value,
    $Res Function(_$ClearSelectionImpl) then,
  ) = __$$ClearSelectionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSelectionImplCopyWithImpl<$Res>
    extends _$IngredientsEventCopyWithImpl<$Res, _$ClearSelectionImpl>
    implements _$$ClearSelectionImplCopyWith<$Res> {
  __$$ClearSelectionImplCopyWithImpl(
    _$ClearSelectionImpl _value,
    $Res Function(_$ClearSelectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IngredientsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSelectionImpl implements _ClearSelection {
  const _$ClearSelectionImpl();

  @override
  String toString() {
    return 'IngredientsEvent.clearSelection()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSelectionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String ingredient) toggleIngredient,
    required TResult Function() getRecipeByIngredients,
    required TResult Function() clearSelection,
  }) {
    return clearSelection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String ingredient)? toggleIngredient,
    TResult? Function()? getRecipeByIngredients,
    TResult? Function()? clearSelection,
  }) {
    return clearSelection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String ingredient)? toggleIngredient,
    TResult Function()? getRecipeByIngredients,
    TResult Function()? clearSelection,
    required TResult orElse(),
  }) {
    if (clearSelection != null) {
      return clearSelection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ToggleIngredient value) toggleIngredient,
    required TResult Function(_GetRecipeByIngredients value)
    getRecipeByIngredients,
    required TResult Function(_ClearSelection value) clearSelection,
  }) {
    return clearSelection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ToggleIngredient value)? toggleIngredient,
    TResult? Function(_GetRecipeByIngredients value)? getRecipeByIngredients,
    TResult? Function(_ClearSelection value)? clearSelection,
  }) {
    return clearSelection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ToggleIngredient value)? toggleIngredient,
    TResult Function(_GetRecipeByIngredients value)? getRecipeByIngredients,
    TResult Function(_ClearSelection value)? clearSelection,
    required TResult orElse(),
  }) {
    if (clearSelection != null) {
      return clearSelection(this);
    }
    return orElse();
  }
}

abstract class _ClearSelection implements IngredientsEvent {
  const factory _ClearSelection() = _$ClearSelectionImpl;
}
