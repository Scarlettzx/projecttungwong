import 'package:project/controller/tabbar_controller.dart';
import 'package:project/utils/color.constants.dart';
import 'package:project/view/testpost.dart';
import 'package:project/view/video_tab.dart';
import 'package:project/view/post_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:iconly/iconly.dart';

// import '../controller/main_wrapper_controller.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  // final MainWrapperController _mainWrapperController =
  //     Get.find<MainWrapperController>();
  @override
  Widget build(BuildContext context) {
    final TabBarController tabBarController = Get.put(TabBarController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: double.parse("20"),
          bottom: TabBar(
            controller: tabBarController.controller,
            tabs: tabBarController.tabs,
          ),
          backgroundColor: ColorConstants.appColors,
          elevation: 0,
        ),
        body: Center(
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: tabBarController.controller,
            children: const [
              VideoTab(),
              TestsPostTab(),
            ],
          ),
        ),
      ),
    );
  }
}
