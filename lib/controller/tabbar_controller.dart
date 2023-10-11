import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController
    with SingleGetTickerProviderMixin {
  final List<Tab> tabs = const <Tab>[Tab(text: 'Videos'), Tab(text: 'Posts')];
  late TabController controller;
  @override
  void onInit() {
    super.onInit();
    controller =
        TabController(vsync: this, length: tabs.length, initialIndex: 0);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
