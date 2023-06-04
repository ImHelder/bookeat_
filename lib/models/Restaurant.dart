import 'package:bookeat/models/Comment.dart';
import 'package:flutter/material.dart';

import '../components/Common/customCard.dart';

class CustomRestaurant {
  // identifiant

  final String id;

  final String name;

  final String address;

  final List<Map<String, String>> menu;

  final String logoUrl;

  final String category;

  final String notation;

  final String description;

  final String openingHours;

  final String type;

  final List<CustomComment> userComments = [];

  CustomRestaurant(
      {required this.id,
      required this.name,
      required this.address,
      required this.logoUrl,
      required this.category,
      required this.notation,
      required this.description,
      required this.openingHours,
      required this.type,
      required this.menu});
}
