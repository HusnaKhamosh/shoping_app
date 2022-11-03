import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jewellery_shopping_app/users/Authentication/login_screen.dart';
import 'package:jewellery_shopping_app/users/userPerfrences/current_user.dart';
import 'package:jewellery_shopping_app/users/userPerfrences/ueer_prefrences.dart';

class ProfileFragmentScreen extends StatelessWidget {
//this instance for access information of user that is already logged in from current_user.dart page
  final CurrentUser _currentUser = Get.put(CurrentUser());

  //method for logout(delete the UserInfo from localStorage)
  signOutUser() async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "LogOut",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are You Sure?\nYou want to LogOut from App!",
        ),
        actions: [
          //Button For NO
          TextButton(
            onPressed: () {
              //get.back meanst close the dialog box
              Get.back();
            },
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),

          //Button For Yes
          TextButton(
            onPressed: () {
              //get.back meanst close the dialog box alos it has an response in result that is LoggedOut
              Get.back(result: "LoggedOut!");
            },
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );

    if (resultResponse == "LoggedOut!") {
      //remove user data from Phone LocalStorage
      RememberUserPrefs.removeUserInfo().then((value) {
        Get.off(LoginScreen());
      });
    }
  }

  //this widget is for reusable codes like function
  Widget userInfoItemProfile(IconData iconData, String userData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Color.fromARGB(255, 223, 151, 191),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32),
      children: [
        Center(
          child: Image.asset(
            "images/woman.png",
            width: 240,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        //called the icon and user name from  that function on the Up of the Page
        userInfoItemProfile(Icons.person, _currentUser.user.User_Name),

        const SizedBox(
          height: 20,
        ),

        userInfoItemProfile(Icons.email, _currentUser.user.Email),

        const SizedBox(
          height: 20,
        ),
        //Logout Button
        Center(
          child: Material(
            color: Color.fromARGB(255, 223, 151, 191),
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {
                signOutUser();
              },
              borderRadius: BorderRadius.circular(32),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
