// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RootStore on _RootStore, Store {
  late final _$authStoreAtom =
      Atom(name: '_RootStore.authStore', context: context);

  @override
  AuthStore get authStore {
    _$authStoreAtom.reportRead();
    return super.authStore;
  }

  bool _authStoreIsInitialized = false;

  @override
  set authStore(AuthStore value) {
    _$authStoreAtom.reportWrite(
        value, _authStoreIsInitialized ? super.authStore : null, () {
      super.authStore = value;
      _authStoreIsInitialized = true;
    });
  }

  late final _$themeStoreAtom =
      Atom(name: '_RootStore.themeStore', context: context);

  @override
  ThemeStore get themeStore {
    _$themeStoreAtom.reportRead();
    return super.themeStore;
  }

  bool _themeStoreIsInitialized = false;

  @override
  set themeStore(ThemeStore value) {
    _$themeStoreAtom.reportWrite(
        value, _themeStoreIsInitialized ? super.themeStore : null, () {
      super.themeStore = value;
      _themeStoreIsInitialized = true;
    });
  }

  @override
  String toString() {
    return '''
authStore: ${authStore},
themeStore: ${themeStore}
    ''';
  }
}
