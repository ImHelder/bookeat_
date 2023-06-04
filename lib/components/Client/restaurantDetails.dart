import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({super.key, required this.details});

  final String details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: kIsWeb ? 10.0 : 5.0,
          right: kIsWeb ? 50.0 : 30.0,
          left: kIsWeb ? 50.0 : 30.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3 * (kIsWeb ? 1.5 : 1.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kIsWeb ? 10.0 : 30.0),
            border: Border.all(color: Colors.black),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(kIsWeb ? 80.0 : 40.0),
              child: Text(
                details,
                style: const TextStyle(fontSize: kIsWeb ? 20 : 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
