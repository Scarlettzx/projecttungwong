// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project/controller/Video_wrap_controller.dart';
import 'package:project/view/contentScreen.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class VideoTab extends StatelessWidget {
  const VideoTab({super.key});

  static const List<String> videos = [
    'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                // _controller.initializePlayer(videos[index]);
                return ContentScreen(src: videos[index]);
              },
              itemCount: videos.length,
              scrollDirection: Axis.vertical,
            ),

            //for ContentScreen,
          ],
        ),
      ),
    );
  }
}
