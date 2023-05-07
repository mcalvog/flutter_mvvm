import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm/model/artist.dart';
import 'package:flutter_mvvm/presentation/view/about/about_page.dart';
import 'package:flutter_mvvm/presentation/view/artist/artist_detail_page.dart';
import 'package:flutter_mvvm/presentation/view/artist/artist_list_page.dart';
import 'package:flutter_mvvm/presentation/view/auth/login_page.dart';
import 'package:flutter_mvvm/presentation/view/home/home_page.dart';
import 'package:flutter_mvvm/presentation/view/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRoutes {
  // Route names
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String artistsRoute = '/artists';
  static const String artistDetailRoute = '/artists/detail';
  static const String aboutRoute = '/about';
}

// Nav keys
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _bottomNavigatorKey =
    GlobalKey<NavigatorState>();

final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: NavigationRoutes.initialRoute,
    routes: [
      GoRoute(
          path: NavigationRoutes.initialRoute,
          builder: (context, state) => const SplashPage()),
      ShellRoute(
          navigatorKey: _bottomNavigatorKey,
          builder: (context, state, child) => HomePage(child: child),
          routes: [
            GoRoute(
                path: NavigationRoutes.artistsRoute,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ArtistListPage())),
            GoRoute(
                path: NavigationRoutes.aboutRoute,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: AboutPage())),
          ]),
      GoRoute(
          path: NavigationRoutes.loginRoute,
          builder: (context, state) => const LoginPage()),
      GoRoute(
          path: NavigationRoutes.artistDetailRoute,
          builder: (context, state) {
            final artist = state.extra as Artist;
            return ArtistDetailPage(artist: artist);
          }),
    ]);
