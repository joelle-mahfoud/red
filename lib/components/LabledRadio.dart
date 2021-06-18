import 'package:flutter/material.dart';

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    this.label,
    this.contentPadding,
    this.groupValue,
    this.value,
    this.onChanged,
    this.fontSize,
    this.activeColor,
    this.textColor,
    this.gap = 4.0,
    this.bold = false,
  });

  final String label;
  final EdgeInsets contentPadding;
  final String groupValue;
  final String value;
  final Function onChanged;
  final Color activeColor;
  final double fontSize;
  final Color textColor;
  final double gap;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) onChanged(value);
      },
      child: Padding(
        padding: contentPadding ?? const EdgeInsets.all(0),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: 18,
              height: 18,
              child: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: activeColor,
                visualDensity: VisualDensity.compact,
                groupValue: groupValue,
                value: value,
                onChanged: (newValue) {
                  onChanged(newValue);
                },
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
