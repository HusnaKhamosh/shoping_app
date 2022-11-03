import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jewellery_shopping_app/users/fragments/favorites_fragment_screen.dart';
import 'package:jewellery_shopping_app/users/fragments/home_fragment_screen.dart';
import 'package:jewellery_shopping_app/users/fragments/order_fragment_screen.dart';
import 'package:jewellery_shopping_app/users/fragments/profile_fragment_screen.dart';
import 'package:jewellery_shopping_app/users/userPerfrences/current_user.dart';

class DashboardOfFragments extends StatelessWidget {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  final List<Widget> _fragmentScreens = [
    HomeFragmentScreen(),
    FavoritesFragmentScreen(),
    OrderFragmentScreen(),
    ProfileFragmentScreen(),
  ];

  final List _navigationButtonsProperties = [
    //Home Properties
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_max_outlined,
      "label": "Home",
    },

    //Favorites Properties
    {
      "active_icon": Icons.favorite,
      "non_active_icon": Icons.favorite_border,
      "label": "Favorites",
    },

    //Orders Properties
    {
      "active_icon": FontAwesomeIcons.boxOpen,
      "non_active_icon": FontAwesomeIcons.box,
      "label": "Orders",
    },

    //Profile Properties
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outline,
      "label": "Profile",
    },
  ];

  RxInt _IndexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (conteroller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Obx(
              () => _fragmentScreens[_IndexNumber.value],
            ),
          ),
          bottomNavigationBar: Obx(
            //for making the bottom Navigation bar
            () => BottomNavigationBar(
              currentIndex: _IndexNumber.value,
              onTap: (value) {
                _IndexNumber.value = value;
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white24,
              items: List.generate(4, (index) {
                var navBtnProperty = _navigationButtonsProperties[index];
                return BottomNavigationBarItem(
                  backgroundColor: Color.fromARGB(255, 223, 151, 191),
                  icon: Icon(navBtnProperty["non_active_icon"]),
                  activeIcon: Icon(navBtnProperty["active_icon"]),
                  label: navBtnProperty["label"],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
