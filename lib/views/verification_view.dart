// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyView extends StatefulWidget {
  const VerifyView({Key? key}) : super(key: key);

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Verification"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        child: Center(
          child: Column(
            children: [
              Text('Email verification sent to your email. Please verify to complete signup.'),
              Text("If you didn't receive the verification email"),
              TextButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                },
                child: Text('Send Email Verfication'),
              )
            ],
          ),
        ),
      )),
    );
  }
}

