import 'package:flutter/material.dart';
import 'package:shopping_app/gen/figma_color.dart';
import 'package:shopping_app/gen/figma_text_style.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.borderRadius = 100.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? FigmaColors.primaryPurple;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: textStyle ?? FigmaTextStyles.button,
      ),
    );
  }
}
