import 'package:flutter/material.dart';
import 'package:petiborn/stores/pages/appointment_page.dart';
import 'package:petiborn/stores/pages/blog_page.dart';
import 'package:petiborn/stores/pages/pet_care.dart';
import 'package:petiborn/stores/pages/splash_page.dart';
import 'package:petiborn/stores/pages/login_page.dart';
import 'package:petiborn/stores/pages/home_page.dart';
import 'package:petiborn/stores/pages/inf_page.dart';
import 'package:petiborn/stores/pages/appointment_page.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String appointment = '/appointment';
  static const String blog = '/blog';
  static const String info = '/info';
  static const String petcare = '/petcare';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case appointment:
        return MaterialPageRoute(builder: (_) => AppointmentPage());
      case blog:
        return MaterialPageRoute(builder: (_) => BlogPage());
      case info:
        return MaterialPageRoute(builder: (_) => InfoPage());
      case petcare:
        return MaterialPageRoute(builder: (_) => PetCarePage());
      default:
        return MaterialPageRoute(builder: (_) => SplashPage());
    }
  }
}

class InfPage {}
