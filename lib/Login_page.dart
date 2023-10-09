import 'package:auth2/Auth_Google.dart';
import 'package:auth2/Next_page.dart';
import 'package:auth2/RegistrationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auth2/EmailTextField.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String email = '';
  String password = '';
  bool userExist = false;
  bool passwordWrong = false;

  void emailChange(String value) {
    setState(() {
      print(value);
      email = value;
    });
  }

  void _handleSign() async {
    setState(() {
      userExist = false;
      passwordWrong = false;
    });
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      setState(() {
        userExist = true;
      });
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
      } else if (e.code == 'wrong-password') {
        setState(() {
          passwordWrong = true;
        });
      }
    }
    print(userExist);
    print(passwordWrong);
    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextPage(email: email, password: password),
      ),
    );*/
    Navigator.pop(context);
  }

  void _registr_page() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: userExist ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                width: 100,
                height: 20,
                child: Text(
                  'нет такого пользователя',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: passwordWrong ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                width: 100,
                height: 20,
                child: Text(
                  'Неверный пароль',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Icon(
              Icons.lock,
              size: 50.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Здесь можно войти',
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
              onPressed: _handleSign,
              child: Text('Вход'),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: _registr_page,
              child: Text('Нет аккаунта? Создать'),
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

class HomePage extends StatelessWidget {
  final String email;

  HomePage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добро пожаловать'),
      ),
      body: Center(
        child: Text('Email пользователя: $email'),
      ),
    );
  }
}
