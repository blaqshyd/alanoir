// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/contants/constants.dart';
import 'package:my_app/firebase_options.dart';
import 'package:my_app/utils/colors.dart';
import 'package:my_app/utils/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Alanior",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
            sizedHeight40,
            //Email Field
            MyFormField(
              inputHint: 'xyz@gmail.com',
              inputLabel: 'Email Address',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              outlineBorder: OutlineInputBorder(),
            ),
            sizedHeight20,
            // Password Field
            MyFormField(
              inputHint: 'Enter password',
              inputLabel: 'Password',
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              outlineBorder: OutlineInputBorder(),
            ),
            sizedHeight30,
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              color: kPrimaryColor,
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                final userCredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                print(userCredential);
              },
              child: const Text("Login"),
            ),
            sizedHeight30,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New user?'),
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, registerView),
                    child: Text('Register')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
