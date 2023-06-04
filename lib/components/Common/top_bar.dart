import 'package:bookeat/screens/Admin/homescreen.dart';
import 'package:bookeat/screens/Client/clientProfile.dart';
import 'package:bookeat/screens/Client/homescreen.dart';
import 'package:bookeat/screens/Restaurant/homescreen.dart';
import 'package:bookeat/screens/Restaurant/restaurantProfile.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, required this.userType});

  final String title;
  final String userType;

  goToCustomProfile(context) {
    if (userType == "client") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ClientProfileScreen(),
        ),
      );
    } else if (userType == "restaurant") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const RestaurantProfileScreen(),
        ),
      );
    }
  }

  goBack(context) {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  goToHomeScreen(context) {
    if (userType == "admin") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const AdminHomeScreen();
      }));
    }
    if (userType == "client") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const ClientHomeScreen();
      }));
    }
    if (userType == "restaurant") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const RestaurantHomeScreen();
      }));
    }
  }

  goToCommandHistory() {
    return Container();
  }

  goToCommandToValidate() {
    return Container();
  }

  restaurantTools() {
    return Row(children: [
      IconButton(onPressed: goToCommandHistory(), icon: const Icon(Icons.abc)),
      IconButton(
          onPressed: goToCommandToValidate(), icon: const Icon(Icons.abc))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: IconButton(
        onPressed: () => goToHomeScreen(context),
        icon: const Image(
          image: AssetImage("lib/assets/BookEat_2.png"),
          height: 70,
        ),
      ),
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () => goBack(context),
              icon: const Icon(Icons.arrow_back))
          : null,
      backgroundColor: const Color(0xffffc107),
      actions: userType == "admin"
          ? null
          : <Widget>[
              userType == "restaurant"
                  ? Row(children: [
                      IconButton(
                          onPressed: () => goToCommandHistory(),
                          icon: const Icon(Icons.task_outlined)),
                      IconButton(
                          onPressed: () => goToCommandToValidate(),
                          icon: const Icon(Icons.history_outlined))
                    ])
                  : Container(),
              IconButton(
                  onPressed: () => goToCustomProfile(context),
                  icon: const Icon(Icons.account_circle))
            ],
      actionsIconTheme: const IconThemeData(size: 40, opacity: 1),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
