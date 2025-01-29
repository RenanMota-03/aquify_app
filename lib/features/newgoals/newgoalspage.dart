import 'dart:developer';

import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:aquify_app/common/utils/validator.dart';
import 'package:aquify_app/common/widgets/custom_background_container.dart';
import 'package:aquify_app/common/widgets/custom_datetime_form_field.dart';
import 'package:aquify_app/common/widgets/custom_text_form_field.dart';
import 'package:aquify_app/common/widgets/primary_button.dart';
import 'package:aquify_app/features/newgoals/newgoals_controller.dart';
import 'package:flutter/material.dart';

import '../../common/constants/routes.dart';
import '../../common/widgets/custom_bottom_sheet.dart';
import '../../common/widgets/custom_circular_progress_indicator.dart';
import '../../locator.dart';
import 'newgoals_state.dart';

class NewGoalsPage extends StatefulWidget {
  const NewGoalsPage({super.key});

  @override
  State<NewGoalsPage> createState() => _NewGoalsPageState();
}

class _NewGoalsPageState extends State<NewGoalsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _metaLController = TextEditingController();
  final TextEditingController _dateBeginController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();
  final TextEditingController _quantidadeMlController = TextEditingController();
  final _controller = locator.get<NewGoalsController>();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _metaLController.dispose();
    _dateBeginController.dispose();
    _dateEndController.dispose();
    _quantidadeMlController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is NewGoalsStateLoading) {
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }
      if (_controller.state is NewGoalsStateSuccess) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, NamedRoute.home);
      }
      if (_controller.state is NewGoalsStateError) {
        final error = _controller.state as NewGoalsStateError;
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
      body: CustomBackgroundContainer(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 20),
                  child: Text(
                    "Nova Meta",
                    style: AppTextStyles.mediumText.copyWith(
                      color: AppColors.iceWhite,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      hintText: "Quantidade de Litros p/dia(em numeros)",
                      labelText: "Meta Diaria",
                      colorInput: AppColors.iceWhite,
                      colorBorderSide: AppColors.grey,
                      colorHintText: AppColors.grey,
                      validator: Validator.validateIsEmpty,
                      controller: _metaLController,
                    ),
                    CustomDatetimeFormField(
                      labelText: "Horario de Inicio",
                      hintText: "Quando o seu dia começa",
                      validator: Validator.validateIsEmpty,
                      controller: _dateBeginController,
                    ),
                    CustomDatetimeFormField(
                      labelText: "Horario de Termino",
                      hintText: "Quando o seu dia termina",
                      validator: Validator.validateIsEmpty,
                      controller: _dateEndController,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      labelText: "Quantidade de Agua por Intervalo",
                      hintText: "Quanto de Agua a cada intervalo, em ml",
                      colorInput: AppColors.iceWhite,
                      colorBorderSide: AppColors.grey,
                      colorHintText: AppColors.grey,
                      validator: Validator.validateIsEmpty,
                      controller: _quantidadeMlController,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: PrimaryButton(
                        text: "Criar Meta",
                        onPressed: () {
                          final valid =
                              _formKey.currentState != null &&
                              _formKey.currentState!.validate();
                          if (valid) {
                            _controller.newGoals(
                              id: _dateBeginController.hashCode.toString(),
                              quantidadeMl: _quantidadeMlController.text,
                              meta: _metaLController.text,
                              dateBegin: _dateBeginController.text,
                              dateEnd: _dateEndController.text,
                            );
                          } else {
                            log("erro de login");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
