import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view/common/widget_extensions.dart';
import 'package:flutter_mvvm/view/page/home/home_page.dart';
import 'package:flutter_mvvm/view/viewmodel/auth_view_model.dart';
import 'package:flutter_mvvm/view/widget/error/error_overlay.dart';
import 'package:flutter_mvvm/view/widget/loading/loading_overlay.dart';

import '../../base/resource_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthViewModel viewModel = AuthViewModel();

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
        case Status.COMPLETED:
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
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: emailFieldController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email can not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter your username',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: passwordFieldController,
                  keyboardType: TextInputType.text,
                  obscureText: _passwordHidden,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password can not be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password',
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FocusManager.instance.primaryFocus
                        ?.unfocus(); // Close keyboard

                    viewModel.login(emailFieldController.text,
                        passwordFieldController.text);
                  }
                },
                child: const Text('Login'),
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
