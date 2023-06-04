import 'package:bookeat/screens/subscription.dart';
import 'package:bookeat/utils/helpingFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/Client/homescreen.dart';
import 'providers/UserProvider.dart';
import 'screens/Restaurant/homescreen.dart';
import 'screens/Admin/homescreen.dart';
import 'screens/authentication.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book & Eat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthGate(title: 'En attente de connexion'),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key, required this.title});

  final String title;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  List<String> authorizedUsers = ["admin", "client", "restaurant"];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Authentication();
        }
        try {
          FirebaseFirestore.instance
              .collection('/Users')
              .doc(snapshot.data?.uid)
              .get()
              .then((DocumentSnapshot doc) {
            var userType = doc.get("userType");

            if (!authorizedUsers.contains(userType)) {
              return const Authentication();
            }

            if (userType != null && userType == "admin") {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const AdminHomeScreen();
              }));
            }
            if (userType != null && userType == "client") {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const ClientHomeScreen();
              }));
            }
            if (userType != null && userType == "restaurant") {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const RestaurantHomeScreen();
              }));
            }
          });
        } catch (err) {
          return const Authentication();
        }
        return Container();
      },
    );
  }
}
