import 'package:bookeat/screens/Client/homescreen.dart';
import 'package:bookeat/screens/subscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  static const routeName = "/Authentication.dart";
  const Authentication({
    super.key,
  });
  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool error = false;

  bool validateEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

  bool validatePassword(String password) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&.*~]).{8,}$')
        .hasMatch(password);
  }

  String bgImage = kIsWeb
      ? "lib/assets/authenticationWeb.png"
      : "lib/assets/authBgImage.png";

  signIn() async {
    setState(() {
      isLoading = true;
      error = false;
    });
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final user = userCredential.user;
    } catch (err) {
      setState(() {
        error = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: kIsWeb
          ? null
          : AppBar(
              title: const Text("Connexion"),
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
                    child: Column(children: <Widget>[
                      const Image(
                        image: AssetImage("lib/assets/BookEat_2.png"),
                        height: kIsWeb ? 250 : 150,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          errorStyle: kIsWeb
                              ? null
                              : const TextStyle(fontWeight: FontWeight.bold),
                          suffixIcon: const Icon(Icons.person),
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
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          errorStyle: kIsWeb
                              ? null
                              : const TextStyle(fontWeight: FontWeight.bold),
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
                      error
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.0),
                              child: Text(
                                  "Le mot de passe est incorrect ou le compte n'existe pas"))
                          : Container(),
                      isLoading
                          ? const CircularProgressIndicator()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 50.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 60.0),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.yellow),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signIn();
                                  }
                                },
                                child: const Text('Connexion'),
                              ),
                            ),
                      isLoading
                          ? Container()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 60.0),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.yellow),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Subscription(),
                                    ),
                                  );
                                },
                                child: const Text('Inscription'),
                              ),
                            ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
