import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jewellery_shopping_app/api_connection/api_connection.dart';
import 'package:jewellery_shopping_app/users/model/products.dart';
import 'package:http/http.dart' as http;

class HomeFragmentScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  Future<List<Products>> getTrendingProducts() async {
    List<Products> trendingProductItemList = [];

    try {
      var res = await http.post(Uri.parse(API.getTrendingMostPopulerProducts));
      if (res.statusCode == 200) {
        var responsBodyOfTrending = jsonDecode(res.body);
        if (responsBodyOfTrending["success"] == true) {
          (responsBodyOfTrending["ItemData"] as List).forEach((eachRecord) {
            trendingProductItemList.add(Products.fromJson(eachRecord));
          });
        }
      } else {
        Fluttertoast.showToast(msg: 'Status code is not 200');
      }
    } catch (errorMsg) {
      print("Error: " + errorMsg.toString());
    }
    return trendingProductItemList;
  }

  Future<List<Products>> getAllProducts() async {
    List<Products> AllProductItemList = [];

    try {
      var res = await http.post(Uri.parse(API.getAllProducts));
      if (res.statusCode == 200) {
        var responsBodyOfAllProducts = jsonDecode(res.body);
        if (responsBodyOfAllProducts["success"] == true) {
          (responsBodyOfAllProducts["ItemData"] as List).forEach((eachRecord) {
            AllProductItemList.add(Products.fromJson(eachRecord));
          });
        }
      } else {
        Fluttertoast.showToast(msg: 'Status code is not 200');
      }
    } catch (errorMsg) {
      print("Error: " + errorMsg.toString());
    }
    return AllProductItemList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 16,
          ),
          // =====search bar =====
          showSearchBarWidget(),

          const SizedBox(
            height: 26,
          ),
          // =====Trending Items ======
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Trending",
              style: TextStyle(
                color: Color.fromARGB(255, 223, 151, 191),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),

          trendingMostPopulerProductWidget(context),

          const SizedBox(
            height: 24,
          ),
          // =====all new Items Items/Collection ======

          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "New Collection",
              style: TextStyle(
                color: Color.fromARGB(255, 223, 151, 191),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),

          allItemWidget(context),
        ],
      ),
    );
  }

  Widget showSearchBarWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        style: const TextStyle(
          color: Color.fromARGB(255, 223, 151, 191),
        ),
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Color.fromARGB(255, 223, 151, 191),
          ),
          hintText: "Search For Product",
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Color.fromARGB(255, 223, 151, 191),
            ),
            onPressed: () {},
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(255, 223, 151, 191),
          )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(255, 223, 151, 191),
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(255, 223, 151, 191),
          )),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),
    );
  }

  Widget trendingMostPopulerProductWidget(context) {
    return FutureBuilder(
      future: getTrendingProducts(),
      builder: (context, AsyncSnapshot<List<Products>> dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (dataSnapShot.data == null) {
          return Center(
            child: Text("No Trending Item Found!"),
          );
        }
        if (dataSnapShot.data!.length > 0) {
          return Container(
            height: 260,
            child: ListView.builder(
              itemCount: dataSnapShot.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Products eachProductItemData = dataSnapShot.data![index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 200,
                    height: 500,
                    margin: EdgeInsets.fromLTRB(
                      index == 0 ? 16 : 8,
                      10,
                      index == dataSnapShot.data!.length - 1 ? 16 : 8,
                      10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    //item Image
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                          child: FadeInImage(
                            height: 150,
                            width: 200,
                            fit: BoxFit.cover,
                            placeholder: AssetImage("images/place_holder.png"),
                            image: NetworkImage(
                              eachProductItemData.image!,
                            ),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Name and price
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      eachProductItemData.name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    eachProductItemData.price.toString(),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 223, 151, 191),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  //Rating Stars
                                  //Rating Number
                                  RatingBar.builder(
                                    initialRating: eachProductItemData.rating!,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, c) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (UpdateRating) {},
                                    ignoreGestures: true,
                                    unratedColor: Colors.grey,
                                    itemSize: 20,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),

                                  Text(
                                    "(" +
                                        eachProductItemData.rating.toString() +
                                        ")",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text("Empty, No Data"),
          );
        }
      },
    );
  }

  Widget allItemWidget(context) {
    return FutureBuilder(
        future: getAllProducts(),
        builder: (context, AsyncSnapshot<List<Products>> dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapShot.data == null) {
            return Center(
              child: Text("No Trending Item Found!"),
            );
          }
          if (dataSnapShot.data!.length > 0) {
            return ListView.builder(
              itemCount: dataSnapShot.data!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Products eachProducItemRecord = dataSnapShot.data![index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      16,
                      index == dataSnapShot.data!.length - 1 ? 16 : 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 6,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    child: Row(children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(children: [
                            //name and price
                            Row(
                              children: [
                                //name
                                Expanded(
                                  child: Text(
                                    eachProducItemRecord.name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ]),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Empty, No Data"),
            );
          }
        });
  }
}
