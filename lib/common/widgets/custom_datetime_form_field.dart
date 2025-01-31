import 'package:aquify_app/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime? selectedDateTime;
  final DateFormat timeFormat = DateFormat("HH:mm");

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
    selectedDateTime = DateTime.now();
    _updateTextField();
  }

  void _updateTextField() {
    _internalController.text = timeFormat.format(selectedDateTime!);
  }

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime!),
    );

    if (pickedTime != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime!.year,
          selectedDateTime!.month,
          selectedDateTime!.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _updateTextField();
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
