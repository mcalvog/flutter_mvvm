import 'package:flutter/material.dart';
import 'package:flutter_mvvm/presentation/common/navigation/navigation_extensions.dart';
import 'package:flutter_mvvm/presentation/view/home/home_page.dart';
import 'package:flutter_mvvm/presentation/view/auth/viewmodel/auth_view_model.dart';
import 'package:flutter_mvvm/presentation/common/widget/error/error_overlay.dart';
import 'package:flutter_mvvm/presentation/common/widget/loading/loading_overlay.dart';

import '../../common/base/resource_state.dart';
import '../../common/localization/localization.dart';
import '../../common/resources/app_dimens.dart';
import '../../../di/app_modules.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final viewModel = inject<AuthViewModel>();

  bool _passwordHidden = true;
  final _formKey = GlobalKey<FormState>();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    viewModel.loginState.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.of(context).show();
          break;
        case Status.SUCCESS:
          LoadingOverlay.of(context).hide();
          context.navigateReplacing(const HomePage());
          break;
        case Status.ERROR:
          LoadingOverlay.of(context).hide();
          ErrorOverlay.of(context).show(state.error);
          break;
        default:
          LoadingOverlay.of(context).hide();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(Localization.of(context).string('sign_in')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: AppDimens.bigMargin),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: emailFieldController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Localization.of(context)
                          .string('error_empty_field');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText:
                        Localization.of(context).string('sign_in_username'),
                    hintText: Localization.of(context)
                        .string('sign_in_username_hint'),
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.mediumMargin),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: passwordFieldController,
                  keyboardType: TextInputType.text,
                  obscureText: _passwordHidden,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      Localization.of(context).string('error_empty_field');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText:
                        Localization.of(context).string('sign_in_password'),
                    hintText: Localization.of(context)
                        .string('sign_in_password_hint'),
                    suffixIcon: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _passwordHidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.semiBigMargin),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FocusManager.instance.primaryFocus
                        ?.unfocus(); // Close keyboard

                    viewModel.login(emailFieldController.text,
                        passwordFieldController.text);
                  }
                },
                child: Text(Localization.of(context).string('sign_in')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose(); // Avoid memory leaks
  }

  void _togglePasswordView() {
    setState(() {
      _passwordHidden = !_passwordHidden;
    });
  }
}
