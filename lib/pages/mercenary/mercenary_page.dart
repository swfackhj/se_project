import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:software_engineering/pages/add_mercenary/add_mercenary_page.dart';
import 'package:software_engineering/pages/home/controller/home_controller.dart';
import 'package:software_engineering/pages/home/models/mercenary_model.dart';
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('mercenary').snapshots(),
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
                      SizedBox(height: phoneSize.height * 0.01),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: phoneSize.height * 0.01,
                            childAspectRatio: 2.5),
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return MercenaryModel(
                              title: docs?[index]['title'],
                              editor: docs?[index]['editor'],
                              phoneNumber: docs?[index]['phoneNumber'],
                              members: docs?[index]['members'],
                              content: docs?[index]['content'],
                              createTime: DateFormat('aa hh:mm')
                                  .format(docs?[index]['createTime'].toDate())
                                  .toString());
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
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
