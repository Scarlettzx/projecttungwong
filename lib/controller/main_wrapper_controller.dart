import 'package:project/controller/bands_controller.dart';
import 'package:project/controller/profile_controller.dart';
import 'package:project/view/band_tab.dart';
import 'package:project/view/report_tab.dart';
import 'package:project/view/search_tab.dart';
import 'package:project/view/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/authentication_manager.dart';
import '../pages/login_screen.dart';
import '../services/bandservice.dart';
import '../view/home_tab.dart';

class MainWrapperController extends GetxController {
  late PageController pageController;
  // final BandService bandService = Get.find<BandService>();
  // late TabController tabController;
  // final AuthenticationManager _authManager = Get.find();

  // ? Varaible for changing index of Bottom AppBar
  // RxInt currentHomeTab = 0.obs;
  RxString token = ''.obs;
  // var isLogged = false.obs;
  RxInt currentPage = 0.obs;
  RxBool isDarkTheme = false.obs;
  // final ProfileController profileController = Get.put(ProfileController());
  // final BandsController bandsController = Get.put(BandsController());
  List<Widget> pages = [
    const HomeTab(),
    const BandTab(),
    const ReportTab(),
    const SearchTab(),
    const ProfileTab(),
  ];
  ThemeMode get theme => Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void switchTheme(ThemeMode mode) {
    Get.changeThemeMode(mode);
  }

  void setToken(String newToken) {
    token.update((value) {
      value = newToken;
      token.value = value;
    });
  }

// // ! checkBand is have or not have
//   Future<void> checkBand() async {
//     await profileController.getProfile();
//     print("profileController.profileList");
//     print(profileController.profileList);
//     print(profileController.profileDetail!['userId']);
//     print(profileController.profileList[0].bandType != "0");
//     if (profileController.profileList[0].bandType != "0") {
//       bandsController.bandid.value = profileController.profileList[0].bandId;
//       print("createBand.value in if checkBand");
//       print(bandsController.createBand.value);
//       print("bandid.value in if checkBand");
//       print(bandsController.bandid.value);
//       bandsController.createBand.value = true;
//       // await getBand();
//       print(bandsController.createBand.value);
//     } else {
//       bandsController.bandid.value = 0;
//       bandsController.isBand.value = false;
//       bandsController.createBand.value = false;
//       print(bandsController.createBand.value);
//     }
//   }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    currentPage.value = 0;
    // _authManager.logOut();
    Get.offAll(const LoginScreen());
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  //! เมื่อเริ่มต้น MainWrapperController จะทำงาน
  void onInit() {
    pageController = PageController(initialPage: 0);
    // Get.put(BandService()).init();
    // profileController.getProfileFromToken();
    super.onInit();
    // bandsController.checkBand();
    // profileController.getProfile();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
