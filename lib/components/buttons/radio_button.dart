import 'package:flutter/material.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class RadioButton extends StatelessWidget {
  const RadioButton(
      {super.key,
      required this.function,
      required this.text,
      required this.type});

  final String text;
  final String type;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      GestureDetector(
          onTap: function,
          child: Image.asset(
              type == text ? 'assets/selected.png' : 'assets/unselected.png',
              width: 18.0,
              height: 18.0)),
      SizedBox(width: phoneSize.width * 0.025),
      Text(text, style: subTitleStyle),
    ]);
  }
}
