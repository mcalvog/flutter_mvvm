import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view/common/localization/localization.dart';
import 'package:flutter_mvvm/view/common/navigation/navigation_extensions.dart';
import 'package:flutter_mvvm/view/common/resources/app_dimens.dart';
import 'package:flutter_mvvm/view/page/splash/splash_page.dart';
import 'package:flutter_mvvm/view/page/auth/viewmodel/auth_view_model.dart';

import '../../di/app_modules.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with AutomaticKeepAliveClientMixin {
  final viewModel = inject<AuthViewModel>();

  @override
  void initState() {
    super.initState();

    viewModel.signOutState.listen((state) {
      switch (state) {
        case true:
          context.navigateReplacing(const SplashPage());
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDimens.mediumMargin),
          child: Text(
              Localization.of(context).string('about_description',
                  params: ['Dart', 'Clean Architecture']),
              textAlign: TextAlign.center),
        ),
        ElevatedButton(
          onPressed: () {
            viewModel.signOut();
          },
          child: Text(Localization.of(context).string('sign_out')),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose(); // Avoid memory leaks
  }

  @override
  bool get wantKeepAlive => true;
}
