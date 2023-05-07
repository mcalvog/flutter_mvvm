import 'package:flutter/material.dart';
import 'package:flutter_mvvm/presentation/common/localization/localization.dart';
import 'package:flutter_mvvm/presentation/navigation/navigation_routes.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: _calculateSelectedIndex(context),
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            return context.go(NavigationRoutes.artistsRoute);
          case 1:
            return context.go(NavigationRoutes.aboutRoute);
          default:
            return context.go(NavigationRoutes.artistsRoute);
        }
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          label: Localization.of(context).string('home_title'),
        ),
        NavigationDestination(
          icon: const Icon(Icons.info_outlined),
          label: Localization.of(context).string('about_title'),
        ),
      ],
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;

    switch (location) {
      case NavigationRoutes.artistsRoute:
        return 0;
      case NavigationRoutes.aboutRoute:
        return 1;
      default:
        return 0;
    }
  }
}
