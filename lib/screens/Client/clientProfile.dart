import 'package:bookeat/components/Common/customBox.dart';
import 'package:bookeat/components/Common/top_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import "../../utils/helpingFunctions.dart";

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({super.key});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;

    return Scaffold(
        appBar: const CustomAppBar(title: "", userType: "client"),
        body: Column(
          children: [
            Flexible(
              child: Flex(
                direction: Axis.vertical,
                children: [
                  FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('/Users')
                          .doc(currentUser!.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          print(data);
                          final fullName = data["firstName"].toUpperCase() +
                              " " +
                              capitalize(data["lastName"]);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(fullName,
                                  style: GoogleFonts.inriaSerif(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 35,
                                          fontStyle: FontStyle.italic))),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      onPressed: () => print("avatr touched"),
                                      icon: CircleAvatar(
                                        radius: kIsWeb ? 150 : 30,
                                        child: kIsWeb
                                            ? const Text("Image de profile")
                                            : Container(),
                                      ),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              kIsWeb ? 50.0 : 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    fullName,
                                                    style: const TextStyle(
                                                        fontSize:
                                                            kIsWeb ? 35 : 13),
                                                  ),
                                                  IconButton(
                                                    onPressed: () =>
                                                        print("modify profile"),
                                                    icon: const Row(
                                                      children: [
                                                        Text("Modifier",
                                                            style: TextStyle(
                                                                fontSize: kIsWeb
                                                                    ? 25
                                                                    : 13)),
                                                        Icon(
                                                          Icons.edit,
                                                          color: Colors.black,
                                                          size:
                                                              kIsWeb ? 30 : 15,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                data["email"],
                                                style: const TextStyle(
                                                    fontSize: kIsWeb ? 35 : 13),
                                              ),
                                              Text(
                                                data["phone"],
                                                style: const TextStyle(
                                                    fontSize: kIsWeb ? 35 : 13),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              const Text(
                                "Historique de commande",
                                style: TextStyle(fontSize: 25),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomBox(
                                          title: "Commande 1",
                                          description: "Chez Maurice: 33€",
                                        ),
                                        CustomBox(
                                            title: "Commande 2",
                                            description:
                                                "Chez Etchebest le best: 54€"),
                                        CustomBox(),
                                        CustomBox(),
                                      ]),
                                ),
                              ),
                              const Text(
                                "Restaurant favoris",
                                style: TextStyle(fontSize: 25),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomBox(
                                        title: "Chez Etchebest le best",
                                        restaurantId: "r13",
                                        backgroundImage:
                                            "../lib/assets/bar5.jpg",
                                      ),
                                    ]),
                              ),
                            ],
                          );
                        }

                        return const Center(
                            child: Text("Chargement des données utilisateur"));
                      })
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 60.0),
                ),
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.yellow),
              ),
              onPressed: () {
                logout();
              },
              child: const Text('Déconexion'),
            ),
          ],
        ));
  }
}

// ElevatedButton(
//         style: ButtonStyle(
//           padding: MaterialStateProperty.all(
//             const EdgeInsets.symmetric(horizontal: 60.0),
//           ),
//           backgroundColor: const MaterialStatePropertyAll<Color>(Colors.yellow),
//         ),
//         onPressed: () {
//           logout();
//         },
//         child: const Text('Déconexion'),
//       ),
