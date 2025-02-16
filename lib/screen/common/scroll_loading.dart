import 'package:flutter/material.dart';
import 'package:shopping_app/gen/figma_color.dart';
import 'package:shopping_app/gen/figma_text_style.dart';

class ScrollLoading extends StatelessWidget {
  const ScrollLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(FigmaColors.primaryPurple),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Loading...',
            style: FigmaTextStyles.m3Small.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
