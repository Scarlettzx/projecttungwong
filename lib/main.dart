import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project/main_wrapper.dart';
// import 'package:project/pages/home_tab.dart';
import 'package:project/pages/login_screen.dart';
import 'package:project/view/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/main_wrapper_controller.dart';
import 'utils/themes.dart';
// import 'package:project/pages/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await GetStorage.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: prefs.getString('token'),
  ));

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, required this.token});
  // const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: Get.put(MainWrapperController()).theme,
      debugShowCheckedModeBanner: false,
      home: (token != null && JwtDecoder.isExpired(token!) == false)
          ?  MainWrapper()
          : const LoginScreen(),
      // home: SplashView(),
    );
  }
}
