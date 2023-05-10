import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:software_engineering/controller/user_controller.dart';
import 'package:software_engineering/pages/add_team/add_team_page.dart';
import 'package:software_engineering/pages/home/controller/home_controller.dart';
import 'package:software_engineering/pages/match/match_page.dart';
import 'package:software_engineering/pages/mercenary/mercenary_page.dart';
import 'package:software_engineering/pages/rank/rank_page.dart';
import 'package:software_engineering/pages/setting/setting_page.dart';
import 'package:software_engineering/pages/team_detail/team_detail_page.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

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
    MatchPage(),
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
          style: appBarTitileStyle,
        ),
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

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '오늘의 팀',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          SizedBox(height: phoneSize.height * 0.025),
                          SizedBox(
                            height: phoneSize.height * 0.7,
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: phoneSize.height * 0.01,
                                      childAspectRatio: 2.5),
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (builder, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(TeamDetailPage(
                                        docID: snapshot.data?.docs[index]
                                            ['docID']));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.all(10),
                                    width: phoneSize.width,
                                    height: phoneSize.width * 0.3,
                                    child: Row(children: [
                                      Container(
                                        width: phoneSize.width * 0.2,
                                        height: phoneSize.width * 0.2,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  phoneSize.width * 0.05),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${snapshot.data?.docs[index]['teamName']}',
                                                    style: const TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(DateFormat('aa hh:mm')
                                                      .format(snapshot
                                                          .data!
                                                          .docs[index]
                                                              ['createTime']
                                                          .toDate()))
                                                ],
                                              ),
                                              SizedBox(
                                                  height:
                                                      phoneSize.width * 0.015),
                                              Row(
                                                children: [
                                                  const Icon(Icons.person,
                                                      size: 16.0),
                                                  Text(
                                                      '${snapshot.data!.docs[index]['members'].length.toString()} / 6'),
                                                  SizedBox(
                                                    height: phoneSize.height *
                                                        0.015,
                                                    child: VerticalDivider(
                                                      width: phoneSize.width *
                                                          0.03,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const Icon(
                                                      Icons.sports_soccer,
                                                      size: 16.0),
                                                  snapshot.data!.docs[index]
                                                          ['haveBall']
                                                      ? const Text('O')
                                                      : const Text('X'),
                                                  SizedBox(
                                                    height: phoneSize.height *
                                                        0.015,
                                                    child: VerticalDivider(
                                                      width: phoneSize.width *
                                                          0.03,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SvgPicture.asset(
                                                    'assets/vest.svg',
                                                    width: 16.0,
                                                    height: 16.0,
                                                  ),
                                                  SizedBox(
                                                      width: phoneSize.width *
                                                          0.01),
                                                  snapshot.data!.docs[index]
                                                          ['haveVest']
                                                      ? const Text('O')
                                                      : const Text('X'),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
