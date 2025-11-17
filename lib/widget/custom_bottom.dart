import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import '../utils/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle textFont;
  final Color color;
  final Color borderColor;
  void Function()? onTap;
  final double width;
  final double height;
  final Widget? icon;

   CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.borderColor,
    required this.width,
    required this.height,
    this.onTap,
    required this.textFont,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: textFont,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
