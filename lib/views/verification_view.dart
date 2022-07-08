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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 18,
      ),
      child: Center(
        child: Column(
          children: [
            const Text('Please verify Email Address'),
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text('Send Email Verfication'),
            )
          ],
        ),
      ),
    );
  }
}

/*
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
              const Text('Please verify Email Address'),
              TextButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                },
                child: const Text('Send Email Verfication'),
              )
            ],
          ),
        ),
      )),
    );

*/