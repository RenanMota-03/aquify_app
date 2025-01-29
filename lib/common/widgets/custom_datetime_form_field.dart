import 'package:aquify_app/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomDatetimeFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  const CustomDatetimeFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.validator,
    this.controller,
  });
  @override
  State<CustomDatetimeFormField> createState() =>
      _CustomDatetimeFormFieldState();
}

class _CustomDatetimeFormFieldState extends State<CustomDatetimeFormField> {
  late TextEditingController _internalController;
  TimeOfDay selectedTime = TimeOfDay(hour: 14, minute: 30);
  bool _initialized = false;
  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _internalController.text = selectedTime.format(
        context,
      ); // Agora é seguro acessar o contexto
      _initialized = true;
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        _internalController.text = selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: _internalController,
      onTap: _pickTime,
      readOnly: true,
      keyboardType: TextInputType.datetime,
      hintText: widget.hintText,
      labelText: widget.labelText,
      colorInput: AppColors.iceWhite,
      colorBorderSide: AppColors.grey,
      colorHintText: AppColors.grey,
      validator: widget.validator,
    );
  }
}
