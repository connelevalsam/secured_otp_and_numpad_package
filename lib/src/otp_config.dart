/*
* Created by Connel Asikong on 27/11/2025
*
*/

import 'package:flutter/material.dart';

enum CharacterType { numbersOnly, alphanumeric, full }

class OTPConfig {
  /// Number of OTP fields (4-8)
  final int length;

  /// Type of characters allowed
  final CharacterType characterType;

  /// Whether to show dots instead of actual characters
  final bool obscureText;

  /// Width of each field
  final double fieldWidth;

  /// Height of each field
  final double fieldHeight;

  /// Spacing between fields
  final double fieldSpacing;

  /// Border radius of fields
  final double borderRadius;

  /// Border color
  final Color borderColor;

  /// OTP field background color
  final Color textFieldColor;

  /// Focused border color
  final Color focusedBorderColor;

  /// Filled border color
  final Color filledBorderColor;

  /// Text style
  final TextStyle textStyle;

  /// Keyboard height
  final double keyboardHeight;

  /// Keyboard background color
  final Color keyboardBackgroundColor;

  /// Keyboard key background color
  final Color keyBackgroundColor;

  /// Keyboard key text color
  final Color keyTextColor;

  /// Delete key background color
  final Color deleteKeyColor;

  /// Delete key text color
  final Color deleteKeyTextColor;

  const OTPConfig({
    this.length = 4,
    this.characterType = CharacterType.alphanumeric,
    this.obscureText = false,
    this.fieldWidth = 50.0,
    this.fieldHeight = 60.0,
    this.fieldSpacing = 10.0,
    this.borderRadius = 12.0,
    this.borderColor = const Color(0xFFE0E0E0),
    this.textFieldColor = const Color(0xFFFFFFFF),
    this.focusedBorderColor = const Color(0xFF6366F1),
    this.filledBorderColor = const Color(0xFF10B981),
    this.textStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1F2937),
    ),
    this.keyboardHeight = 280.0,
    this.keyboardBackgroundColor = const Color(0xFFF3F4F6),
    this.keyBackgroundColor = Colors.white,
    this.keyTextColor = const Color(0xFF1F2937),
    this.deleteKeyColor = const Color(0xFFEF4444),
    this.deleteKeyTextColor = Colors.white,
  }) : assert(length >= 4 && length <= 8, 'Length must be between 4 and 8');
}
