import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;
  final Color activeColor;
  final Color checkColor;

  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.activeColor = Colors.blue,
    this.checkColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          checkColor: checkColor,
          activeColor: activeColor,
          onChanged: onChanged,
        ),
        TextWidget(text: label,fontSize: 15,),
      ],
    );
  }
}
