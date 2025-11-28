/*
* Created by Connel Asikong on 27/11/2025
*
*/

import 'package:flutter/material.dart';

import 'otp_config.dart';

class Numpad extends StatelessWidget {
  final CharacterType characterType;
  final Function(String) onKeyTap;
  final VoidCallback onDeleteTap;
  final double height;
  final Color backgroundColor;
  final Color keyBackgroundColor;
  final Color keyTextColor;
  final Color deleteKeyColor;
  final Color deleteKeyTextColor;

  const Numpad({
    super.key,
    required this.characterType,
    required this.onKeyTap,
    required this.onDeleteTap,
    this.height = 280.0,
    this.backgroundColor = const Color(0xFFF3F4F6),
    this.keyBackgroundColor = Colors.white,
    this.keyTextColor = const Color(0xFF1F2937),
    this.deleteKeyColor = const Color(0xFFEF4444),
    this.deleteKeyTextColor = Colors.white,
  });

  List<List<String>> _getKeyLayout() {
    if (characterType == CharacterType.numbersOnly) {
      return [
        ['1', '2', '3'],
        ['4', '5', '6'],
        ['7', '8', '9'],
        ['', '0', 'delete'],
      ];
    } else if (characterType == CharacterType.alphanumeric) {
      return [
        ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
        ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
        ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
        ['z', 'x', 'c', 'v', 'b', 'n', 'm', 'delete'],
      ];
    } else {
      return [
        ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
        ['!', '@', '#', '\$', '%', '^', '&', '*', '(', ')'],
        ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
        ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
        ['z', 'x', 'c', 'v', 'b', 'n', 'm'],
        [';', '[', ']', "'", ',', '.', '/', 'delete'],
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = _getKeyLayout();

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: layout
                    .map((row) => Expanded(child: _buildKeyRow(row)))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((key) => Expanded(child: _buildKey(key))).toList(),
    );
  }

  Widget _buildKey(String key) {
    if (key.isEmpty) {
      return const SizedBox(width: 50, height: 50);
    }

    final isDelete = key == 'delete';
    final keyWidth = characterType == CharacterType.numbersOnly
        ? 80.0
        : (isDelete ? 70.0 : 35.0);

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        color: isDelete ? deleteKeyColor : keyBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        elevation: 1,
        child: InkWell(
          onTap: () {
            if (isDelete) {
              onDeleteTap();
            } else {
              onKeyTap(key);
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: keyWidth,
            height: characterType == CharacterType.numbersOnly ? 50 : 42,
            alignment: Alignment.center,
            child: isDelete
                ? Icon(
                    Icons.backspace_outlined,
                    color: deleteKeyTextColor,
                    size: 20,
                  )
                : Text(
                    key.toUpperCase(),
                    style: TextStyle(
                      fontSize: characterType == CharacterType.numbersOnly
                          ? 24
                          : 16,
                      fontWeight: FontWeight.w600,
                      color: keyTextColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
