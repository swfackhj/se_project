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
import 'package:software_engineering/pages/team_list/team_list_page.dart';
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('team')
                      .orderBy('createTime', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(),
                        SizedBox(height: phoneSize.height * 0.025),
                        SizedBox(
                          height: phoneSize.height * 0.7,
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (builder, index) {
                              final yesterday = DateTime.utc(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day - 1);
                              if (DateTime.now().hour >= 0 &&
                                  DateTime.now().hour < 8) {
                                if (DateFormat('yyyy-MM-dd').format(snapshot
                                        .data!.docs[index]['createTime']
                                        .toDate()) ==
                                    DateFormat('yyyy-MM-dd')
                                        .format(yesterday)) {
                                  return item(snapshot, index);
                                } else {
                                  return Container();
                                }
                              } else {
                                if (DateFormat('yyyy-MM-dd').format(snapshot
                                        .data!.docs[index]['createTime']
                                        .toDate()) ==
                                    DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now())) {
                                  return item(snapshot, index);
                                } else {
                                  return Container();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
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
              label: '새로운 팀 등록',
              onTap: () {
                Get.to(() => AddTeamPage());
              }),
          SpeedDialChild(
              child: const Icon(Icons.groups),
              label: '기존 팀 등록',
              onTap: () {
                Get.to(() => const TeamListPage());
              })
        ],
      ),
    );
  }

  Widget item(snapshot, index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() =>
                TeamDetailPage(docID: snapshot.data?.docs[index]['docID']));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.circular(10.0)),
            padding: const EdgeInsets.all(10.0),
            width: phoneSize.width,
            height: phoneSize.width * 0.3,
            child: Row(children: [
              image(),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: phoneSize.width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          teamName(snapshot.data?.docs[index]['teamName']),
                          date(snapshot.data!.docs[index]['createTime']
                              .toDate()),
                        ],
                      ),
                      SizedBox(height: phoneSize.width * 0.015),
                      option(
                          snapshot.data!.docs[index]['members'],
                          snapshot.data!.docs[index]['haveBall'],
                          snapshot.data!.docs[index]['haveVest'])
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
        SizedBox(height: phoneSize.height * 0.01),
      ],
    );
  }

  Widget title() {
    return const Text(
      '오늘의 팀',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
    );
  }

  Widget image() {
    return Container(
      width: phoneSize.width * 0.2,
      height: phoneSize.width * 0.2,
      color: Colors.black,
    );
  }

  Widget teamName(String teamName) {
    return Text(
      teamName,
      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }

  Widget date(DateTime date) {
    return Text(DateFormat('aa hh:mm').format(date));
  }

  Widget option(List<dynamic> members, bool haveBall, bool haveVest) {
    return Row(
      children: [
        const Icon(Icons.person, size: 16.0),
        Text('${members.length.toString()} / 6'),
        SizedBox(
          height: phoneSize.height * 0.015,
          child: VerticalDivider(
            width: phoneSize.width * 0.03,
            color: Colors.black,
          ),
        ),
        const Icon(Icons.sports_soccer, size: 16.0),
        haveBall ? const Text('O') : const Text('X'),
        SizedBox(
          height: phoneSize.height * 0.015,
          child: VerticalDivider(
            width: phoneSize.width * 0.03,
            color: Colors.black,
          ),
        ),
        SvgPicture.asset(
          'assets/vest.svg',
          width: 16.0,
          height: 16.0,
        ),
        SizedBox(width: phoneSize.width * 0.01),
        haveVest ? const Text('O') : const Text('X'),
      ],
    );
  }
}
