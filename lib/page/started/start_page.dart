// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sneakers_inc/page/login/login_page.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.black, BlendMode.softLight),
                fit: BoxFit.cover,
                image: AssetImage('assets/bg1.jpg'),
              ),
            ),
          ),
          Positioned.fill(
            top: 100,
            left: 20,
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Comfort your foot',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 37,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'with our shoes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 37,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: 70,
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Get Started',
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(149, 40),
                        foregroundColor: Colors.black,
                        backgroundColor: Color.fromARGB(255, 195, 195, 195),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
