import 'package:get/get.dart';
import 'package:jewellery_shopping_app/users/model/user.dart';
import 'package:jewellery_shopping_app/users/userPerfrences/ueer_prefrences.dart';

class CurrentUser extends GetxController {
  Rx<User> _CurrentUser = User('', '', '').obs;

  User get user => _CurrentUser.value;

  //method for get user info
  getUserInfo() async {
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _CurrentUser.value = getUserInfoFromLocalStorage!;
  }
}
