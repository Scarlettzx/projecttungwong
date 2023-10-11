// ignore_for_file: file_names
// // ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_full_hex_values_for_flutter_colors, unused_local_variable, unnecessary_import, duplicate_import

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get.dart';
// import 'package:tungwong/controller/Submit.dart';

// class Mybutton extends StatelessWidget {
//   const Mybutton({super.key, required this.user, required this.pass});
//   final String user;
//   final String pass;

//   @override
//   Widget build(BuildContext context) {
//     Submit submitcontroller = Get.put(Submit());
//     return GestureDetector(
//       onTap: () {
//         submitcontroller.sub(user, pass);
//       },
//       child: Container(
//         padding: const EdgeInsets.all(25),
//         margin: const EdgeInsets.symmetric(horizontal: 25),
//         decoration: BoxDecoration(
//             color: Color.fromARGB(204, 0, 134, 243),
//             borderRadius: BorderRadius.circular(30)),
//         child: Center(
//           child: Text(
//             'Sign In',
//             style: TextStyle(color: Colors.black, fontSize: 15),
//           ),
//         ),
//       ),
//     );
//   }
// }
