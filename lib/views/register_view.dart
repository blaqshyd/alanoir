// ignore_for_file: prefer_const_constructors

import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/contants/constants.dart';
import 'package:my_app/utils/colors.dart';
import 'package:my_app/utils/routes.dart';
import 'package:my_app/utils/validation.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../utils/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Alanior",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
              sizedHeight40,
              //Name Field
              // MyFormField(
              //   keyboardType: TextInputType.name,
              //   inputHint: 'John Doe',
              //   inputLabel: 'Full name',
              //   outlineBorder: OutlineInputBorder(),
              // ),
              // sizedHeight20,
              // //Userame Field
              // MyFormField(
              //   keyboardType: TextInputType.name,
              //   inputHint: 'johndoe',
              //   prefixText: '@',
              //   inputLabel: 'Username',
              //   outlineBorder: OutlineInputBorder(),
              // ),
              // sizedHeight20,
              // Email Field
              customTextField(
                keyboardType: TextInputType.emailAddress,
                inputHint: 'xyz@gmail.com',
                inputLabel: 'Email Address',
                controller: _emailController,
                validator: emailValidator,
              ),
              sizedHeight20,
              // Password Field
              customTextField(
                keyboardType: TextInputType.visiblePassword,
                inputHint: 'Enter password',
                inputLabel: 'Password',
                obscureText: true,
                controller: _passwordController,
                validator: passwordValidator,
              ),
              sizedHeight30,
              MaterialButton(
                height: 50,
                minWidth: double.infinity,
                color: kPrimaryColor,
                textColor: Colors.grey[400],
                onPressed: () async {
                  try {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    final user = FirebaseAuth.instance.currentUser;
                    await user?.sendEmailVerification();
                    // Navigator.of(context).pushNamed(verifyRoute);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      await showErrorDialog(context, 'Weak Password');
                    } else if (e.code == 'email-already-in-use') {
                      await showErrorDialog(context, 'Email already in use');
                    } else if (e.code == 'invalid-email') {
                      await showErrorDialog(context, 'Invalid Email');
                    } else {
                      await showErrorDialog(context, 'Error ${e.code}');
                    }
                  } catch (e) {
                    await showErrorDialog(context, e.toString());
                  }
                },
                child: const Text("Register"),
              ),
              sizedHeight30,
              MyDivider(
                label: 'or Sign up with',
                labelColor: Colors.black12,
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
                      onPressed: () {
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, verifyRoute, ((route) => false));
                      },
                      icon: Icon(Icons.facebook)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.g_mobiledata)),
                  IconButton(
                      onPressed: () {}, icon: Icon(FeatherIcons.activity)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a user?'),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, loginRoute, (route) => false);
                      },
                      child: Text('Login')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
