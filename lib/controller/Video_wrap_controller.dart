// ignore_for_file: camel_case_types, unnecessary_overrides, annotate_overrides, unused_import, file_names, unused_local_variable, override_on_non_overriding_member, no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';

class Video_wrap_controller extends GetxController {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  late RxString src = ''.obs;
  late bool check = false;

  @override
  void onInit() {
    super.onInit();
    initializePlayer(src.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onClose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
  }

  Future<void> initializePlayer(String src) async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(src));
    await Future.wait([videoPlayerController.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
      autoInitialize: true,
    );

    update();
  }
}
