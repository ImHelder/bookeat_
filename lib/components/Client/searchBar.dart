import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Function handleSearchChange;
  final Function searchRestaurant;

  const CustomSearchBar(
      {super.key,
      required this.handleSearchChange,
      required this.searchRestaurant});
  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kIsWeb ? 20.0 : 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: kIsWeb ? const Color(0xFFD9D9D9) : null,
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: kIsWeb ? 1300 : 500,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Flex(
            direction: !kIsWeb ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: 500,
                  child: TextField(
                    onChanged: (text) => widget.handleSearchChange(text),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: Color(0xffffc107),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 30.0, color: Colors.greenAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      label: const Text(
                        "Trouver votre restaurant",
                        style: kIsWeb
                            ? null
                            : TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 60.0),
                    ),
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(Colors.yellow),
                  ),
                  onPressed: () => widget.searchRestaurant("search"),
                  child: const Text('Chercher'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
