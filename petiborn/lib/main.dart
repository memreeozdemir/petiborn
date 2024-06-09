import 'package:firebase_core/firebase_core.dart';
import 'package:petiborn/firebase_options.dart';
import 'package:petiborn/stores/root_store.dart';
import "package:flutter/material.dart";
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petiborn/injector.dart' as injector;
import 'package:petiborn/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await injector.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return MaterialApp(
          title: 'PetIBorn',
          theme: ThemeData(
            primaryColor: injector.serviceLocator
                .get<RootStore>()
                .themeStore
                .primaryColor,
            appBarTheme: AppBarTheme(
              backgroundColor: injector.serviceLocator
                  .get<RootStore>()
                  .themeStore
                  .primaryColor,
            ),
          ),
          initialRoute: Routes.splash,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
