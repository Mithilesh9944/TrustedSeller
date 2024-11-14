
import 'package:flutter/material.dart';
import 'package:flutter_project/Util/UtilPages.dart';

class PassphrasePasswordField extends StatefulWidget {
  const PassphrasePasswordField({super.key});
  static final TextEditingController _passwordController = TextEditingController();
  @override
  _PassphrasePasswordFieldState createState() =>
      _PassphrasePasswordFieldState();

  static TextEditingController get passwordController => _passwordController;
}

class _PassphrasePasswordFieldState extends State<PassphrasePasswordField> {

  String _passwordStrength = '';

  //Function to evaluate the strength of passphrase

  void _checkPasswordStrength(String password) {
    setState(() {
      if (password.length >= 10 &&
          RegExp(r'[A-Z]').hasMatch(password) &&
          RegExp(r'[a-z]').hasMatch(password) &&
          RegExp(r'[0-9]').hasMatch(password) &&
          RegExp(r'[@#]').hasMatch(password)) {
        _passwordStrength = 'Strong';
      } else if (password.length >= 6 &&
          RegExp(r'[A-Z]').hasMatch(password) &&
          RegExp(r'[a-z]').hasMatch(password) &&
          RegExp(r'[0-9]').hasMatch(password) &&
          RegExp(r'[@#]').hasMatch(password)) {
        _passwordStrength = 'Moderate';
      } else {
        _passwordStrength = 'Weak';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: PassphrasePasswordField._passwordController,
          obscureText: true,
          onChanged: (value) => _checkPasswordStrength(value),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: UtilitiesPages.BOX_VERTICAL_SIZE,
                  horizontal: UtilitiesPages.BOX_HORIZONTAL_SIZE),
              fillColor: Colors.white,
              filled: true,
              hintText: 'Create password',
              hintStyle: TextStyle(
                fontSize: UtilitiesPages.BOX_TEXT_FONT_SIZE,
              ),
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(UtilitiesPages.BOX_BORDER_RADIUS))),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Password Strength : $_passwordStrength',
          style: TextStyle(
            color: _passwordStrength == 'Strong'
                ? Colors.green
                : _passwordStrength == 'Moderate'
                    ? Colors.orange
                    : Colors.red,
            fontSize: UtilitiesPages.BOX_TEXT_FONT_SIZE,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    //_passwordController.dispose();
    super.dispose();
  }
}