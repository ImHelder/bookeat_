import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  static const routeName = "/AdminHomeScreen.dart";
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADMIN homeScren"),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        leading: null,
      ),
      body: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 60.0),
          ),
          backgroundColor: const MaterialStatePropertyAll<Color>(Colors.yellow),
        ),
        onPressed: () {
          logout();
        },
        child: const Text('Déconexion'),
      ),
    );
  }
}
