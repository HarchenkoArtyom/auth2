import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'firebase_options.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class AuthService {
  signInGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn(
      scopes: [
        'email',
        'openid',
        'https://www.googleapis.com/auth/contacts.readonly',
        "https://www.googleapis.com/auth/userinfo.profile"
      ],
    ).signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    String? token = gAuth.accessToken;
    /*
    String email = '2';
    final url = Uri.parse('http://localhost:8080/login');
    final response = await http.post(
      url,
      body: {
        'accessToken': gAuth.accessToken,
        'idToken': gAuth.idToken,
        'email': email,
      },
    );
    if (response.statusCode == 200) {
      // Parse the response body to get the credential
      print('response.body${response.body}');
      final f = AuthCredential(
        providerId: 'google.com',
        signInMethod: 'google.com',
        token: null,
        accessToken: gAuth.accessToken);
      final res = FirebaseAuth.instance.signInWithCredential(f);
      return await res;
    } else {
      print('response.body${response.body}');
    } String? token = gAuth.accessToken;*/

    logger.d("${gAuth.idToken}");
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    print('res.toString() ' +
        GoogleAuthProvider.credential(
                accessToken: gAuth.accessToken, idToken: gAuth.idToken)
            .toString());
    print('serverAuthCode ${gUser.serverAuthCode}');
    print('id ${gUser.id}');
    print('authHeaders ${gUser.authHeaders}');
    print('${gAuth.idToken}');
    print('accessToken ${gAuth.accessToken}');
    print('token ${credential.token}');
    final f = AuthCredential(
        providerId: 'google.com',
        signInMethod: 'google.com',
        token: null,
        accessToken: gAuth.accessToken);

    final res = FirebaseAuth.instance.signInWithCredential(f);
    return await res;
  }
}
