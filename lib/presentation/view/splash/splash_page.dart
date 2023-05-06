import 'package:flutter/material.dart';
import 'package:flutter_mvvm/presentation/common/navigation/navigation_extensions.dart';
import 'package:flutter_mvvm/presentation/view/auth/login_page.dart';
import 'package:flutter_mvvm/presentation/view/home/home_page.dart';
import 'package:flutter_mvvm/presentation/view/auth/viewmodel/auth_view_model.dart';

import '../../../di/app_modules.dart';

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
          context.navigateReplacing(const HomePage());
          break;
        case false:
          context.navigateReplacing(const LoginPage());
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
