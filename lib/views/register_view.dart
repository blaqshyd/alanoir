// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/contants/constants.dart';
import 'package:my_app/utils/colors.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Alanior",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w700),
                        ),
                        sizedHeight40,
                        //Name Field
                        MyFormField(
                          keyboardType: TextInputType.name,
                          inputHint: 'John Doe',
                          inputLabel: 'Full name',
                          outlineBorder: OutlineInputBorder(),
                        ),
                        sizedHeight20,
                        //Userame Field
                        MyFormField(
                          keyboardType: TextInputType.name,
                          inputHint: 'johndoe',
                          prefixText: '@',
                          inputLabel: 'Username',
                          outlineBorder: OutlineInputBorder(),
                        ),
                        sizedHeight20,
                        // Email Field
                        MyFormField(
                          keyboardType: TextInputType.emailAddress,
                          inputHint: 'xyz@gmail.com',
                          inputLabel: 'Email Address',
                          controller: _emailController,
                          outlineBorder: OutlineInputBorder(),
                        ),
                        sizedHeight20,
                        // Password Field
                        MyFormField(
                          keyboardType: TextInputType.visiblePassword,
                          inputHint: 'Enter password',
                          inputLabel: 'Password',
                          obscureText: true,
                          controller: _passwordController,
                          outlineBorder: OutlineInputBorder(),
                        ),
                        sizedHeight30,
                        MaterialButton(
                          height: 50,
                          minWidth: double.infinity,
                          color: kPrimaryColor,
                          textColor: Colors.grey[400],
                          onPressed: () async {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            final userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            print(userCredential);
                          },
                          child: const Text("Register"),
                        ),
                        sizedHeight30,
                        MyDivider(
                          label: 'or Sign up with',
                          color: Colors.grey[800]!,
                          indentleft: 35,
                          indentright: 35,
                          thickness: 3,
                        ),
                        sizedHeight20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.facebook)),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.g_mobiledata)),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.facebook)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already a user?'),
                            TextButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/login'),
                                child: Text('Login')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            default:
              return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
