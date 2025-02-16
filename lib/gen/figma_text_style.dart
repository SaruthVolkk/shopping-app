import 'package:flutter/material.dart';
import 'package:shopping_app/gen/figma_color.dart';

class FigmaTextStyles {
  FigmaTextStyles._();

  static const m3Medium = TextStyle(
      color: FigmaColors.primaryText,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.15,
      height: 24 / 16);

  static const m3ExtraLarge = TextStyle(
      color: FigmaColors.primaryText,
      fontSize: 32,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
      height: 40 / 32);

  static const m3Large = TextStyle(
      color: FigmaColors.primaryPurple,
      fontSize: 22,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
      height: 28 / 22);

  static const m3Small = TextStyle(
      color: FigmaColors.secondaryText,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.1,
      height: 20 / 14);

  static const button = TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.1,
      height: 20 / 14);
}
