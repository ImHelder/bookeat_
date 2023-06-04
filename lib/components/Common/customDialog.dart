import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.picture,
      required this.price,
      required this.leftImageData});

  final String title;

  final String description;

  final String picture;

  final String price;

  final String leftImageData;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      child: Text("in dialog"),
    );
  }
}
