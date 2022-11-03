import 'dart:convert';

import 'package:jewellery_shopping_app/users/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
  //method for save-remember user Info
  static Future<void> storeUserInfo(User userInfo) async {
    //making the instance of shared prefrences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //in here we say remember the User as loggged in
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  //get-read User Info Method
  static Future<User?> readUserInfo() async {
    User? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");

    //check the userinfo which we get from the localstorage (currentUSer)
    if (userInfo != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = User.fromJson(userDataMap);
    }
    return currentUserInfo;
  }

  //method for removing user data from phone storage (LogOUt)
  static Future<void> removeUserInfo() async {
    // instance of sharedPrefrences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
  }
}
