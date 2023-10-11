// ignore_for_file: file_names
// // ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, file_names

// import 'package:flutter/material.dart';

// class MyTextfield extends StatelessWidget {
//   final controller;
//   final String hintText;
//   final bool obscureText;
//   final Widget ic;
//   final String valid;

//   const MyTextfield(  
//       {super.key,
//       required this.controller,
//       required this.hintText,
//       required this.obscureText,
//       required this.ic,
//       required this.valid});

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25.0),
//         child: TextFormField(
//           controller: controller,
//           obscureText: obscureText,
//           decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.black),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey.shade400),
//               ),
//               prefixIcon: ic,
//               fillColor: Colors.grey,
//               filled: true,
//               hintText: hintText),
//           validator: (value) {
//             if (value!.isEmpty || !RegExp(valid).hasMatch(value)) {
//               return 'Please correct a field';
//             } else {
//               return null;
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
