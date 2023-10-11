// import 'dart:html';

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
// import 'package:iconly/iconly.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project/pages/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  final token;
  const HomeTab({
    required this.token,
    super.key,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late String email;
  late String username;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token);
    username = jwtDecodeToken['result']['username'];
    print(username);
    // username = jwtDecodeToken['username'];
    // print(username);
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(username),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton.icon(
            onPressed: logOut,
            icon: const Icon(IconlyLight.logout),
            label: const Text('logout'),
          )
        ]),
      ),
    );
  }
}
