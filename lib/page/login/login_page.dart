import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers_inc/global_controller.dart';
import 'package:sneakers_inc/page/home/home_page.dart';
import 'package:sneakers_inc/page/home/widget/home_navbar.dart';
import 'package:sneakers_inc/page/register/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../services/api_service.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalController cGlobal;
  late LoginController controller;
  final service = ApiService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffAFE98B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      // width: 3,
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      // width: 3,
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_passwordController.text.isNotEmpty &&
                    _emailController.text.isNotEmpty) {
                  loginbyEmail();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Email atau password tidak boleh kosong"),
                    ),
                  );
                }
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: Size(188, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
              child: Text(
                'Create Account?',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              // color: Colors.amber,
              child: Image(
                // width: 300,
                height: 300,
                image: AssetImage('assets/snk1.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginbyEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        Uri.parse('https://api1.sib3.nurulfikri.com/api/login'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          "email": _emailController.text,
          "password": _passwordController.text
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 400) {
        print('Connection OK');
        print(response.body);
        final respStr = response.body;
        var body = jsonDecode(respStr);
        await prefs.setString('user.name', body['data']['user']['name']);
        await prefs.setString('user.id', body['data']['user']['id'].toString());
        await prefs.setString('user.email', body['data']['user']['email']);
        await prefs.setString(
            'user.handphone', body['data']['user']['handphone']);
        await prefs.setString('user.role', body['data']['user']['role']);
        await prefs.setString('token', body['data']['token']);
        var name = prefs.getString("user.name");
        var email = prefs.getString("user.email");
        print(name);
        print(email);
        Get.offAll(const HomePage());
        Get.offAll(HomeNavbarButton());
      } else {
        // print('Connection Failed');
        print("Email atau password tidak tepat");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Email atau password Kurang tepat")));
      }
    } catch (error) {
      print(error);
    }
  }
}

Widget _buildPopupDialog(BuildContext context, String username) {
  return AlertDialog(
    title: const Text('Popup example'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Hello " + username),
      ],
    ),
  );
}
