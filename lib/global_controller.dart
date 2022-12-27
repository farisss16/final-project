import 'dart:developer';
import 'package:get/get.dart';

import 'page/login/profile.dart';

class GlobalController extends GetxController {
  final tabHomeIndex = 0.obs;
  final address = "Jalan sigura gura".obs;
  final user = Profile(email: "", name: "", id: 0, handphone: "").obs;
  Future<GlobalController> init() async {
    return this;
  }

  static GlobalController get to => Get.find();

  final _isDark = false.obs;
  get isDark => _isDark.value;
  void switchTheme() {
    _isDark.value = !_isDark.value;
    log(_isDark.value.toString());
  }

  String token = '';
  String username = '';
  String phone = '';
  String profileImage = '';
  String idEdit = "3f89794e-f10d-497d-bd80-f7ab15bdd406";
  bool isDev = false;

  double latitude = 0.0;
  double longitude = 0.0;
}
