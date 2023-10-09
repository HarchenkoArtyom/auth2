import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  var user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
        actions: [
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout_sharp))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Email: ' + user.email!),
          ],
        ),
      ),
    );
  }
}
