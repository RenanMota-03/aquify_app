import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:aquify_app/common/constants/app_text_styles.dart';
import 'package:aquify_app/common/widgets/custom_background_container.dart';
import 'package:aquify_app/common/widgets/custom_datetime_form_field.dart';
import 'package:aquify_app/common/widgets/custom_text_form_field.dart';
import 'package:aquify_app/common/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class NewGoalsPage extends StatefulWidget {
  const NewGoalsPage({super.key});

  @override
  State<NewGoalsPage> createState() => _NewGoalsPageState();
}

class _NewGoalsPageState extends State<NewGoalsPage> {
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
                child: Column(
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      hintText: "Quantidade de Litros p/dia",
                      labelText: "Quantidade de Agua",
                      colorInput: AppColors.iceWhite,
                      colorBorderSide: AppColors.grey,
                      colorHintText: AppColors.grey,
                    ),
                    CustomDatetimeFormField(
                      labelText: "Horario de Inicio",
                      hintText: "Quando o seu dia começa",
                    ),
                    CustomDatetimeFormField(
                      labelText: "Horario de Termino",
                      hintText: "Quando o seu dia termina",
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      labelText: "Quantidade de Agua",
                      hintText: "Quanto de Agua a cada intervalo, em ml",
                      colorInput: AppColors.iceWhite,
                      colorBorderSide: AppColors.grey,
                      colorHintText: AppColors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: PrimaryButton(text: "Criar Meta"),
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
