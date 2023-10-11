import 'package:flutter/widgets.dart';

class MessageTab extends StatefulWidget {
  const MessageTab({super.key});

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (Text("MessageTab")),
    );
  }
}
// // ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:iconly/iconly.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:project/controller/posts_controller.dart';
// import 'package:project/controller/profile_controller.dart';
// import 'package:project/utils/color.constants.dart';
// import 'package:project/view/contentScreen.dart';
// import 'package:project/view/contentScreen_profile.dart';
// import 'package:project/view/showfollowers.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';

// import '../utils/config.dart';

// class MessageTab extends StatefulWidget {
//   const MessageTab({Key? key}) : super(key: key);

//   @override
//   State<MessageTab> createState() => _MessageTabState();
// }
// // late var isloading = true;
// // final ProfileController profileController = Get.put(ProfileController());
// // final ProfileController profileController = Get.find();
// // Map<String, dynamic>? profileDetail; // Declare profileDetail as nullable

// class _MessageTabState extends State<MessageTab> {
//   final ProfileController profileController = Get.find();
//   // late VideoPlayerController videoPlayerController;
//   // ChewieController? chewieController;
//   // static const List<String> videos = [
//   //   'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
//   //   'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
//   //   'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
//   //   'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
//   //   'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
//   //   'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
//   //   'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
//   // ];

//   @override
//   void initState() {
//     super.initState();
//     // Call loadProfileData to fetch the profile data
//     profileController.getProfile();
//     // profileController.profileid.value =
//     //     profileController.profileDetail!['userId'];
//     print("initState ========== follower");
//     profileController.followers();
//     print("initState ========== followings");
//     profileController.following();
//     print("initStatte");
//     print(profileController.personIdList);
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Obx(() {
//       if (profileController.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       } else {
//         final profileDetail = profileController.profileDetail?.value;
//         if (profileDetail != null) {
//           return Stack(
//             fit: StackFit.expand,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     // gradient: LinearGradient(
//                     //   colors: [
//                     //     Color.fromRGBO(4, 9, 35, 1),
//                     //     Color.fromRGBO(39, 105, 171, 1),
//                     //   ],
//                     //   begin: FractionalOffset.bottomCenter,
//                     //   end: FractionalOffset.topCenter,
//                     // ),
//                     color: Colors.white),
//               ),
//               Scaffold(
//                 backgroundColor: Colors.transparent,
//                 body: SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 13),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 20,
//                         ),
//                         SizedBox(
//                           height: 22,
//                         ),
//                         Container(
//                           height: height * 0.43,
//                           child: LayoutBuilder(
//                             builder: (context, constraints) {
//                               double innerHeight = constraints.maxHeight;
//                               double innerWidth = constraints.maxWidth;
//                               return Stack(
//                                 fit: StackFit.expand,
//                                 children: [
//                                   Positioned(
//                                     bottom: 0,
//                                     left: 0,
//                                     right: 0,
//                                     child: Container(
//                                       height: innerHeight * 0.72,
//                                       width: innerWidth,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(30),
//                                         color: Colors.grey[300],
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           SizedBox(
//                                             height: 80,
//                                           ),
//                                           Text(
//                                             profileDetail['userName'],
//                                             style: TextStyle(
//                                               fontSize: 25,
//                                             ),
//                                           ),
//                                           Text(
//                                             'City : ${profileDetail['userCountry']}',
//                                             style: TextStyle(
//                                               fontSize: 15,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Position : ${profileDetail['userPosition']}',
//                                             style: TextStyle(
//                                               fontSize: 15,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 5,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Column(
//                                                 children: [
//                                                   Ink(
//                                                     child: InkWell(
//                                                       onTap: () {
//                                                         print(
//                                                             'followersbutton');
//                                                         // print(profileController.personIdList);
//                                                         profileController
//                                                                 .selectedList
//                                                                 .value =
//                                                             'followers';
//                                                         print(profileController
//                                                             .selectedList
//                                                             .value);
//                                                         Get.to(
//                                                           () => ShowFollowers(),
//                                                           transition: Transition
//                                                               .downToUp,
//                                                         );
//                                                       },
//                                                       child: Text(
//                                                         'Follower',
//                                                         style: TextStyle(
//                                                           color:
//                                                               Colors.grey[700],
//                                                           fontFamily: 'Nunito',
//                                                           fontSize: 25,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     profileController
//                                                         .countFollowers
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                       color: Color.fromRGBO(
//                                                           39, 105, 171, 1),
//                                                       fontFamily: 'Nunito',
//                                                       fontSize: 25,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                   horizontal: 25,
//                                                   vertical: 8,
//                                                 ),
//                                                 child: Container(
//                                                   height: 50,
//                                                   width: 3,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             100),
//                                                     color: Colors.grey,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Column(
//                                                 children: [
//                                                   Ink(
//                                                     child: InkWell(
//                                                       onTap: () {
//                                                         // print(profileController.following());
//                                                         print(
//                                                             'followeringbutton');
//                                                         // print(profileController.personIdList);
//                                                         profileController
//                                                                 .selectedList
//                                                                 .value =
//                                                             'following';
//                                                         print(profileController
//                                                             .selectedList
//                                                             .value);
//                                                         Get.to(
//                                                           () => ShowFollowers(),
//                                                           transition: Transition
//                                                               .downToUp,
//                                                         );
//                                                       },
//                                                       child: Text(
//                                                         'Following',
//                                                         style: TextStyle(
//                                                           color:
//                                                               Colors.grey[700],
//                                                           fontFamily: 'Nunito',
//                                                           fontSize: 25,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     profileController
//                                                         .countFollowing
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                       color: Color.fromRGBO(
//                                                           39, 105, 171, 1),
//                                                       fontFamily: 'Nunito',
//                                                       fontSize: 25,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 0,
//                                     left: 0,
//                                     right: 0,
//                                     child: Center(
//                                       child: Image.network(
//                                         '${Config.getImage}${profileDetail['userAvatar']}',
//                                         width: innerWidth * 0.3,
//                                         fit: BoxFit.fitWidth,
//                                       ),
//                                       // child: Container(
//                                       //   child: Image.asset(
//                                       //     'assets/img/profile.png',
//                                       //     width: innerWidth * 0.45,
//                                       //     fit: BoxFit.fitWidth,
//                                       //   ),
//                                       // ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Container(
//                           width: width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                             color: Colors.white,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 15),
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Text(
//                                   'Reel',
//                                   style: TextStyle(
//                                     color: Color.fromRGBO(39, 105, 171, 1),
//                                     fontSize: 27,
//                                     fontFamily: 'Nunito',
//                                   ),
//                                 ),
//                                 Divider(
//                                   thickness: 2.5,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // Row(children: [
//                         //   Container(
//                         //     width: MediaQuery.of(context).size.width - 32,
//                         //     color: Colors.green,
//                         //     child: ListView.separated(
//                         //       separatorBuilder: (context, index) => SizedBox(
//                         //         height: 10, // ระยะห่างระหว่างวิดีโอ
//                         //       ),
//                         //       shrinkWrap: true, // ตั้งค่า shrinkWrap เป็น true
//                         //       physics:
//                         //           NeverScrollableScrollPhysics(), // ไม่อนุญาตให้ scroll
//                         //       itemCount: videos.length,
//                         //       itemBuilder: (context, index) {
//                         //         return Row(children: [
//                         //           Container(
//                         //             width:
//                         //                 MediaQuery.of(context).size.width / 3,
//                         //             height:
//                         //                 MediaQuery.of(context).size.width / 2,
//                         //             margin: EdgeInsets.all(8.0),
//                         //             color: Colors.black,
//                         //             // child:
//                         //             //     ContentScreenprofile(src: videos[index])
//                         //           ),
//                         //         ]);
//                         //       },
//                         //     ),
//                         //   ),
//                         // ])
//                         // ! video
//                         // SizedBox(
//                         //     height: MediaQuery.of(context).size.height,
//                         //     child: GridView.builder(
//                         //         itemCount: videos.length,
//                         //         gridDelegate:
//                         //             SliverGridDelegateWithFixedCrossAxisCount(
//                         //                 crossAxisCount: 3,
//                         //                 mainAxisSpacing: 5,
//                         //                 crossAxisSpacing: 5,
//                         //                 childAspectRatio: 9 / 16),
//                         //         physics: NeverScrollableScrollPhysics(),
//                         //         itemBuilder: (context, index) {
//                         //           return ContentScreenprofile(
//                         //               src: videos[index]);
//                         //         })),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           );
//         } else {
//           return Text('No profile data available.');
//         }
//       }
//     });
//   }
// }

// // return ListView(
// //   children: [
// //     Stack(
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.only(top: 15),
// //           child: Align(
// //             alignment: Alignment.topCenter,
// //             child: Container(
// //               height: 100.0,
// //               width: 100.0,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(50.0),
// //                 image: DecorationImage(
// //                   image: NetworkImage(
// //                       '${Config.getImage}${profileDetail['userAvatar']}'),
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //         Positioned(
// //           left: 225.0,
// //           top: 90,
// //           child: InkWell(
// //             splashColor: Colors.transparent,
// //             highlightColor: Colors.transparent,
// //             onTap: () {},
// //             child: Container(
// //               height: 25.0,
// //               width: 25.0,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(15),
// //                 color: Colors.white,
// //               ),
// //               child: Icon(
// //                 IconlyBold.edit,
// //                 color: ColorConstants.appColors,
// //               ),
// //             ),
// //           ),
// //         )
// //       ],
// //     ),
// //     Column(
// //       children: [
// //         const SizedBox(
// //           height: 20.0,
// //         ),
// //         Text(profileDetail['userName']), // Use profileDetail
// //         Text(profileDetail['userPosition']), // Use profileDetail
// //         Text(profileDetail['userCountry']), // Use profileDetail
// //         Obx(() => Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 // ! followers
// //                 Ink(
// //                   width: 70,
// //                   height: 50,
// //                   child: InkWell(
// //                     borderRadius:
// //                         BorderRadius.all(Radius.circular(20)),
// //                     splashColor: ColorConstants.gray100,
// //                     highlightColor: Colors.transparent,
// //                     onTap: () {
// //                       print('followersbutton');
// //                       // print(profileController.personIdList);
// //                       profileController.selectedList.value =
// //                           'followers';
// //                       Get.to(
// //                         () => ShowFollowers(),
// //                         transition: Transition.downToUp,
// //                       );
// //                     },
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Text(profileController.countFollowers
// //                             .toString()),
// //                         Text(
// //                           'followers',
// //                           style:
// //                               Theme.of(context).textTheme.bodyLarge,
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //                 const Align(
// //                   alignment: Alignment.center,
// //                   child: SizedBox(
// //                     width: 20,
// //                     child: Text(
// //                       '|',
// //                       textAlign: TextAlign
// //                           .center, // ตั้งค่าการจัดวางให้เป็นกลาง
// //                       style: TextStyle(
// //                         fontSize: 20,
// //                         // fontWeight: FontWeight.w600,
// //                         // ปรับขนาดตามความต้องการ
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 Ink(
// //                   width: 70,
// //                   height: 50,
// //                   child: InkWell(
// //                     borderRadius:
// //                         BorderRadius.all(Radius.circular(20)),
// //                     splashColor: ColorConstants.gray100,
// //                     highlightColor: Colors.transparent,
// //                     onTap: () {
// //                       // print(profileController.following());
// //                       print('followeringbutton');
// //                       // print(profileController.personIdList);
// //                       profileController.selectedList.value =
// //                           'following';
// //                       Get.to(
// //                         () => ShowFollowers(),
// //                         transition: Transition.downToUp,
// //                       );
// //                     },
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Text(profileController.countFollowing
// //                             .toString()),
// //                         Text(
// //                           'follwing',
// //                           style:
// //                               Theme.of(context).textTheme.bodyLarge,
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 )
// //               ],
// //             )),
// //       ],
// //     ),
// //   ],
// // );
