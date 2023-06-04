import 'package:bookeat/components/Client/restaurantMenu.dart';
import 'package:bookeat/components/Client/restaurnatCustomLogo.dart';
import 'package:bookeat/components/Common/customButton.dart';
import 'package:bookeat/components/Common/customCard.dart';
import 'package:bookeat/components/Common/customDatePicker.dart';
import 'package:bookeat/components/Common/customDropDown.dart';
import 'package:bookeat/components/Common/top_bar.dart';
import 'package:bookeat/screens/Client/finalScreen.dart';
import 'package:bookeat/screens/Client/paymentScreen.dart';
import 'package:bookeat/utils/fakers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReserveCustom extends StatefulWidget {
  final String restaurantId;
  final Map<String, Map> command;
  final double total;

  const ReserveCustom(
      {super.key,
      required this.restaurantId,
      required this.command,
      required this.total});

  @override
  State<ReserveCustom> createState() => _ReserveCustomState();
}

class _ReserveCustomState extends State<ReserveCustom> {
  List restaurantMenu = [];
  Map<String, Object> restaurant = {};
  String reservationDate = "";
  int nbOfPeople = 5;
  bool disabledButton = true;

  final List<String> peoples = List.generate(
      20, (index) => "${index + 5} ${index == 0 ? "personne" : "personnes"}");

  @override
  void initState() {
    super.initState();
    final currentRestaurantMenu = restaurantsData.firstWhere(
            (restaurant) => restaurant["id"] == widget.restaurantId)["menu"]
        as List;
    restaurant = restaurantsData
        .firstWhere((restaurant) => restaurant["id"] == widget.restaurantId);

    final currentCommandDishes = widget.command.keys.map((command) => command);

    restaurantMenu = currentRestaurantMenu
        .where((e) => currentCommandDishes.contains(e["name"]))
        .toList();
  }

  goToPaymentScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PaymentScreen(restaurant: restaurant);
    }));
  }

  getDate(date) {
    setState(() {
      reservationDate = date;
      disabledButton = reservationDate == "";
    });
  }

  setNbofPeople(nombre) {
    setState(() {
      nbOfPeople = int.parse(nombre.split(" ")[0]);
    });
  }

  goToFinalScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return FinalScreen(restaurant: restaurant);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final currentCommand = widget.command.entries
        .map((e) => {"name": e.key, "count": e.value["count"]})
        .toList();

    return Scaffold(
        appBar:
            const CustomAppBar(title: "Choix des plats", userType: "client"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RestaurantCustomLogo(
                              restaurantName: restaurant["name"].toString(),
                              restaurantCover:
                                  restaurant["logoUrl"].toString()),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Center(
                                child: CustomButton(
                                  title: "Résumé de la commande",
                                  onPress: () {},
                                  fixedSize: kIsWeb ? 300.0 : 300,
                                  isTab: false,
                                ),
                              )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                  "Choisissez le nombre de personne et la date de réservation"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomDropDownButton(
                                    list: peoples,
                                    setNBofPeople: setNbofPeople,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: CustomDatePicker(
                                      getDate: getDate,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Expanded(
                            child: restaurantMenu.isNotEmpty
                                ? RestaurantMenu(
                                    menu: restaurantMenu,
                                    isConfirmation: true,
                                    totalDishes: currentCommand,
                                    command: (value) => print(value))
                                : Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          const Text(
                                              "Vous n'avez rien choisi, mais vous pouvez toujours réserver une table :) "),
                                          nbOfPeople > 5
                                              ? const Text(
                                                  "Au dessus de 5 personnes, pour ce restaurant, il est nécessaire de laisser une empreinte de votre carte bleue si vous ne payer pas en ligne.")
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: widget.total != 0
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: CustomButton(
                        title: nbOfPeople => 5
                            ? "Réserver et laisser une empreinte de carte"
                            : widget.total == 0
                                ? "Réserver une table"
                                : "Payer en ligne ou sur place",
                        onPress: nbOfPeople > 5
                            ? goToPaymentScreen
                            : widget.total == 0
                                ? goToFinalScreen
                                : goToPaymentScreen,
                        fixedSize: kIsWeb ? 600 : 200,
                        isTab: false,
                        disable: disabledButton,
                      ),
                    ),
                    widget.total == 0
                        ? Container()
                        : Text("Total: ${widget.total.toStringAsFixed(2)}€")
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
