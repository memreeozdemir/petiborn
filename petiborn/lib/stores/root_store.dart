import 'package:petiborn/stores/auth_store.dart';
import 'package:petiborn/stores/theme_store.dart';
import 'package:mobx/mobx.dart';

part 'root_store.g.dart';

class RootStore = _RootStore with _$RootStore;

abstract class _RootStore with Store {
  _RootStore({
    required this.authStore,
    required this.themeStore,
  });

  @observable
  late AuthStore authStore;

  @observable
  late ThemeStore themeStore;
}