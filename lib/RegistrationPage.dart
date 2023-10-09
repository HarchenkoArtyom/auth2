import 'package:auth2/Auth_Google.dart';
import 'package:auth2/EmailTextField.dart';
import 'package:auth2/Login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPage createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String email = '';
  String password = '';

  void emailChange(String value) {
    setState(() {
      print(value);
      email = value;
    });
  }

  void _createUser() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
    Navigator.pop(context);
  }

  void _login_page() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void _handleRegistration() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              size: 50.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Здесь можно зарегистрироваться',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            EmailTextField(emailChange: emailChange),
            SizedBox(height: 10.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Пароль',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _createUser,
              child: Text('Зарегистрироваться'),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: _login_page,
              child: Text('Уже есть аккаунт? Войти'),
            ),
            SizedBox(height: 10.0),
            OutlinedButton.icon(
              onPressed: () => AuthService().signInGoogle(),
              icon: Icon(Icons.door_back_door_outlined),
              label: Text('Войти через Google'),
            ),
          ],
        ),
      ),
    );
  }
}
