// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

class Mypost extends StatelessWidget {
  const Mypost(
      {super.key, required this.mText, required this.uId, required this.pTime});
  final String mText;
  final String uId;
  final String pTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[200],
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0),
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                child: Text(uId),
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(pTime,
                  style: TextStyle(fontSize: 10, color: Colors.black)),
            ),
            Container(
              height: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(mText,
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            Container(
              height: 20,
            ),
            Container(
              child: Row(children: [
                Container(
                  width: 30,
                ),
                LikeButton(
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ]),
            ),
            Container(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
