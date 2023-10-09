import 'package:flutter/material.dart';

class EmailTextField extends StatefulWidget {
  late Function emailChange;
  EmailTextField({required this.emailChange});
  @override
  _EmailTextFieldState createState() =>
      _EmailTextFieldState(emailChange: emailChange);
}

class _EmailTextFieldState extends State<EmailTextField> {
  final _emailController = TextEditingController();
  bool _isValid = true;
  late Function emailChange;
  _EmailTextFieldState({required this.emailChange});

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: _isValid ? null : 'Некорректный email',
      ),
      onChanged: (value) {
        setState(() {
          _isValid = _validateEmail(value);
          if (_isValid) {
            emailChange(value);
          } else if (_isValid) {
            emailChange('');
          }
        });
      },
    );
  }

  bool _validateEmail(String value) {
    print(value);
    // Регулярное выражение для проверки валидности email
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(value);
  }
}
