import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCounter extends StatefulWidget {
  final ValueSetter<int> callback;
  final int currentCounter;

  const CustomCounter(
      {super.key, required this.callback, required this.currentCounter});

  @override
  _CustomCounterState createState() {
    return _CustomCounterState();
  }
}

class _CustomCounterState extends State<CustomCounter> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    counter = widget.currentCounter;
  }

  void _incrementCounter() {
    if (counter < 20) {
      setState(() {
        counter++;
        widget.callback(this.counter);
      });
    }
  }

  void _decrementCounter() {
    if (counter > 0) {
      setState(() {
        counter--;
        widget.callback(this.counter);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.black, width: 1.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            mouseCursor: MouseCursor.defer,
            iconSize: 20,
            color: Colors.black,
            icon: const Icon(Icons.remove),
            onPressed: _decrementCounter,
          ),
          const VerticalDivider(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$counter',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          IconButton(
            mouseCursor: MouseCursor.defer,
            iconSize: 20,
            color: Colors.black,
            icon: const Icon(Icons.add),
            onPressed: _incrementCounter,
          ),
        ],
      ),
    );
  }
}
