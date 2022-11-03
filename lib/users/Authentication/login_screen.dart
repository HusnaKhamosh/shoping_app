import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jewellery_shopping_app/Admin/admin_login.dart';
import 'package:jewellery_shopping_app/api_connection/api_connection.dart';
import 'package:jewellery_shopping_app/users/Authentication/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:jewellery_shopping_app/users/fragments/dashboard_of_fragments.dart';
import 'package:jewellery_shopping_app/users/model/user.dart';
import 'package:jewellery_shopping_app/users/userPerfrences/ueer_prefrences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  //var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  //boolean tag for hidding password
  var isObssecure = true.obs;

  loginUserNow() async {
    try {
      var response = await http.post(Uri.parse(API.login), body: {
        //"User_Name": userNameController.text.trim(),
        "Email": emailController.text.trim(),
        "Password": passwordController.text.trim(),
      });

      if (response.statusCode == 200) {
        var responseBodyOfLogin = jsonDecode(response.body);

        if (responseBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(
              msg: "Congratulations, You are Logged in Successfully!");

          User UserInfo = User.fromJson(responseBodyOfLogin["userData"]);

          //Save User Info to local storage Using Shared Prefrences
          await RememberUserPrefs.storeUserInfo(UserInfo);

          //send User To Dashboard Fragments page
          Future.delayed(Duration(milliseconds: 2000), () {
            Get.to(DashboardOfFragments());
          });
        } else {
          Fluttertoast.showToast(
              msg: "Please Write Correct Email or Password!");
        }
      }
    } catch (errorMsg) {
      print("Error ::" + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 223, 151, 191),
        body: LayoutBuilder(
          builder: (context, cons) {
            var formKey;
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: cons.maxHeight,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //LoginScreen Header

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 285,
                      child: Image.asset(
                        "images/login.jpg",
                      ),
                    ),
                    //login screen sign in form

                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, -3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                          child: Column(
                            children: [
                              //UserName Email and password and login button
                              Form(
                                child: Column(
                                  children: [
                                    //UserName
                                    //  TextFormField(
                                    //    controller: userNameController,
                                    //    validator: (value) => value == ""
                                    //        ? "Please Write Your Name!"
                                    //        : null,
                                    //    decoration: InputDecoration(
                                    //      prefixIcon: const Icon(
                                    //        Icons.person,
                                    //        color: Colors.black,
                                    //      ),
                                    //      hintText: "User Name....",
                                    //      border: OutlineInputBorder(
                                    //        borderRadius:
                                    //            BorderRadius.circular(30),
                                    //        borderSide: const BorderSide(
                                    //          color: Colors.white60,
                                    //        ),
                                    //      ),
                                    //      enabledBorder: OutlineInputBorder(
                                    //        borderRadius:
                                    //            BorderRadius.circular(30),
                                    //        borderSide: const BorderSide(
                                    //          color: Colors.white60,
                                    //        ),
                                    //      ),
                                    //      focusedBorder: OutlineInputBorder(
                                    //        borderRadius:
                                    //            BorderRadius.circular(30),
                                    //        borderSide: const BorderSide(
                                    //          color: Colors.white60,
                                    //        ),
                                    //     ),
                                    //      disabledBorder: OutlineInputBorder(
                                    //        borderRadius:
                                    //            BorderRadius.circular(30),
                                    //        borderSide: const BorderSide(
                                    //          color: Colors.white60,
                                    //        ),
                                    //      ),
                                    //      contentPadding:
                                    //          const EdgeInsets.symmetric(
                                    //        horizontal: 14,
                                    //        vertical: 6,
                                    //      ),
                                    //      fillColor: Colors.white,
                                    //      filled: true,
                                    //    ),
                                    //  ),
                                    //  const SizedBox(
                                    //    height: 18,
                                    //  ),
                                    //email
                                    TextFormField(
                                      controller: emailController,
                                      validator: (value) => value == ""
                                          ? "Please Write Your Email!"
                                          : null,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.email,
                                          color: Colors.black,
                                        ),
                                        hintText: "email....",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    //Password
                                    Obx(
                                      () => TextFormField(
                                        obscureText: isObssecure.value,
                                        controller: passwordController,
                                        validator: (value) => value == ""
                                            ? "Please Write Your Password!"
                                            : null,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.vpn_key_off_sharp,
                                            color: Colors.black,
                                          ),
                                          //Icon for hidding password
                                          suffixIcon: Obx(
                                            () => GestureDetector(
                                              onTap: () {
                                                isObssecure.value =
                                                    !isObssecure.value;
                                              },
                                              child: Icon(
                                                isObssecure.value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          hintText: "Password....",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 6,
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 18,
                                    ),
                                    //login button

                                    Material(
                                      color: Color.fromARGB(255, 223, 151, 191),
                                      borderRadius: BorderRadius.circular(30),
                                      child: InkWell(
                                        onTap: () {
                                          //if (formKey.currentState!
                                          //   .validate()) {
                                          //  loginUserNow();
                                          // }
                                          loginUserNow();
                                        },
                                        borderRadius: BorderRadius.circular(30),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 28,
                                          ),
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 16,
                              ),
                              //dont have and account and signup TextButton
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account?"),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(SignUpScreen());
                                    },
                                    child: const Text(
                                      "SignUp Here",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Text(
                                "Or",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 223, 151, 191),
                                  fontSize: 16,
                                ),
                              ),
                              //Are You and admin Admin
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Are You and Admine?"),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(AdminLoginScreen());
                                    },
                                    child: const Text(
                                      "Click Here",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
