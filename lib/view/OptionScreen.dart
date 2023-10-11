// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
// import 'package:project/component/Commend.dart';
import 'package:project/utils/color.constants.dart';
// import 'package:project/view/Test_post_view.dart';
import 'package:project/view/post_tab.dart';

class OptionsScreen extends StatelessWidget {
  // static List<Commend> commend = [
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  //   Commend(id: '1', text: "สนใจครับๆ", time: 'Monday 18.30'),
  // ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person, size: 18),
                        radius: 18,
                      ),
                      SizedBox(width: 6),
                      Text('flutter_developer02', //username ของ user
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 10),
                      Icon(Icons.verified, size: 15),
                      SizedBox(width: 6),
                      TextButton(
                        onPressed: () {}, //ให้follow
                        child: Text(
                          'Follow',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 6),
                  Text(
                      'Flutter is beautiful and fast 💙❤💛 ..', // describtion ของ video
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                ],
              ),
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                    right: 80,
                  )),
                  LikeButton(
                    size: 40,
                  ),

                  Text('601k'), // total like
                  SizedBox(height: 20),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        // isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: NestedScrollView(
                              headerSliverBuilder: (BuildContext context,
                                  bool innerBoxIsScrolled) {
                                return <Widget>[
                                  SliverAppBar(
                                    expandedHeight:
                                        30.0, // สูงสุดของ SliverAppBar
                                    floating: true, // ตั้งค่าเป็น false
                                    pinned: true, // ตั้งค่าเป็น false
                                    flexibleSpace: FlexibleSpaceBar(
                                      title: Text(
                                        "Commend",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ];
                              },
                              body: Column(children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        // ListView.builder(
                                        //   physics:
                                        //       NeverScrollableScrollPhysics(),
                                        //   shrinkWrap: true,
                                        //   itemCount:
                                        //       OptionsScreen.commend.length,
                                        //   itemBuilder: ((context, index) {
                                        //     final commend =
                                        //         OptionsScreen.commend[index];
                                        //     return Padding(
                                        //       padding: EdgeInsets.all(8),
                                        //       child: ListTile(
                                        //         tileColor:
                                        //             ColorConstants.gray50,
                                        //         leading: CircleAvatar(
                                        //           child: Text(commend.id),
                                        //           radius: 20,
                                        //         ),
                                        //         title: Text(
                                        //           commend.text,
                                        //           style:
                                        //               TextStyle(fontSize: 16),
                                        //         ),
                                        //         subtitle: Text(
                                        //           commend.time,
                                        //           style:
                                        //               TextStyle(fontSize: 12),
                                        //         ),
                                        //       ),
                                        //     );
                                        //   }),
                                        // ),

                                        // ส่วนปุ่มหรืออื่น ๆ ที่คุณต้องการเพิ่ม
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  color: ColorConstants.appColors,
                                  child: Row(children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Comment',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            8), // ระยะห่างระหว่าง TextFormField และปุ่ม
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // รหัสที่คุณต้องการให้ปุ่มทำงาน
                                        },
                                        child: Text('Add'),
                                      ),
                                    ),
                                  ]),
                                ),
                              ]),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.comment_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),

                  Text('1123'), //total commend
                  SizedBox(height: 20),
                  // Transform(
                  //   transform: Matrix4.rotationZ(5.8),
                  //   child: Icon(Icons.send),
                  // ),
                  // SizedBox(height: 50),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
