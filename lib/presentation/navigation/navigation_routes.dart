import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm/presentation/view/artist/artist_detail_page.dart';
import 'package:flutter_mvvm/presentation/view/auth/login_page.dart';
import 'package:flutter_mvvm/presentation/view/home/home_page.dart';
import 'package:flutter_mvvm/presentation/view/splash/splash_page.dart';

class NavigationRoutes {
  static const String initialRoute = '/';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String artistDetailRoute = '/artists/detail';

  static Map<String, WidgetBuilder> get routes {
    return {
      initialRoute: (context) => const SplashPage(),
      homeRoute: (context) => const HomePage(),
      loginRoute: (context) => const LoginPage(),
      artistDetailRoute: (context) => const ArtistDetailPage(),
    };
  }
}
