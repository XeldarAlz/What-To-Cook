// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ingredients_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$IngredientsState {
  List<String> get selectedIngredients => throw _privateConstructorUsedError;
  List<String> get availableIngredients => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    initial,
    required TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    loading,
    required TResult Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    loaded,
    required TResult Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    initial,
    TResult? Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loading,
    TResult? Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loaded,
    TResult? Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    initial,
    TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loading,
    TResult Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loaded,
    TResult Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IngredientsStateCopyWith<IngredientsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientsStateCopyWith<$Res> {
  factory $IngredientsStateCopyWith(
    IngredientsState value,
    $Res Function(IngredientsState) then,
  ) = _$IngredientsStateCopyWithImpl<$Res, IngredientsState>;
  @useResult
  $Res call({
    List<String> selectedIngredients,
    List<String> availableIngredients,
  });
}

/// @nodoc
class _$IngredientsStateCopyWithImpl<$Res, $Val extends IngredientsState>
    implements $IngredientsStateCopyWith<$Res> {
  _$IngredientsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIngredients = null,
    Object? availableIngredients = null,
  }) {
    return _then(
      _value.copyWith(
            selectedIngredients: null == selectedIngredients
                ? _value.selectedIngredients
                : selectedIngredients // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            availableIngredients: null == availableIngredients
                ? _value.availableIngredients
                : availableIngredients // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $IngredientsStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String> selectedIngredients,
    List<String> availableIngredients,
  });
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$IngredientsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIngredients = null,
    Object? availableIngredients = null,
  }) {
    return _then(
      _$InitialImpl(
        selectedIngredients: null == selectedIngredients
            ? _value._selectedIngredients
            : selectedIngredients // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        availableIngredients: null == availableIngredients
            ? _value._availableIngredients
            : availableIngredients // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl({
    final List<String> selectedIngredients = const <String>[],
    final List<String> availableIngredients = const <String>[],
  }) : _selectedIngredients = selectedIngredients,
       _availableIngredients = availableIngredients;

  final List<String> _selectedIngredients;
  @override
  @JsonKey()
  List<String> get selectedIngredients {
    if (_selectedIngredients is EqualUnmodifiableListView)
      return _selectedIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedIngredients);
  }

  final List<String> _availableIngredients;
  @override
  @JsonKey()
  List<String> get availableIngredients {
    if (_availableIngredients is EqualUnmodifiableListView)
      return _availableIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableIngredients);
  }

  @override
  String toString() {
    return 'IngredientsState.initial(selectedIngredients: $selectedIngredients, availableIngredients: $availableIngredients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            const DeepCollectionEquality().equals(
              other._selectedIngredients,
              _selectedIngredients,
            ) &&
            const DeepCollectionEquality().equals(
              other._availableIngredients,
              _availableIngredients,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_selectedIngredients),
    const DeepCollectionEquality().hash(_availableIngredients),
  );

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    initial,
    required TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    loading,
    required TResult Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    loaded,
    required TResult Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    error,
  }) {
    return initial(selectedIngredients, availableIngredients);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    initial,
    TResult? Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loading,
    TResult? Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loaded,
    TResult? Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    error,
  }) {
    return initial?.call(selectedIngredients, availableIngredients);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    initial,
    TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loading,
    TResult Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loaded,
    TResult Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(selectedIngredients, availableIngredients);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements IngredientsState {
  const factory _Initial({
    final List<String> selectedIngredients,
    final List<String> availableIngredients,
  }) = _$InitialImpl;

  @override
  List<String> get selectedIngredients;
  @override
  List<String> get availableIngredients;

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $IngredientsStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String> selectedIngredients,
    List<String> availableIngredients,
  });
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$IngredientsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIngredients = null,
    Object? availableIngredients = null,
  }) {
    return _then(
      _$LoadingImpl(
        selectedIngredients: null == selectedIngredients
            ? _value._selectedIngredients
            : selectedIngredients // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        availableIngredients: null == availableIngredients
            ? _value._availableIngredients
            : availableIngredients // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl({
    required final List<String> selectedIngredients,
    required final List<String> availableIngredients,
  }) : _selectedIngredients = selectedIngredients,
       _availableIngredients = availableIngredients;

  final List<String> _selectedIngredients;
  @override
  List<String> get selectedIngredients {
    if (_selectedIngredients is EqualUnmodifiableListView)
      return _selectedIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedIngredients);
  }

  final List<String> _availableIngredients;
  @override
  List<String> get availableIngredients {
    if (_availableIngredients is EqualUnmodifiableListView)
      return _availableIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableIngredients);
  }

  @override
  String toString() {
    return 'IngredientsState.loading(selectedIngredients: $selectedIngredients, availableIngredients: $availableIngredients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            const DeepCollectionEquality().equals(
              other._selectedIngredients,
              _selectedIngredients,
            ) &&
            const DeepCollectionEquality().equals(
              other._availableIngredients,
              _availableIngredients,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_selectedIngredients),
    const DeepCollectionEquality().hash(_availableIngredients),
  );

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    initial,
    required TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    loading,
    required TResult Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    loaded,
    required TResult Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    error,
  }) {
    return loading(selectedIngredients, availableIngredients);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    initial,
    TResult? Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loading,
    TResult? Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loaded,
    TResult? Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    error,
  }) {
    return loading?.call(selectedIngredients, availableIngredients);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    initial,
    TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loading,
    TResult Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loaded,
    TResult Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(selectedIngredients, availableIngredients);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements IngredientsState {
  const factory _Loading({
    required final List<String> selectedIngredients,
    required final List<String> availableIngredients,
  }) = _$LoadingImpl;

  @override
  List<String> get selectedIngredients;
  @override
  List<String> get availableIngredients;

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res>
    implements $IngredientsStateCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Recipe recipe,
    List<String> selectedIngredients,
    List<String> availableIngredients,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$IngredientsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipe = null,
    Object? selectedIngredients = null,
    Object? availableIngredients = null,
  }) {
    return _then(
      _$LoadedImpl(
        recipe: null == recipe
            ? _value.recipe
            : recipe // ignore: cast_nullable_to_non_nullable
                  as Recipe,
        selectedIngredients: null == selectedIngredients
            ? _value._selectedIngredients
            : selectedIngredients // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        availableIngredients: null == availableIngredients
            ? _value._availableIngredients
            : availableIngredients // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({
    required this.recipe,
    required final List<String> selectedIngredients,
    required final List<String> availableIngredients,
  }) : _selectedIngredients = selectedIngredients,
       _availableIngredients = availableIngredients;

  @override
  final Recipe recipe;
  final List<String> _selectedIngredients;
  @override
  List<String> get selectedIngredients {
    if (_selectedIngredients is EqualUnmodifiableListView)
      return _selectedIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedIngredients);
  }

  final List<String> _availableIngredients;
  @override
  List<String> get availableIngredients {
    if (_availableIngredients is EqualUnmodifiableListView)
      return _availableIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableIngredients);
  }

  @override
  String toString() {
    return 'IngredientsState.loaded(recipe: $recipe, selectedIngredients: $selectedIngredients, availableIngredients: $availableIngredients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.recipe, recipe) || other.recipe == recipe) &&
            const DeepCollectionEquality().equals(
              other._selectedIngredients,
              _selectedIngredients,
            ) &&
            const DeepCollectionEquality().equals(
              other._availableIngredients,
              _availableIngredients,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    recipe,
    const DeepCollectionEquality().hash(_selectedIngredients),
    const DeepCollectionEquality().hash(_availableIngredients),
  );

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    initial,
    required TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    loading,
    required TResult Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    loaded,
    required TResult Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    error,
  }) {
    return loaded(recipe, selectedIngredients, availableIngredients);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    initial,
    TResult? Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loading,
    TResult? Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loaded,
    TResult? Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    error,
  }) {
    return loaded?.call(recipe, selectedIngredients, availableIngredients);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    initial,
    TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loading,
    TResult Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loaded,
    TResult Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(recipe, selectedIngredients, availableIngredients);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements IngredientsState {
  const factory _Loaded({
    required final Recipe recipe,
    required final List<String> selectedIngredients,
    required final List<String> availableIngredients,
  }) = _$LoadedImpl;

  Recipe get recipe;
  @override
  List<String> get selectedIngredients;
  @override
  List<String> get availableIngredients;

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res>
    implements $IngredientsStateCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Failure failure,
    List<String> selectedIngredients,
    List<String> availableIngredients,
  });
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$IngredientsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
    Object? selectedIngredients = null,
    Object? availableIngredients = null,
  }) {
    return _then(
      _$ErrorImpl(
        failure: null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as Failure,
        selectedIngredients: null == selectedIngredients
            ? _value._selectedIngredients
            : selectedIngredients // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        availableIngredients: null == availableIngredients
            ? _value._availableIngredients
            : availableIngredients // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({
    required this.failure,
    required final List<String> selectedIngredients,
    required final List<String> availableIngredients,
  }) : _selectedIngredients = selectedIngredients,
       _availableIngredients = availableIngredients;

  @override
  final Failure failure;
  final List<String> _selectedIngredients;
  @override
  List<String> get selectedIngredients {
    if (_selectedIngredients is EqualUnmodifiableListView)
      return _selectedIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedIngredients);
  }

  final List<String> _availableIngredients;
  @override
  List<String> get availableIngredients {
    if (_availableIngredients is EqualUnmodifiableListView)
      return _availableIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableIngredients);
  }

  @override
  String toString() {
    return 'IngredientsState.error(failure: $failure, selectedIngredients: $selectedIngredients, availableIngredients: $availableIngredients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure) &&
            const DeepCollectionEquality().equals(
              other._selectedIngredients,
              _selectedIngredients,
            ) &&
            const DeepCollectionEquality().equals(
              other._availableIngredients,
              _availableIngredients,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    failure,
    const DeepCollectionEquality().hash(_selectedIngredients),
    const DeepCollectionEquality().hash(_availableIngredients),
  );

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    initial,
    required TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    loading,
    required TResult Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    loaded,
    required TResult Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )
    error,
  }) {
    return error(failure, selectedIngredients, availableIngredients);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    initial,
    TResult? Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loading,
    TResult? Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loaded,
    TResult? Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    error,
  }) {
    return error?.call(failure, selectedIngredients, availableIngredients);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    initial,
    TResult Function(
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loading,
    TResult Function(
      Recipe recipe,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    loaded,
    TResult Function(
      Failure failure,
      List<String> selectedIngredients,
      List<String> availableIngredients,
    )?
    error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure, selectedIngredients, availableIngredients);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements IngredientsState {
  const factory _Error({
    required final Failure failure,
    required final List<String> selectedIngredients,
    required final List<String> availableIngredients,
  }) = _$ErrorImpl;

  Failure get failure;
  @override
  List<String> get selectedIngredients;
  @override
  List<String> get availableIngredients;

  /// Create a copy of IngredientsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
