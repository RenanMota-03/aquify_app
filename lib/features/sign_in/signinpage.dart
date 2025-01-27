import 'dart:developer';

import 'package:aquify_app/common/utils/validator.dart';
import 'package:aquify_app/common/widgets/custom_text_form_field.dart';
import 'package:aquify_app/common/widgets/password_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/constants/routes.dart';
import '../../common/widgets/custom_bottom_sheet.dart';
import '../../common/widgets/custom_circular_progress_indicator.dart';
import '../../common/widgets/multi_text_button.dart';
import '../../common/widgets/primary_button.dart';
import '../../locator.dart';
import 'sign_in_controller.dart';
import 'sign_in_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = locator.get<SignInController>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is SignInStateLoading) {
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }
      if (_controller.state is SignInStateSuccess) {
        Navigator.pop(context);
        Navigator.pushNamed(context, NamedRoute.home);
      }
      if (_controller.state is SignInStateError) {
        final error = _controller.state as SignInStateError;
        Navigator.pop(context);
        customModalBottomSheet(
          context,
          content: error.message,
          buttonText: "Tentar novamente",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: ListView(
          children: [
            Image.asset("assets/images/signin_image.png"),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _emailController,
                    labelText: "Email",
                    hintText: "email@example.com",
                    validator: Validator.validateEmail,
                  ),
                  PasswordFormField(
                    controller: _passwordController,
                    labelText: "Senha",
                    hintText: "*" * 8,
                    helperText:
                        "Deve ter pelo menos 8 caracteres, 1 letra maiúscula e 1 número.",
                    validator: Validator.validatePassword,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                right: 32.0,
                top: 16.0,
                bottom: 4.0,
              ),
              child: PrimaryButton(
                text: 'Logar',
                onPressed: () {
                  final valid =
                      _formKey.currentState != null &&
                      _formKey.currentState!.validate();
                  if (valid) {
                    _controller.signIn(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  } else {
                    log('Login errado');
                  }
                },
              ),
            ),
            MultiTextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, NamedRoute.signUp);
              },
              children: [
                Text(
                  'Não possui conta ainda? ',
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                Text(
                  'Clique aqui',
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.blueTwo,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
