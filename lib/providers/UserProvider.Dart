// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/material.dart';
// import '../models/User.dart';

// class UserProvider with ChangeNotifier {
//   List<UserCustom> _users = [];

//   /// @return renvoie la liste des utilisateurs
//   List<UserCustom> get users {
//     return [..._users];
//   }

//   Future<void> fetchAndSetUser() async {
//     final List<UserCustom> _liste = [];
//     await FirebaseFirestore.instance
//         .collection('utilisateur')
//         .get()
//         .then((QuerySnapshot querySnapshot) =>
//             querySnapshot.docs.forEach((QueryDocumentSnapshot element) {
//               _liste.add(UserCustom(
//                   id: element.id,
//                   nom: element.get('name'),
//                   prenom: element.get('prenom'),
//                   eMail: element.get('eMail'),
//                   phone: element.get('phone'),
//                   dateNaissance: element.get('dateNaissance'),
//                   passeword: element.get('password'),
//                   sexe: element.get('sexe'),
//                   range: element.get('range'),
//                   freq: element.get('freq')));
//             }))
//         .catchError((onError) => throw onError);
//     _users = [..._liste];
//     //
//     notifyListeners();
//   }

//   /// @args l'identifiant de l'utilisateur recherché
//   /// @return renvoie un utilisateur dont l'identifiant = à id
//   UserCustom searchUser(String id) {
//     //return _users.firstWhere(((user) => user.id == id));
//     for (var i = 0; i < _users.length; i++) {
//       if (_users[i].id == id) {
//         return _users[i];
//       }
//     }
//     return null;
//   }
