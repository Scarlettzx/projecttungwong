// // ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:like_button/like_button.dart';
// import 'package:project/controller/comments_controller.dart';
// import 'package:project/controller/posts_controller.dart';
// import 'package:project/controller/profile_controller.dart';
// import 'package:project/utils/config.dart';
// import 'package:project/view/another_profile_tab.dart';
// import 'package:project/view/post_detail.dart';

// class Mypost_v2 extends StatefulWidget {
//   const Mypost_v2({
//     super.key,
//     required this.postMessage,
//     required this.userName,
//     required this.postCreateAt,
//     required this.userPosition,
//     required this.userAvatar,
//     required this.userCity,
//     this.userPositionIcon,
//     required this.postid,
//     required this.profileid,
//   });
//   final String postMessage;
//   final String userName;
//   final String postCreateAt;
//   final String userPosition;
//   final String userAvatar;
//   final String userCity;
//   final int postid;
//   final int profileid;

//   final Icon? userPositionIcon;

//   @override
//   State<Mypost_v2> createState() => _Mypost_v2State();
// }

// class _Mypost_v2State extends State<Mypost_v2> {
//   @override
//   Widget build(BuildContext context) {
//     final CommentsController _commentcontroller = Get.put(CommentsController());
//     final PostsController _postsController = Get.put(PostsController());
//     final ProfileController _profilecontroller = Get.put(ProfileController());
//     // final profileid = _profilecontroller.profileid.value = widget.postid;

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(20),
//           child: Container(
//             color: Colors.white,
//             // alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   right: 20, top: 10, left: 20, bottom: 20),
//               child: Column(children: [
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 30),
//                       child: InkWell(
//                         splashColor: Colors.transparent,
//                         highlightColor: Colors.transparent,
//                         onTap: () {
//                           _profilecontroller.profileid.value = widget.profileid;
//                           _profilecontroller.checkfollow();
//                           Get.to(
//                             AnotherProfileTab(
//                               userId: widget.profileid,
//                               userAvatar: widget.userAvatar,
//                               userName: widget.userName,
//                               userPosition: widget.userPosition,
//                               userCountry: widget.userCity,
//                             ),
//                             transition: Transition.downToUp,
//                           );
//                           // print(_controller.posts[reverseindex].createByid
//                           //     .userId.runtimeType);
//                           // print(_controller
//                           //     .posts[reverseindex].createByid.userId);
//                         },
//                         child: CircleAvatar(
//                           backgroundColor: Colors.transparent,
//                           backgroundImage: NetworkImage(
//                               '${Config.getImage}${widget.userAvatar}'),
//                           radius: 30,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             width: 250,
//                             height: 30,
//                             color: Colors.transparent,
//                             child: Stack(children: [
//                               Text(
//                                 widget.userName,
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black),
//                               ),
//                               Positioned(
//                                 right: 20,
//                                 child:
//                                     Container(child: widget.userPositionIcon),
//                               )
//                             ])),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             widget.userPosition,
//                             style:
//                                 TextStyle(fontSize: 14, color: Colors.black54),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             widget.userCity,
//                             style:
//                                 TextStyle(fontSize: 12, color: Colors.black38),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(widget.postMessage),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Divider(
//                   color: Colors.black,
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.favorite_sharp,
//                         color: Colors.black,
//                         size: 30,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         _commentcontroller.postid.value = widget.postid;
//                         print(_commentcontroller.postid.value);
//                         _commentcontroller.getCommentsBypostid();
//                         Get.to(
//                           PostDetail(widget.postMessage),
//                           transition:
//                               Transition.downToUp, // ใช้ transition ตรงนี้
//                         );
//                       },
//                       icon: Icon(
//                         Icons.comment_rounded,
//                         color: Colors.black,
//                         size: 30,
//                       ),
//                     ),
//                     SizedBox(width: 80),
//                     Text(widget.postCreateAt)
//                   ],
//                 )
//               ]),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
