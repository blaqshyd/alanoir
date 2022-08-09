// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/views/login_view.dart';
import 'package:my_app/views/verification_view.dart';

import '../firebase_options.dart';
import 'home_view.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  // log('Email Verified');
                  return HomeView();
                } else {
                  return VerifyView();
                }
              } else {
                return LoginView();
              }
            default:
              return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
