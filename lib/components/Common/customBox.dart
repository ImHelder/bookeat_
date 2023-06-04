import 'package:bookeat/screens/Client/restaurantScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomBox extends StatelessWidget {
  const CustomBox(
      {super.key,
      this.title = "",
      this.backgroundImage = "",
      this.description = "",
      this.restaurantId = ""});

  final String title;
  final String backgroundImage;
  final String description;
  final String restaurantId;

  onPress(context, chosenId) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RestaurantPage(restaurantId: chosenId);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          if (restaurantId.isNotEmpty) {
            onPress(context, restaurantId);
          }
        },
        child: Container(
          width: kIsWeb ? 100 : 100,
          height: kIsWeb ? 100 : 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.black),
              image: backgroundImage.isNotEmpty
                  ? DecorationImage(
                      opacity: 0.4,
                      image: AssetImage(
                          "lib/assets${backgroundImage.split("assets")[1]}"),
                      fit: BoxFit.cover)
                  : const DecorationImage(image: AssetImage(""))),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: description.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
