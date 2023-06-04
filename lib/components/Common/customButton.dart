import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      required this.onPress,
      required this.fixedSize,
      this.currentTab = 999999,
      this.disable = false,
      this.tab = 0,
      required this.isTab});

  final String title;
  final Function onPress;
  final double fixedSize;
  final int currentTab;
  final int tab;
  final bool isTab;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          fixedSize: MaterialStatePropertyAll<Size>(Size.fromWidth(fixedSize)),
          backgroundColor: MaterialStatePropertyAll<Color>(
              disable ? Colors.grey : const Color(0xffffc107)),
        ),
        onPressed: disable
            ? null
            : () {
                if (isTab) {
                  onPress(tab);
                } else {
                  onPress();
                }
              },
        child: Text(
          title,
          style: TextStyle(
              fontWeight: kIsWeb ? FontWeight.w600 : FontWeight.bold,
              color: currentTab == 999999
                  ? Colors.black
                  : currentTab == tab
                      ? Colors.black
                      : Colors.grey),
        ));
  }
}
