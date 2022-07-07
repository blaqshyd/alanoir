// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/views/homepage_view.dart';
import 'package:my_app/views/login_view.dart';
import 'package:my_app/views/register_view.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginView(),
        '/register': (context) => RegisterView(),
      },
    ),
  );
}
