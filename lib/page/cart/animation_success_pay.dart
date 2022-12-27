// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sneakers_inc/page/home/home_page.dart';
import 'package:sneakers_inc/page/home/widget/home_navbar.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: LottieBuilder.asset('assets/payment.json'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Payment Successful!',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text('Thanks for your order. We hope you enjoy it'),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Color(0xffAFE98B),
                foregroundColor: Colors.black,
                minimumSize: Size(193, 40),
              ),
              onPressed: () {
                backHome();
                Get.offAll(HomeNavbarButton());
              },
              child: Text('Back to home'),
            ),
          ],
        ),
      ),
    );
  }

  void backHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false);
  }
}
