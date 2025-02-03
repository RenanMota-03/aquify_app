import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'dropdown_widget.dart';
import 'primary_button.dart';

Future<void> customDropdownBottomSheet(
  BuildContext context, {
  required String content,
  required String buttonText,
  required TextEditingController controller,
  required String hintText,
  required List<String> list,

  VoidCallback? onPressed,
}) {
  return showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(38.0),
        topRight: Radius.circular(38.0),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(38.0),
            topRight: Radius.circular(38.0),
          ),
        ),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Text(
                content,
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.blueOne,
                ),
              ),
            ),
            DropdownMenuWidget(
              list: list,
              controller: controller,
              hintText: hintText,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 32.0,
              ),
              child: PrimaryButton(
                text: buttonText,
                onPressed: onPressed ?? () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      );
    },
  );
}
