import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mvvm/presentation/common/localization/localization.dart';
import 'package:flutter_mvvm/presentation/common/resources/app_styles.dart';
import 'package:flutter_mvvm/presentation/di/app_modules.dart';
import 'package:flutter_mvvm/presentation/view/splash/splash_page.dart';

void main() {
  AppModules().setup(); // Setup dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM',
      theme: AppStyles.appTheme,
      darkTheme: AppStyles.appDarkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        Localization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
