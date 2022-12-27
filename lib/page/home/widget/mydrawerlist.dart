// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sneakers_inc/data/model_products.dart';
import 'package:sneakers_inc/data/model_wishlists.dart';
import 'package:sneakers_inc/page/cart/cart_page.dart';
import 'package:sneakers_inc/page/login/login_page.dart';
import 'package:get/get.dart';
import 'package:sneakers_inc/page/wishlists/wishlist_page.dart';

class MyDrawerList extends StatelessWidget {
  const MyDrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: Icon(Icons.logout_outlined),
                  ),
                  Expanded(
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(CartPage());
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: Icon(Icons.shopping_cart_rounded),
                  ),
                  Expanded(
                    child: Text('Cart'),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(WishlistsPage());
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: Icon(Icons.favorite_rounded),
                  ),
                  Expanded(
                    child: Text('Wishlist'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
