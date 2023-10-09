import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      // Действия после успешного входа через Google
    } catch (error) {
      print('Ошибка входа через Google: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Вход через Google'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Войти через Google'),
              onPressed: _handleSignIn,
            ),
            SizedBox(height: 20),
            Text('Почта пользователя: $userEmail'),
          ],
        ),
      ),
    );
  }
}
