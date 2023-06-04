
import 'package:bookeat/components/Common/top_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RestaurantHomeScreen extends StatefulWidget {
  static const routeName = "/RestaurantHomeScreen.dart";
  const RestaurantHomeScreen({super.key});

  @override
  State<RestaurantHomeScreen> createState() => _RestaurantHomeScreenState();
}

class _RestaurantHomeScreenState extends State<RestaurantHomeScreen> {
  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? const CustomAppBar(title: "", userType: "client")
          : AppBar(
              title: const Text("Restaurant profile"),
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
