// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconly/iconly.dart';
// import 'package:project/utils/color.constants.dart';

// import '../controller/profile_controller.dart';
// import '../utils/config.dart';

// class ShowFollowers extends StatelessWidget {
//   ShowFollowers({Key? key}) : super(key: key);
//   final ProfileController profileController = Get.find();
//   Future<void> getSelectedListData() async {
//     if (profileController.selectedList.value == 'followers') {
//       print("SELECT FOLLOWERS");
//       print(profileController.selectedList.value);
//       await profileController.followers();
//     } else {
//       print("SELECT FOLLOWING");
//       print(profileController.selectedList.value);
//       await profileController.following();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('================================================================');
//     print(profileController.selectedList.value);
//     print("showfollowersscreen==============");
//     print(profileController.personIdList);
//     return Scaffold(
//       appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: Icon(
//               IconlyBold.arrow_left_square,
//             ),
//           ),
//           backgroundColor: ColorConstants.appColors,
//           centerTitle: true,
//           title: profileController.selectedList.value == 'followers'
//               ? Text('Followers')
//               : Text('Following')),
//       body: FutureBuilder<void>(
//         // รอให้ข้อมูล profileController.personIdList ถูกอัปเดต
//         future:
//             getSelectedListData(), // หรือ profileController.following() ตามที่เหมาะสม
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // กำลังโหลดข้อมูล แสดง Indicator หรือข้อความ "กำลังโหลด..."
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             // กรณีเกิดข้อผิดพลาด
//             return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
//           } else {
//             // แสดงข้อมูลเมื่อได้รับข้อมูลเสร็จสมบูรณ์
//             return ListView.builder(
//               itemCount: profileController.personIdList.length,
//               itemBuilder: (context, i) {
//                 var reverseindex =
//                     profileController.personIdList.length - 1 - i;
//                 final personIdData =
//                     profileController.personIdList[reverseindex];
//                 // ทำสิ่งที่คุณต้องการด้วยข้อมูล personIdData
//                 return ListTile(
//                   leading: Container(
//                     height: 60.0,
//                     width: 50.0,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(40.0),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                             '${Config.getImage}${personIdData["user_avatar"]}'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   title: Text(personIdData['user_name']),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(personIdData['user_country']),
//                       Text(personIdData['user_position']),
//                     ],
//                   ),
//                   trailing: Text('sss'),
//                   visualDensity: VisualDensity.compact,
//                   // dense: true,
//                   isThreeLine: true,
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
