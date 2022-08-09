// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/contants/constants.dart';
import 'package:my_app/utils/colors.dart';
import 'package:my_app/utils/error_dialog.dart';
import 'package:my_app/utils/routes.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  final capRegExp = RegExp(r'[A-Z]');
  final smallRegExp = RegExp(r'[a-z]');

  final emailValidator = Validators.compose([
    Validators.required('Email is required'),
    Validators.email('Invalid email address'),
  ]);
  final passwordValidator = Validators.compose([
    Validators.required('Password field required'),
    Validators.patternString(r'[0-9]', 'Must contain atleast one digit'),
    Validators.patternString(r'[!@#\$&*~]', 'Special character'),
    Validators.minLength(8, 'Password should not be less than 8')
  ]);

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
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
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
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
                border: OutlineInputBorder(),
              ),
              sizedHeight20,
              // Password Field
              MyFormField(
                inputHint: 'Enter password',
                inputLabel: 'Password',
                obscureText: true,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                border: OutlineInputBorder(),
                validator: passwordValidator,
              ),
              sizedHeight30,
              MaterialButton(
                height: 50,
                minWidth: double.infinity,
                textColor: Colors.grey[400],
                color: kPrimaryColor,
                onPressed: () async {
                  try {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    // A delay for one the login process is ongoing
                    // await Future.delayed(Duration(seconds: 3));
                    // final userCredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    // log(userCredential.toString());
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(homeRoute, (route) => false);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      await showErrorDialog(context, 'User not found');
                    } else if (e.code == 'wrong-password') {
                      await showErrorDialog(context, 'Wrong Password');
                    } else {
                      await showErrorDialog(context, 'Error ${e.code}');
                    }
                  } catch (e) {
                    await showErrorDialog(context, e.toString());
                  }
                },
                child: const Text("Login"),
              ),
              sizedHeight30,
              // Other Sign in Options
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New user?'),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, registerRoute, (route) => false);
                      },
                      child: Text('Register')),
                ],
              ),

              sizedHeight20,
              NeoPopButton(
                color: kPrimaryColor,
                onTapUp: () => HapticFeedback.vibrate(),
                onTapDown: () => HapticFeedback.vibrate(),
                border:
                    Border(bottom: BorderSide(width: 5, color: Colors.green)),
                parentColor: Colors.transparent,
                buttonPosition: Position.center,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("login"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
