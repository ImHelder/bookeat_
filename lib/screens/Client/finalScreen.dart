import 'package:bookeat/components/Client/restaurnatCustomLogo.dart';
import 'package:bookeat/components/Common/customButton.dart';
import 'package:bookeat/components/Common/top_bar.dart';
import 'package:bookeat/screens/Client/restaurantScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FinalScreen extends StatefulWidget {
  FinalScreen({super.key, required this.restaurant});
  Map<String, Object> restaurant = {};

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  goToCustomRestaurant() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return RestaurantPage(restaurantId: widget.restaurant["id"].toString());
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Choix des plats", userType: "client"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  RestaurantCustomLogo(
                      restaurantName: widget.restaurant["name"].toString(),
                      restaurantCover: widget.restaurant["logoUrl"].toString()),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: CustomButton(
                          title: "Paiement validé",
                          onPress: () {},
                          fixedSize: kIsWeb ? 300.0 : 200,
                          isTab: false,
                        ),
                      )),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        "Votre réservation a bien été confirmé",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                    ],
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              const Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: CustomButton(
                      title: "Revenir à l'accueil",
                      onPress: goToCustomRestaurant,
                      fixedSize: kIsWeb ? 600 : 200,
                      isTab: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
