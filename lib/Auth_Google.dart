import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

const List<String> scopes = <String>[
  'email',
  'openid',
  'https://www.googleapis.com/auth/contacts.readonly',
  "https://www.googleapis.com/auth/userinfo.profile"
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class AuthService {
  signInGoogle() async {
    //
    await _googleSignIn.signIn();

    final GoogleSignInAccount? gUser = await _googleSignIn.signInSilently();

    //_googleSignIn.signIn();
    print('gUser id ' + gUser!.id);
    //final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    print('object-----------------------2');

    SecurityContext securityContext = SecurityContext.defaultContext;
    final String serverUrl = 'https://f2d1-37-214-3-179.ngrok-free.app/login';
    final url = Uri.parse(serverUrl);
    final ByteData crtData = await rootBundle.load('assets/cert.pem');
    securityContext.setTrustedCertificatesBytes(crtData.buffer.asUint8List());
// Load the SSL certificate for the server
    //securityContext.setTrustedCertificates('assets/cert.pem');

// Make the HTTPS request to the server
    final response = await HttpClient(context: securityContext).postUrl(url);
    response.headers.set('idToken', gAuth.idToken as String);
    response.headers.set('email', gUser.email);

    HttpClientResponse httpResponse = await response.close();
    String responseBody = await httpResponse.transform(utf8.decoder).join();

    if (httpResponse.statusCode == 200) {
      print(responseBody);
      if (responseBody == 'true') {
        print("true");
        logger.d("${gAuth.idToken}");
        final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken, idToken: gAuth.idToken);
        final res = FirebaseAuth.instance.signInWithCredential(credential);
        return await res;
      } else {
        print('error');
      }
    } else {
      throw Exception('Failed to login');
    }

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
    } String? token = gAuth.accessToken;
        print('res.toString() ' +
            GoogleAuthProvider.credential(
                accessToken: gAuth.accessToken, idToken: gAuth.idToken)
                .toString());
        print('serverAuthCode ${gUser.serverAuthCode}');
        print('id ${gUser.id}');
        print('authHeaders ${gUser.authHeaders}');
        print('${gAuth.idToken}');
        print('accessToken ${gAuth.accessToken}');
        print('token ${credential.token}');*/
  }
}
