import 'package:jewellery_shopping_app/users/Authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jewellery_shopping_app/users/fragments/dashboard_of_fragments.dart';
import 'package:jewellery_shopping_app/users/userPerfrences/ueer_prefrences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jewellery Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FutureBuilder(
        //future call or read the useInfo from UserPrefrences page the show the user info
        //also we called the readUserInfor method from RememberUserPref class to read the User Info
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.data == null) {
            return LoginScreen();
          } else {
            return DashboardOfFragments();
          }
        },
      ),
    );
  }
}
