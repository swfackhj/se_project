import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:software_engineering/pages/add_mercenary/add_mercenary_page.dart';
import 'package:software_engineering/pages/home/controller/home_controller.dart';
import 'package:software_engineering/pages/mercenary/components/mercenary_component.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class MercenaryPage extends StatefulWidget {
  const MercenaryPage({super.key});

  @override
  State<MercenaryPage> createState() => _MercenaryPageState();
}

class _MercenaryPageState extends State<MercenaryPage> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  final homeController = Get.put(HomeController());

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
      body: Padding(
        padding: defaultPadding,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('mercenary')
              .orderBy('createTime', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            } else {
              final docs = snapshot.data?.docs;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('오늘의 용병', style: titleStyle),
                    SizedBox(height: phoneSize.height * 0.025),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return DateFormat('yyyy-MM-dd').format(
                                    docs?[index]['createTime'].toDate()) ==
                                DateFormat('yyyy-MM-dd').format(DateTime.now())
                            ? Column(
                                children: [
                                  MercenaryComponent(
                                      title: docs?[index]['title'],
                                      editor: docs?[index]['editor'],
                                      phoneNumber: docs?[index]['phoneNumber'],
                                      members: docs?[index]['members'],
                                      content: docs?[index]['content'],
                                      createTime: DateFormat('aa hh:mm')
                                          .format(docs?[index]['createTime']
                                              .toDate())
                                          .toString()),
                                  SizedBox(
                                    height: phoneSize.height * 0.01,
                                  )
                                ],
                              )
                            : Container();
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
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
              child: const Icon(Icons.person),
              label: '용병 모집 등록',
              onTap: () {
                Get.to(() => AddMercenaryPage());
              }),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
