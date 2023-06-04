import 'package:bookeat/components/Common/customCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const emptyList = [];

class RestaurantMenu extends StatelessWidget {
  const RestaurantMenu(
      {super.key,
      required this.menu,
      required this.command,
      this.currentCommand = "",
      this.isConfirmation = false,
      this.totalDishes = emptyList,
      this.isChoice = false});

  final List menu;
  final Function command;
  final currentCommand;
  final bool isChoice;
  final bool isConfirmation;
  final List totalDishes;

  @override
  Widget build(BuildContext context) {
    final currentMenu = isConfirmation
        ? menu
        : List.generate(menu[0].length, (index) => menu[0][index]);

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3 * (kIsWeb ? 1.5 : 1.1),
        child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: currentMenu.length,
            itemBuilder: (BuildContext context, int index) {
              final int total = isConfirmation
                  ? totalDishes
                      .where((element) =>
                          element["name"] == currentMenu[index]["name"])
                      .toList()
                      .first["count"]
                  : 0;
              return currentMenu.isNotEmpty
                  ? CustomCard(
                      title: currentMenu[index]["name"],
                      description: currentMenu[index]["description"],
                      picture: currentMenu[index]["image"],
                      leftImageData: "${currentMenu[index]["price"]}€",
                      onPress: () {},
                      onPress2: (count) => isConfirmation
                          ? print("")
                          : command(count, currentMenu[index]["name"]),
                      isChoice: isChoice,
                      isConfirmation: isConfirmation,
                      totalDishes: isConfirmation ? total.toInt() : 0,
                      currentCounter: !isConfirmation &&
                              currentCommand[currentMenu[index]["name"]] != null
                          ? currentCommand[currentMenu[index]["name"]]["count"]
                          : 0,
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: Text("Oops, pas de menu trouvé"))
                      ],
                    );
            }),
      ),
    );
  }
}
