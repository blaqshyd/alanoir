// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/views/home_view.dart';
import 'package:my_app/views/main_view.dart';
import 'package:my_app/views/login_view.dart';
import 'package:my_app/views/register_view.dart';
import 'package:my_app/views/verification_view.dart';

import 'utils/routes.dart';
import 'utils/themes.dart';
// import 'views/homepage_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alanoir',

      // For the theme variant
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      // Theme variant ends
      initialRoute: mainView,
      routes: {
        mainView: (context) => MainView(),
        homeView: (context) => HomeView(),
        loginView: (context) => LoginView(),
        registerView: (context) => RegisterView(),
        verifyView: (context) => VerifyView(),
        // '/': (context) => HomePage(),
        // '/login': (context) => LoginView(),
        // '/register': (context) => RegisterView(),
        // '/verify':(context) => VerifyView(),
      },
    ),
  );
}
