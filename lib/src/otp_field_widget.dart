/*
* Created by Connel Asikong on 27/11/2025
*
*/

import 'package:flutter/material.dart';

import 'numpad.dart';
import 'otp_config.dart';

class OtpFieldWidget extends StatefulWidget {
  final OTPConfig config;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;

  const OtpFieldWidget({
    super.key,
    this.config = const OTPConfig(),
    this.onCompleted,
    this.onChanged,
  });

  @override
  State<OtpFieldWidget> createState() => _OtpFieldWidgetState();
}

class _OtpFieldWidgetState extends State<OtpFieldWidget> {
  late List<String> _otpValues;
  late List<FocusNode> _focusNodes;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _otpValues = List.filled(widget.config.length, '');
    _focusNodes = List.generate(widget.config.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleKeyTap(String key) {
    if (_currentIndex < widget.config.length) {
      setState(() {
        _otpValues[_currentIndex] = key;
        if (_currentIndex < widget.config.length - 1) {
          _currentIndex++;
        }
      });

      final otp = _otpValues.join();
      widget.onChanged?.call(otp);

      if (_currentIndex == widget.config.length - 1 &&
          _otpValues.every((element) => element.isNotEmpty)) {
        widget.onCompleted?.call(otp);
      }
    }
  }

  void _handleDelete() {
    if (_currentIndex >= 0) {
      setState(() {
        if (_otpValues[_currentIndex].isEmpty && _currentIndex > 0) {
          _currentIndex--;
        }
        _otpValues[_currentIndex] = '';
      });

      widget.onChanged?.call(_otpValues.join());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.config.length,
            (index) => _buildOTPField(index),
          ),
        ),
        const SizedBox(height: 20),
        Numpad(
          characterType: widget.config.characterType,
          onKeyTap: _handleKeyTap,
          onDeleteTap: _handleDelete,
          height: widget.config.keyboardHeight,
          backgroundColor: widget.config.keyboardBackgroundColor,
          keyBackgroundColor: widget.config.keyBackgroundColor,
          keyTextColor: widget.config.keyTextColor,
          deleteKeyColor: widget.config.deleteKeyColor,
          deleteKeyTextColor: widget.config.deleteKeyTextColor,
        ),
      ],
    );
  }

  Widget _buildOTPField(int index) {
    final isFilled = _otpValues[index].isNotEmpty;
    final isFocused = _currentIndex == index;

    Color borderColor = widget.config.borderColor;
    if (isFilled) {
      borderColor = widget.config.filledBorderColor;
    } else if (isFocused) {
      borderColor = widget.config.focusedBorderColor;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.config.fieldSpacing / 2),
      child: Container(
        width: widget.config.fieldWidth,
        height: widget.config.fieldHeight,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(widget.config.borderRadius),
          color: widget.config.textFieldColor,
        ),
        alignment: Alignment.center,
        child: Text(
          widget.config.obscureText && _otpValues[index].isNotEmpty
              ? '●'
              : _otpValues[index].toUpperCase(),
          style: widget.config.textStyle,
        ),
      ),
    );
  }
}
