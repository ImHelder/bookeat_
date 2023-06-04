import 'package:bookeat/components/Client/restaurantDetails.dart';
import 'package:bookeat/components/Client/restaurantFeedbacks.dart';
import 'package:bookeat/components/Client/restaurantMenu.dart';
import 'package:bookeat/components/Client/restaurnatCustomLogo.dart';
import 'package:bookeat/components/Common/customButton.dart';
import 'package:bookeat/components/Common/top_bar.dart';
import 'package:bookeat/screens/Client/reserveCustom.dart';
import 'package:bookeat/utils/fakers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RestaurantPage extends StatefulWidget {
  final String restaurantId;
  const RestaurantPage({super.key, required this.restaurantId});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  Map<String, Object> restaurant = {};

  var currentTab = 0;
  Map<String, Map> command = {};

  double finalPrice = 0;

  @override
  void initState() {
    restaurant = restaurantsData
        .firstWhere((restaurant) => restaurant["id"] == widget.restaurantId);
  }

  handleChangeTab(newTab) {
    setState(() {
      currentTab = newTab;
    });
  }

  goToCustomMenu() {
    command.removeWhere((key, value) => value["count"] == 0);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ReserveCustom(
          restaurantId: widget.restaurantId,
          command: command,
          total: finalPrice);
    }));
  }

  setCommand(count, name) {
    var _finalPrice = 0.0;
    command[name] = count;

    for (var com in command.entries) {
      _finalPrice += com.value["price"] * com.value["count"];
    }

    setState(() {
      finalPrice = _finalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: "Restaurant description", userType: "client"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                RestaurantCustomLogo(
                    restaurantName: restaurant["name"].toString(),
                    restaurantCover: restaurant["logoUrl"].toString()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          title: "Détails",
                          onPress: handleChangeTab,
                          fixedSize: kIsWeb ? 300.0 : 100,
                          currentTab: currentTab,
                          isTab: true,
                          tab: 0),
                      CustomButton(
                          title: "Carte",
                          onPress: handleChangeTab,
                          fixedSize: kIsWeb ? 300.0 : 100,
                          currentTab: currentTab,
                          isTab: true,
                          tab: 1),
                      CustomButton(
                          title: "Avis",
                          onPress: handleChangeTab,
                          fixedSize: kIsWeb ? 300.0 : 100,
                          currentTab: currentTab,
                          isTab: true,
                          tab: 2),
                    ],
                  ),
                ),
                currentTab == 0
                    ? Expanded(
                        child: RestaurantDetails(
                            details: restaurant["description"].toString()),
                      )
                    : currentTab == 1
                        ? Expanded(
                            child: RestaurantMenu(
                            menu: [restaurant["menu"]],
                            command: setCommand,
                            currentCommand: command,
                            isChoice: true,
                          ))
                        : Expanded(
                            child: RestaurantFeedback(
                                feedbacks: [restaurant["feedbacks"]])),
              ])),
          Column(
            children: [
              const Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: finalPrice != 0
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: CustomButton(
                      title: "Réserver une table",
                      onPress: goToCustomMenu,
                      fixedSize: kIsWeb ? 600 : 200,
                      isTab: false,
                    ),
                  ),
                  finalPrice == 0
                      ? Container()
                      : Text("Total: ${finalPrice.toStringAsFixed(2)}€")
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
