import 'package:bookeat/components/Client/creditCardForm.dart';
import 'package:bookeat/components/Client/restaurnatCustomLogo.dart';
import 'package:bookeat/components/Common/customButton.dart';
import 'package:bookeat/components/Common/top_bar.dart';
import 'package:bookeat/screens/Client/finalScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key, required this.restaurant});
  Map<String, Object> restaurant = {};

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  goToFinalScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return FinalScreen(restaurant: widget.restaurant);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                          title: "Rentrer votre carte bleue",
                          onPress: () {},
                          fixedSize: kIsWeb ? 300.0 : 250,
                          isTab: false,
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CreditCardForm(
                        onPress: goToFinalScreen,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
