import 'package:bookeat/screens/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Client/homescreen.dart';

class Subscription extends StatefulWidget {
  static const routeName = "/Subscription.dart";

  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;

  bool validateEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

  bool validatePassword(String password) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&.*~]).{8,}$')
        .hasMatch(password);
  }

  createUserAndAccessApp() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User? signedInUser = authResult.user;

      await signedInUser?.sendEmailVerification();

      if (!context.mounted) return;
      if (signedInUser != null) {
        FirebaseFirestore.instance
            .collection('/Users')
            .doc(signedInUser.uid)
            .set({
          'firstName': lastNameController.text,
          'lastName': firstNameController.text,
          'phone': phoneController.text,
          'email': emailController.text,
          'isAdmin': false,
          "userType": "client",
        });
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const ClientHomeScreen();
        }));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(
          content: const Text("Une erreur est survenue"),
          action: SnackBarAction(
            label: 'Ce mail est déjà utilisé !',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        rethrow;
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: const Text("Une erreur est survenue"),
        action: SnackBarAction(
          label: 'Une erreur est survenue',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      rethrow;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String bgImage = "lib/assets/authBgImage.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: kIsWeb
          ? null
          : AppBar(
              title: const Text("Inscription"),
              centerTitle: true,
              backgroundColor: Colors.yellow,
            ),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: kIsWeb
              ? null
              : BoxDecoration(
                  image: DecorationImage(
                      alignment: kIsWeb
                          ? FractionalOffset.centerLeft
                          : FractionalOffset.center,
                      image: AssetImage(bgImage),
                      fit: kIsWeb ? BoxFit.fitHeight : BoxFit.cover,
                      colorFilter: kIsWeb
                          ? null
                          : ColorFilter.mode(Colors.white.withOpacity(0.3),
                              BlendMode.modulate)),
                ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: kIsWeb ? 3 : 0,
                    child: kIsWeb
                        ? Image(
                            image: AssetImage(bgImage),
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height,
                          )
                        : Container(),
                  ),
                  kIsWeb
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                        )
                      : Container(),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              image: AssetImage("lib/assets/BookEat_2.png"),
                              height: kIsWeb ? 250 : 150,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15.0),
                            ),
                            TextFormField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                errorStyle: kIsWeb
                                    ? null
                                    : const TextStyle(
                                        fontWeight: FontWeight.bold),
                                suffixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 30.0, color: Colors.greenAccent),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                label: const Text(
                                  "Entrez votre prénom",
                                  style: kIsWeb
                                      ? null
                                      : TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez rentrer votre prénom';
                                }
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            TextFormField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                errorStyle: kIsWeb
                                    ? null
                                    : const TextStyle(
                                        fontWeight: FontWeight.bold),
                                suffixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 30.0, color: Colors.greenAccent),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                label: const Text(
                                  "Entrez votre nom",
                                  style: kIsWeb
                                      ? null
                                      : TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez rentrer votre nom';
                                }
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                errorStyle: kIsWeb
                                    ? null
                                    : const TextStyle(
                                        fontWeight: FontWeight.bold),
                                suffixIcon: const Icon(Icons.phone),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 30.0, color: Colors.greenAccent),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                label: const Text(
                                  "Entrez votre numéro de téléphone",
                                  style: kIsWeb
                                      ? null
                                      : TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez rentrer votre numéro de téléphone';
                                }
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                errorStyle: kIsWeb
                                    ? null
                                    : const TextStyle(
                                        fontWeight: FontWeight.bold),
                                suffixIcon: const Icon(
                                    Icons.local_post_office_outlined),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 30.0, color: Colors.greenAccent),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                label: const Text(
                                  "Entrez votre mail",
                                  style: kIsWeb
                                      ? null
                                      : TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !validateEmail(value)) {
                                  return 'Veuillez rentrer un email valide';
                                }
                                return null;
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                errorStyle: kIsWeb
                                    ? null
                                    : const TextStyle(
                                        fontWeight: FontWeight.bold),
                                suffixIcon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 30.0, color: Colors.greenAccent),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                label: const Text(
                                  "Entrez votre mode de passe",
                                  style: kIsWeb
                                      ? null
                                      : TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !validatePassword(value)) {
                                  const message = kIsWeb
                                      ? 'Veuillez entrer un mot de passe d\'au moins 8 caractères, une majuscule, un chiffre, un caractère special'
                                      : 'Veuillez entrer un mot de passe d\'au moins 8 caractères,\nune majuscule, un chiffre, un caractère special';
                                  return message;
                                }
                                return null;
                              },
                            ),
                            isLoading
                                ? const CircularProgressIndicator()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 50.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              horizontal: 60.0),
                                        ),
                                        backgroundColor:
                                            const MaterialStatePropertyAll<
                                                Color>(Colors.yellow),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          createUserAndAccessApp();
                                        }
                                      },
                                      child: const Text('S\'inscire'),
                                    ),
                                  ),
                            isLoading
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              horizontal: 60.0),
                                        ),
                                        backgroundColor:
                                            const MaterialStatePropertyAll<
                                                Color>(Colors.yellow),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Authentication(),
                                          ),
                                        );
                                      },
                                      child: const Text('Connexion'),
                                    ),
                                  ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 100.0),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
