import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:software_engineering/controller/user_controller.dart';
import 'package:software_engineering/pages/add_team/add_team_page.dart';
import 'package:software_engineering/pages/home/controller/home_controller.dart';
import 'package:software_engineering/pages/match/match_page.dart';
import 'package:software_engineering/pages/mercenary/mercenary_page.dart';
import 'package:software_engineering/pages/rank/rank_page.dart';
import 'package:software_engineering/pages/setting/setting_page.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/sizes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put(HomeController());
  final userController = Get.put(UserController());
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  int selectedPage = 0;
  final pages = [
    const HomePage(),
    const MercenaryPage(),
    const MatchPage(),
    const RankPage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          '밀덕',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        centerTitle: false,
      ),
      body: GetBuilder<HomeController>(builder: (context) {
        return Padding(
          padding: defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: phoneSize.height * 0.5,
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('team').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '오늘의 팀',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        SizedBox(height: phoneSize.height * 0.025),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (builder, index) {
                            return SizedBox(
                              width: phoneSize.width,
                              height: phoneSize.height * 0.2,
                              child: Column(children: [
                                Row(children: [
                                  Container(
                                    width: phoneSize.width * 0.15,
                                    height: phoneSize.width * 0.15,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: phoneSize.width * 0.05),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${snapshot.data?.docs[index]['teamName']}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(DateFormat('aa hh:mm').format(
                                                snapshot.data!
                                                    .docs[index]['createTime']
                                                    .toDate()))
                                          ],
                                        ),
                                        SizedBox(
                                            height: phoneSize.width * 0.02),
                                        Row(
                                          children: const [
                                            Icon(Icons.person),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ])
                              ]),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        openCloseDial: isDialOpen,
        backgroundColor: Colors.black,
        overlayColor: Colors.grey,
        overlayOpacity: 0.5,
        spacing: 10,
        spaceBetweenChildren: 10,
        closeManually: false,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.groups),
              label: '팀 등록',
              onTap: () {
                Get.to(() => AddTeamPage());
              }),
        ],
      ),
    );
  }
}
