import 'package:bookeat/components/Client/Filters.dart';
import 'package:bookeat/components/Client/searchBar.dart';
import 'package:bookeat/components/Common/customCard.dart';
import 'package:bookeat/components/Common/top_bar.dart';
import 'package:bookeat/screens/Client/restaurantScreen.dart';
import 'package:bookeat/utils/fakers.dart';
import 'package:bookeat/utils/helpingFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ClientHomeScreen extends StatefulWidget {
  static const routeName = "/ClientHomeScreen.dart";

  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  onPress(chosenId) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RestaurantPage(restaurantId: chosenId);
    }));
  }

  var searchRestaurantOrAddress = "";
  var selectedPrice = "";
  var selectedCategory = "";
  List<Map<String, Object>> filteredRestaurants = restaurantsData;

  getCategory() {
    return categories
        .firstWhere((category) => category["key"] == selectedCategory)["label"];
  }

  searchRestaurant(type) {
    setState(() {
      var categorizedRestaurant = selectedCategory != ""
          ? restaurantsData
              .where((restaurant) =>
                  restaurant["type"]
                      .toString()
                      .toLowerCase()
                      .contains(getCategory().toLowerCase()) ||
                  restaurant["category"]
                      .toString()
                      .toLowerCase()
                      .contains(getCategory().toLowerCase()))
              .toList()
          : restaurantsData;
      var pricedRestaurant = selectedPrice != ""
          ? categorizedRestaurant
              .where((restaurant) =>
                  restaurant["price"].toString().toLowerCase() ==
                  selectedPrice.toLowerCase())
              .toList()
          : categorizedRestaurant;

      filteredRestaurants = searchRestaurantOrAddress != ""
          ? pricedRestaurant
              .where((restaurant) => (restaurant["name"]
                      .toString()
                      .toLowerCase()
                      .contains(searchRestaurantOrAddress.toLowerCase()) ||
                  restaurant["address"]
                      .toString()
                      .toLowerCase()
                      .contains(searchRestaurantOrAddress.toLowerCase())))
              .toList()
          : pricedRestaurant;
    });
  }

  handleChange(newSearch) {
    setState(() {
      searchRestaurantOrAddress = newSearch;
    });
  }

  handleChangePrice(newSelectPrice) {
    setState(() {
      selectedPrice = newSelectPrice == selectedPrice ? "" : newSelectPrice;
    });
    searchRestaurant("price");
  }

  handleChangeCategory(newSelectedCategory) {
    setState(() {
      selectedCategory =
          newSelectedCategory == selectedCategory ? "" : newSelectedCategory;
    });
    searchRestaurant("category");
  }

  getPrice(price) {
    if (price == "small") return "€";
    if (price == "medium") return "€€";
    return "€€€";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: "", userType: "client"),
      body: Column(
        children: [
          CustomSearchBar(
              handleSearchChange: handleChange,
              searchRestaurant: searchRestaurant),
          Flexible(
            child: Flex(
              direction: !kIsWeb ? Axis.vertical : Axis.horizontal,
              children: [
                SizedBox(
                  width: kIsWeb ? 500 : MediaQuery.of(context).size.width,
                  child: Filters(
                      selectedPrice: selectedPrice,
                      selectedCategory: selectedCategory,
                      handleChangePrice: handleChangePrice,
                      handleChangeCategory: handleChangeCategory),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: filteredRestaurants.length,
                      itemBuilder: (BuildContext context, int index) {
                        return filteredRestaurants.isNotEmpty
                            ? CustomCard(
                                id: filteredRestaurants[index]["id"].toString(),
                                title: filteredRestaurants[index]["name"]
                                    .toString(),
                                description:
                                    "${filteredRestaurants[index]["category"]} - ${filteredRestaurants[index]["type"]} - ${getPrice(filteredRestaurants[index]["price"])}  \n${filteredRestaurants[index]["openingHours"]} \n${filteredRestaurants[index]["address"]}",
                                picture: filteredRestaurants[index]["logoUrl"]
                                    .toString(),
                                leftImageData: filteredRestaurants[index]
                                        ["notation"]
                                    .toString(),
                                onPress: onPress,
                                isChoice: false,
                                onPress2: () {},
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Text(
                                          "Oops, pas de restaurant trouvé"))
                                ],
                              );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
