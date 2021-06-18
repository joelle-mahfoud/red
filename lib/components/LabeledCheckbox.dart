import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.contentPadding,
    this.value,
    this.onTap,
    this.activeColor,
    this.textColor,
    this.fontSize,
    this.gap = 4.0,
    this.bold = false,
    this.radius = 0,
  });

  final String label;
  final EdgeInsets contentPadding;
  final bool value;
  final Function onTap;
  final Color activeColor;
  final double fontSize;
  final Color textColor;
  final double gap;
  final bool bold;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(!value),
      child: Padding(
        padding: contentPadding ?? const EdgeInsets.all(0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(radius))),
              width: 18,
              height: 18,
              child: Checkbox(
                tristate: false,
                checkColor: activeColor, // color of tick Mark
                activeColor: Colors.transparent,
                value: value,
                visualDensity: VisualDensity.compact,
                onChanged: (val) => onTap(val),
              ),
            ),
            SizedBox(
              width: gap,
            ), // you can control gap between checkbox and label with this field
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
