import 'dart:math';

import 'package:bookeat/components/Client/CustomCounter.dart';
import 'package:bookeat/components/Common/customDialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String id;

  final String title;

  final String description;

  final String picture;

  final String price;

  final String leftImageData;

  final Function onPress;

  final Function onPress2;

  final bool isChoice;

  final int currentCounter;

  final bool isConfirmation;

  final int totalDishes;

  const CustomCard(
      {super.key,
      this.id = "",
      required this.title,
      required this.description,
      this.price = "",
      this.picture = "",
      this.leftImageData = "",
      this.currentCounter = 0,
      this.isConfirmation = false,
      this.totalDishes = 0,
      required this.onPress,
      required this.isChoice,
      required this.onPress2});

  goToCustomDialog(context, image) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage(image),
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 10),
                Text(description),
                const SizedBox(height: 10),
                Text("Prix: $leftImageData"),
                const SizedBox(height: 10),
                isChoice
                    ? Flexible(
                        child: CustomCounter(
                          currentCounter: currentCounter,
                          callback: (count) => onPress2({
                            "price": double.parse(leftImageData.split("€")[0]),
                            "count": count
                          }),
                        ),
                      )
                    : Container()
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fermer'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final String imageToDisplay = "lib/assets${picture.split("assets")[1]}";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isChoice && kIsWeb
            ? CustomCounter(
                currentCounter: currentCounter,
                callback: (count) => onPress2({
                  "price": double.parse(leftImageData.split("€")[0]),
                  "count": count
                }),
              )
            : isConfirmation
                ? Text("X$totalDishes")
                : Container(),
        Expanded(
          child: Card(
            clipBehavior: Clip.hardEdge,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            color:
                !kIsWeb && currentCounter > 0 ? const Color(0xffffc107) : null,
            child: InkWell(
                splashColor: Colors.yellow.withAlpha(30),
                onTap: () {
                  try {
                    if (id.isNotEmpty) {
                      onPress(id);
                    }
                    if (id.isEmpty && !kIsWeb) {
                      goToCustomDialog(context, imageToDisplay);
                    }
                  } catch (err) {
                    print(err);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            !kIsWeb && id.isEmpty ? "" : description,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      ),
                      Flexible(
                          child: Flex(
                        direction: Axis.vertical,
                        children: [
                          Text(leftImageData),
                          const SizedBox(height: 10, width: kIsWeb ? 50 : 10),
                          SizedBox(
                            height: kIsWeb ? 150 : 55,
                            width: kIsWeb ? 150 : 55,
                            child: Image(
                              image: picture != ""
                                  ? AssetImage(imageToDisplay)
                                  : const AssetImage(""),
                              width: kIsWeb ? 150 : 55,
                              height: kIsWeb ? 150 : 55,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
