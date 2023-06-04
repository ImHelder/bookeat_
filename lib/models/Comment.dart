import 'package:bookeat/models/User.dart';
import 'package:flutter/material.dart';

class CustomComment {
  // identifiant
  final String id;

  final String idUser;

  final String idRestaurant;

  final UserCustom user;

  final String pictureUrl = "";

  final double notation;

  final String comment = "";

  const CustomComment({
    required this.id,
    required this.user,
    required this.notation,
    required this.idUser,
    required this.idRestaurant,
  });
}
