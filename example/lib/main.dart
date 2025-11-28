/*
* Created by Connel Asikong on 27/11/2025
*
*/

import 'package:flutter/material.dart';
import 'package:otp_numpad/otp_numpad.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom OTP Field Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const OTPDemoPage(),
    );
  }
}

class OTPDemoPage extends StatefulWidget {
  const OTPDemoPage({super.key});

  @override
  State<OTPDemoPage> createState() => _OTPDemoPageState();
}

class _OTPDemoPageState extends State<OTPDemoPage> {
  String _selectedMode = 'Alphanumeric (Recommended)';
  bool _obscureText = true;
  int _fieldCount = 6;
  String _enteredOTP = '';

  CharacterType _getCharacterType() {
    switch (_selectedMode) {
      case 'Numbers Only':
        return CharacterType.numbersOnly;
      case 'Alphanumeric (Recommended)':
        return CharacterType.alphanumeric;
      case 'Full Characters':
        return CharacterType.full;
      default:
        return CharacterType.alphanumeric;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom OTP Field Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'OTP Configuration',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Character Type Selection
            const Text(
              'Character Type:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Numbers Only', label: Text('Numbers')),
                ButtonSegment(
                  value: 'Alphanumeric (Recommended)',
                  label: Text('Alphanumeric'),
                ),
                ButtonSegment(value: 'Full Characters', label: Text('Full')),
              ],
              selected: {_selectedMode},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _selectedMode = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 20),

            // Field Count
            Row(
              children: [
                const Text(
                  'Field Count:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Slider(
                    value: _fieldCount.toDouble(),
                    min: 4,
                    max: 8,
                    divisions: 4,
                    label: _fieldCount.toString(),
                    onChanged: (value) {
                      setState(() {
                        _fieldCount = value.toInt();
                      });
                    },
                  ),
                ),
                Text(
                  _fieldCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Obscure Text Toggle
            SwitchListTile(
              title: const Text('Hide Characters (Dots)'),
              value: _obscureText,
              onChanged: (value) {
                setState(() {
                  _obscureText = value;
                });
              },
            ),
            const SizedBox(height: 20),

            if (_enteredOTP.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Entered OTP:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _enteredOTP,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],

            const Divider(height: 20),
            const Text(
              'Enter OTP:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // OTP Field
            OtpFieldWidget(
              config: OTPConfig(
                length: _fieldCount,
                characterType: _getCharacterType(),
                obscureText: _obscureText,
                textFieldColor: Colors.grey.shade600,
                borderColor: Colors.black,
                textStyle: TextStyle(color: Colors.white),
                focusedBorderColor: Colors.grey,
                filledBorderColor: Colors.black,
              ),
              onChanged: (value) {
                setState(() {
                  _enteredOTP = value;
                });
              },
              onCompleted: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('OTP Completed: $value'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
