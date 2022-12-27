// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sneakers_inc/global_controller.dart';
import 'package:sneakers_inc/page/home/home_page.dart';
import 'package:sneakers_inc/page/order_history/order_history.dart';

class HomeNavbarButton extends StatelessWidget {
  final gstate = Get.put(GlobalController());
  HomeNavbarButton({
    Key? key,
  }) : super(key: key);

  final List<Widget> _children = [
    const HomePage(),
    const OrderHistoryPage(),
  ];

  void onTabTapped(int index) {
    gstate.tabHomeIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _children[gstate.tabHomeIndex.toInt()]), //
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xffAFE98B),
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex: gstate.tabHomeIndex.toInt(),
          items: [
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                label: 'Home',
                activeIcon: Icon(Icons.home, color: Color(0xffAFE98B))),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.history,
                color: Colors.black,
              ),
              label: 'History',
              activeIcon: Icon(Icons.history, color: Color(0xffAFE98B)),
            ),
          ],
        ),
      ),
    );
  }
}
