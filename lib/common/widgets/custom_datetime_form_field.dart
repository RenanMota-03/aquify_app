import 'package:aquify_app/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomDatetimeFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  const CustomDatetimeFormField({super.key, this.labelText, this.hintText});
  @override
  State<CustomDatetimeFormField> createState() =>
      _CustomDatetimeFormFieldState();
}

class _CustomDatetimeFormFieldState extends State<CustomDatetimeFormField> {
  TimeOfDay selectedTime = TimeOfDay(hour: 14, minute: 30);
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: TextEditingController(text: selectedTime.format(context)),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: selectedTime, // Define a hora inicial
        );
        if (pickedTime != null && pickedTime != selectedTime) {
          setState(() {
            selectedTime = pickedTime;
          });
        }
      },
      readOnly: true,
      keyboardType: TextInputType.datetime,
      hintText: widget.hintText,
      labelText: widget.labelText,
      colorInput: AppColors.iceWhite,
      colorBorderSide: AppColors.grey,
      colorHintText: AppColors.grey,
    );
  }
}
