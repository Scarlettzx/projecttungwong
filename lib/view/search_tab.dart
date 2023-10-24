import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../data/models/dropdown_province_model.dart';
import '../pages/api_provider.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  void initState() {
    super.initState();
    (bandService.profileController.selectType.value == "User")
        ? bandService.profileController.getAllProfie()
        : bandService.bandsController.getAllBand();
    print(bandService.profileController.selectType.value);
  }

  @override
  void dispose() {
    super.dispose();
  }

  static final ScrollController _scrollController = ScrollController();
  final BandService bandService = Get.find();
  List<String> itemsRole = ['All', 'Guitar', 'Vocal', 'Drum', 'Bass'];

  List<String> itemType = ['Band', 'User'];

  String selectedProvince = 'All';
  String selectedUsername = '';
  String selectedRole = 'All';
  ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: ColorConstants.appColors,
          title: Padding(
            padding: const EdgeInsets.all(10.00),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: 'ค้นหาเพื่อนๆของคุณได้เลย!',
                contentPadding: EdgeInsets.only(
                  left: 15.0,
                ),
              ),
              onChanged: (value) => {},
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 10),
            child: FutureBuilder<List<ProvinceDropdownModel>>(
              future: apiProvider.fetchProvinceData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: [
                      Container(
                        width: 200,
                        child: DropdownButtonFormField(
                          menuMaxHeight: 700,
                          style: TextStyle(
                            color: ColorConstants.gray600,
                          ),
                          decoration: InputDecoration(
                            hintText: "Select Province",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 192, 192, 192)),
                            fillColor: const Color.fromARGB(255, 237, 237, 237),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: Color(0xFFB3B3B3),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 52, 230, 168),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          items: snapshot.data?.map((e) {
                            return DropdownMenuItem(
                                value: e.nameTh.toString(),
                                child: Text(e.nameTh.toString()));
                          }).toList(),
                          value: selectedProvince,
                          onChanged: (val) {
                            print(val);
                            setState(() {
                              selectedProvince = val!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 116,
                        child: DropdownButtonFormField(
                          menuMaxHeight: 200,
                          value: selectedRole,
                          items: itemsRole.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedRole = val!;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Select Role",
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 192, 192, 192),
                            ),
                            fillColor: const Color.fromARGB(255, 237, 237, 237),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color(0xFFB3B3B3),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 52, 230, 168),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 30,
                        child: DropdownButtonFormField(
                          menuMaxHeight: 200,
                          value: bandService.profileController.selectType.value,
                          items: itemType.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            bandService.profileController.selectType.value =
                                val!;
                            print(
                                bandService.profileController.selectType.value);
                            (bandService.profileController.selectType.value ==
                                    "User")
                                ? bandService.profileController.getAllProfie()
                                : bandService.bandsController.getAllBand();
                          },
                          decoration: InputDecoration(
                            hintText: "",
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 192, 192, 192),
                            ),
                            fillColor: const Color.fromARGB(255, 237, 237, 237),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color(0xFFB3B3B3),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 52, 230, 168),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                        ),
                      )
                    ],
                  );
                }
                return LoadingAnimationWidget.dotsTriangle(
                  size: 50,
                  color: ColorConstants.appColors,
                );
              },
            ),
          ),
        ),
        Obx(() => (bandService.profileController.selectType.value == "User")
            ? (bandService.profileController.isLoading.value)
                ? SliverToBoxAdapter(
                    child: Container(
                      height: 400,
                      child: Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: ColorConstants.appColors,
                          size: 50,
                        ),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var allUsers = bandService.profileController.allusers;
                        var reverseindex = allUsers.length - 1 - index;
                        return Obx(() => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.015),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: ColorConstants.appColors,
                                    width: 0.8,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, top: 20, bottom: 40),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: NetworkImage(
                                              '${Config.getImage}${allUsers[reverseindex].userAvatar}',
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                allUsers[reverseindex]
                                                    .userName!,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Text(
                                                'ตำแหน่ง :${allUsers[reverseindex].userPosition}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                              (allUsers[reverseindex].bandId !=
                                                      null)
                                                  ? Text(
                                                      'สังกัดอยู่ในวง : ${allUsers[reverseindex].bandId}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey))
                                                  : Container()
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                      childCount: bandService.profileController.allusers.length,
                    ),
                  )
            : (bandService.bandsController.isLoading.value)
                ? SliverToBoxAdapter(
                    child: Container(
                      height: 400,
                      child: Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: ColorConstants.appColors,
                          size: 50,
                        ),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var allBands = bandService.bandsController.allbands;
                        var reverseindex = allBands.length - 1 - index;
                        return Obx(() => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.015),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: ColorConstants.appColors,
                                    width: 0.8,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, top: 20, bottom: 40),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: NetworkImage(
                                              '${Config.getImageBand}${allBands[reverseindex].bandAvatar}',
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                allBands[reverseindex]
                                                    .bandName!,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Text(
                                                'วงประเภท : ${allBands[reverseindex].bandCategory}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                      childCount: bandService.bandsController.allbands.length,
                    ),
                  ))
        //     }
        //   },
        // ),
      ],
    ));
  }
}
