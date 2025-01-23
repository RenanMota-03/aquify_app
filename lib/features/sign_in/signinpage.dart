import 'package:aquify_app/common/utils/validator.dart';
import 'package:aquify_app/common/widgets/custom_text_form_field.dart';
import 'package:aquify_app/common/widgets/password_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/constants/routes.dart';
import '../../common/widgets/multi_text_button.dart';
import '../../common/widgets/primary_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/signin_image.png"),
          Form(
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: "Email",
                  hintText: "email@example.com",
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
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
            child: PrimaryButton(text: 'Logar', onPressed: () {}),
          ),
          MultiTextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, NamedRoute.signUp);
            },
            children: [
              Text(
                'Não possui conta ainda? ',
                style: AppTextStyles.smallText.copyWith(color: AppColors.grey),
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
    );
  }
}
