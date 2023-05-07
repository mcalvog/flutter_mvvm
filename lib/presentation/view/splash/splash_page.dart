import 'package:flutter/material.dart';
import 'package:flutter_mvvm/presentation/view/auth/viewmodel/auth_view_model.dart';
import 'package:go_router/go_router.dart';

import '../../../di/app_modules.dart';
import '../../navigation/navigation_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final viewModel = inject<AuthViewModel>();

  @override
  void initState() {
    super.initState();

    viewModel.authenticatedState.listen((state) {
      switch (state) {
        case true:
          context.go(NavigationRoutes.artistsRoute);
          break;
        case false:
          context.go(NavigationRoutes.loginRoute);
          break;
      }
    });

    viewModel.isAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(), // Empty view
    );
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose(); // Avoid memory leaks
  }
}
