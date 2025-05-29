import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  final List<String> items;
  final String hint;
  final Function(String) onChanged;

  const DropdownButtonWidget({
    Key? key,
    required this.items,
    required this.onChanged,
    this.hint = 'Select an item',
  }) : super(key: key);

  @override
  _DropdownButtonWidgetState createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: materialColor, width: 1.5),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: TextWidget(text: widget.hint),
          isExpanded: true,
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
            widget.onChanged(newValue!);
          },
        ),
      ),
    );
  }
}
