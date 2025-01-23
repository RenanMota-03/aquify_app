import 'dart:developer';

import 'package:aquify_app/common/utils/validator.dart';
import 'package:aquify_app/common/widgets/custom_text_form_field.dart';
import 'package:aquify_app/common/widgets/password_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/constants/routes.dart';
import '../../common/utils/uppercase_text_formatter.dart';
import '../../common/widgets/multi_text_button.dart';
import '../../common/widgets/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset("assets/images/signup_image.png"),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: "Nome Completo",
                  hintText: "NOME COMPLETO",
                  inputFormatters: [UpperCaseTextInputFormatter()],
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
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
                PasswordFormField(
                  labelText: "Confirmar Senha",
                  hintText: "*" * 8,
                  validator:
                      (value) => Validator.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
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
              text: 'Cadastro',
              onPressed: () {
                final valid =
                    _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  log("continuar logica de login");
                } else {
                  log("erro de login");
                }
              },
            ),
          ),
          MultiTextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, NamedRoute.signIn);
            },
            children: [
              Text(
                'Já possui uma conta? ',
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
