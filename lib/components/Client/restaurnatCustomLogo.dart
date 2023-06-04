import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantCustomLogo extends StatelessWidget {
  const RestaurantCustomLogo(
      {super.key, required this.restaurantName, required this.restaurantCover});
  final String restaurantName;
  final String restaurantCover;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(restaurantName,
                style: GoogleFonts.inriaSerif(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 35,
                        fontStyle: FontStyle.italic)))),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 3 * (kIsWeb ? 0.75 : 2),
          height: kIsWeb ? 200 : 175,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    "lib/assets${restaurantCover.split("assets")[1]}")),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Colors.redAccent,
          ),
        ),
      )
    ]);
  }
}
