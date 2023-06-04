import 'package:bookeat/utils/helpingFunctions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Filters extends StatelessWidget {
  const Filters(
      {super.key,
      required this.selectedPrice,
      required this.handleChangePrice,
      required this.handleChangeCategory,
      required this.selectedCategory});

  final String selectedPrice;
  final String selectedCategory;
  final Function handleChangePrice;
  final Function handleChangeCategory;

  Widget euroIcon() {
    return const Icon(Icons.euro_symbol, color: Color(0xffffc107), size: 12.0);
  }

  Widget price(BuildContext context) {
    return Column(
        crossAxisAlignment:
            kIsWeb ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          kIsWeb
              ? const Text(
                  "Trier",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                )
              : Container(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: kIsWeb ? 20.0 : 0.0),
            child: Divider(height: 10, color: Colors.black),
          ),
          const Text(
            "Prix",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: const Color(0xffffc107)),
                      color:
                          selectedPrice == "small" ? Colors.blue : Colors.grey),
                  child: IconButton(
                      icon: euroIcon(),
                      onPressed: () => handleChangePrice("small")),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: const Color(0xffffc107)),
                      color: selectedPrice == "medium"
                          ? Colors.blue
                          : Colors.grey),
                  child: IconButton(
                      icon: Row(children: [euroIcon(), euroIcon()]),
                      onPressed: () => handleChangePrice("medium")),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: const Color(0xffffc107)),
                      color:
                          selectedPrice == "hight" ? Colors.blue : Colors.grey),
                  child: IconButton(
                      icon: Row(children: [euroIcon(), euroIcon(), euroIcon()]),
                      onPressed: () => handleChangePrice("hight")),
                ),
              ],
            ),
          )
        ]);
  }

  Widget category(BuildContext context) {
    return Column(
        crossAxisAlignment:
            kIsWeb ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          const Text(
            "Catégories",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black),
              ),
              height: kIsWeb ? 200 : 150,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: categories[index]["key"] == selectedCategory
                                ? const Color(0xffffc107)
                                : Colors.white),
                        child: InkWell(
                          splashColor: Colors.yellow.withAlpha(30),
                          onTap: () {
                            try {
                              debugPrint('catégories tappé');
                              handleChangeCategory(categories[index]["key"]);
                            } catch (err) {
                              print(err);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(categories[index]["label"].toString())
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kIsWeb ? 30.0 : 10.0),
      child: Flex(
        direction: !kIsWeb ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          price(context),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
            child: kIsWeb
                ? const Divider(height: 10, color: Colors.black)
                : Container(),
          ),
          Expanded(child: category(context))
        ],
      ),
    );
  }
}
