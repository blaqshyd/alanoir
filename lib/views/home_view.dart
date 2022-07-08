// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/routes.dart';

enum MenuAction { logout }

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        title: Text("Alanoir"),
        // centerTitle: true,
        actions: [
          // PopupMenuButton(
          //   onSelected: (value) {},
          //   itemBuilder: (context) {
          //     return [
          //       PopupMenuItem<MenuAction>(
          //         value: MenuAction.logout,
          //         child: Text('Logout'),
          //       ),
          //     ];
          //   },
          // ),
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, loginView);
              },
              child: Text("Logout"))
        ],
      ),
      body: Column(
        children: [
          Text("Home"),
        ],
      ),
    );
  }
}
