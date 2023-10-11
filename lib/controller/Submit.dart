// ignore_for_file: avoid_print, unused_local_variable, file_names

import 'package:get/get.dart';

Map<String, String> db = {'phan': '1234'};

class Submit extends GetxController {
  void sub(String username, String password) {
    final hasKey = db.containsKey(username);
    final valofKey = db['phan'];
    if (hasKey == true && valofKey == password) {
      print('Login Success');
      print(username);
      print(password);
    } else {
      print('Login Failed');
      print(username);
      print(password);
      print(hasKey);
    }
  }
}
