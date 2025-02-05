import 'package:aquify_app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LabeledCheckboxWidget extends StatelessWidget {
  const LabeledCheckboxWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final Widget label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            shape: CircleBorder(),
            activeColor: AppColors.blueTwo,
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue!);
            },
          ),
          SizedBox(child: label),
        ],
      ),
    );
  }
}
