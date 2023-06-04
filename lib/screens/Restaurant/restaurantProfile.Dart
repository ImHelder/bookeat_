import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RestaurantProfileScreen extends StatefulWidget {
  const RestaurantProfileScreen({super.key});

  @override
  State<RestaurantProfileScreen> createState() => _RestaurantProfileScreenState();
}

class _RestaurantProfileScreenState extends State<RestaurantProfileScreen> {
  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RESTAURANT profile"),
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
