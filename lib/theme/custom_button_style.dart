import 'package:flutter/material.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Text button style with border customization
  static ButtonStyle get none => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        side: BorderSide(
          color: Colors.transparent, // No visible border
        ),
      );
}
