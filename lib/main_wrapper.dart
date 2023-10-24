import 'dart:async';

// import 'dart:developer';

import 'package:project/controller/main_wrapper_controller.dart';
import 'package:project/controller/profile_controller.dart';
import 'package:project/services/bandservice.dart';
import 'package:project/utils/color.constants.dart';
// import 'package:project/view/home_tab.dart';
// import 'package:project/view/band_tab.dart';
// import 'package:project/view/home_tab.dart';
// import 'package:project/view/message_tab.dart';
// import 'package:project/view/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project/view/noification_page.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// import 'controller/bands_controller.dart';

// import 'controller/tabbar_controller.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  // final ProfileController profileController = Get.find();
  // // ! อันเดิม
  // final BandsController bandController = Get.put(BandsController());
  // final ProfileController profileController = Get.put(ProfileController());
  // final BandsController bandController = Get.find<BandsController>();
  // final ProfileController profileController = Get.find<ProfileController>();
  @override
  void initState() {
    Get.put(BandService()).init();
    // _mainWrapperController.checkBand();
    // bandController.checkBand();
    // profileController.getProfile();
    super.initState();
  }

  // final TabBarController _tabBarController = Get.put(TabBarController());
  @override
  Widget build(BuildContext context) {
    final BandService bandService = Get.find<BandService>();
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: ColorConstants.appColors,
        toolbarHeight: double.parse("70"),
        // elevation: 5,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              // color: Colors.amber,
              IconButton(
                onPressed: () {
                  Get.to(
                    const NotificationPage(),
                    transition: Transition.upToDown,
                  );
                },
                icon: const Icon(
                  IconlyBold.notification,
                ),
                splashColor: Colors.transparent, // สีเมื่อถูกแตะ
                highlightColor: Colors.transparent,
              ),

              Positioned(
                right: 5, // Adjust the position as needed
                top: 10, // Adjust the position as needed
                child: Container(
                    height: 20.0,
                    width: 20.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Center(
                        child: Obx(() => Text(
                              bandService.notificationController.notis.length
                                  .toString(), // Replace with your desired number
                              style: TextStyle(
                                color: ColorConstants.appColors, // Text color
                                fontWeight: FontWeight.bold,
                              ),
                            )))),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              _mainWrapperController.logOut();
            },
            icon: Icon(
              IconlyBold.logout,
              color: ColorConstants.unfollow,
            ),
            splashColor: Colors.transparent, // สีเมื่อถูกแตะ
            highlightColor: Colors.transparent,
          ),
          Obx(
            () => Switch.adaptive(
              value: _mainWrapperController.isDarkTheme.value,
              onChanged: (newVal) {
                _mainWrapperController.isDarkTheme.value = newVal;
                _mainWrapperController
                    .switchTheme(newVal ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          )
        ],
      ),
      body: PageView(
        controller: _mainWrapperController.pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: _mainWrapperController.animateToTab,
        children: [..._mainWrapperController.pages],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        elevation: 40,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: Obx(
            () => Row(
              mainAxisAlignment:
                  (bandService.profileController.profileList.isNotEmpty &&
                          bandService.profileController.profileList[0]
                                  .userPosition !=
                              "none")
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.spaceAround,
              children: [
                _bottomAppBarItem(
                  context,
                  icon: IconlyLight.home,
                  page: 0,
                  label: "Home",
                ),
                //  Spacer(),  // Use Spacer to distribute space evenly
                if (bandService.profileController.profileList.isNotEmpty &&
                    bandService.profileController.profileList[0].userPosition !=
                        "none")
                  _bottomAppBarItem(
                    context,
                    icon: IconlyLight.user_1,
                    page: 1,
                    label: "Band",
                  ),
                _bottomAppBarItem(
                  context,
                  icon: IconlyLight.search,
                  page: 2,
                  label: "Search",
                ),
                _bottomAppBarItem(
                  context,
                  icon: IconlyLight.profile,
                  page: 3,
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// ! Widget
  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () {
        _mainWrapperController.goToTab(page);
        print(page.toString());
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _mainWrapperController.currentPage.value == page
                  ? ColorConstants.appColors
                  : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                  color: _mainWrapperController.currentPage.value == page
                      ? ColorConstants.appColors
                      : Colors.grey,
                  fontSize: 13,
                  fontWeight: _mainWrapperController.currentPage.value == page
                      ? FontWeight.bold
                      : null),
            )
          ],
        ),
      ),
    );
  }
}
