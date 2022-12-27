import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers_inc/page/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _handPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isShow = false;
  bool isShow2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffAFE98B),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
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
                  controller: _handPhoneController,
                  decoration: InputDecoration(
                    labelText: 'Handphone',
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password Confirmation',
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
                  register();
                },
                child: Text('Sign Up'),
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
        ],
      ),
    );
  }

  Future<void> register() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (_passwordController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _handPhoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      if (_passwordController.text == _confirmPasswordController.text) {
        try {
          final response = await http.post(
            Uri.parse('https://api1.sib3.nurulfikri.com/api/register'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'name': _usernameController.text,
              'email': _emailController.text,
              'handphone': _handPhoneController.text,
              'password': _passwordController.text,
              'password_confirmation': _confirmPasswordController.text
            }),
          );

          print(response.statusCode);

          if (response.statusCode >= 200 && response.statusCode < 400) {
            print('Connection OK');
            print(response.body);
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Akun Berhasil Dibuat")));
            // SharedPreferences pref = await SharedPreferences.getInstance();
            Get.offAll(const LoginPage());
            // Get.offAll(const EnableLocationPage());
          } else {
            // print('Connection Failed');
            print("Akun Gagal dibuat");
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Koneksi")));
          }
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Harap isi semua form")));
        }
      }
      // await pref.setString("username", _usernameController.text);
      // await pref.setString("password", _passwordController.text);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Your Account Has Been Created")));
      // Get.to(const LoginPage());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Harap isi semua form")));
    }
  }
}
