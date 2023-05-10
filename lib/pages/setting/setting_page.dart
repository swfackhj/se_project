import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/controller/user_controller.dart';
import 'package:software_engineering/pages/setting/components/list_tile.dart';
import 'package:software_engineering/pages/setting/controller/setting_controller.dart';
import 'package:software_engineering/utils/paddings.dart';

import '../../utils/sizes.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final settingController = Get.put(SettingController());
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: defaultPadding,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return Column(
                  children: [
                    CircleAvatar(
                        backgroundImage: const AssetImage('assets/default.png'),
                        radius: phoneSize.width * 0.1),
                    Text('${snapshot.data!['name']}'),
                    SizedBox(height: phoneSize.height * 0.01),
                    CustomListTile(
                        icon: const Icon(Icons.people),
                        title: '나의 소속팀',
                        onTap: () => null),
                    CustomListTile(
                        icon: const Icon(Icons.flight),
                        title: '나의 전적',
                        onTap: () => null),
                    CustomListTile(
                        icon: const Icon(Icons.logout),
                        title: '로그아웃',
                        onTap: () => settingController.signOut()),
                  ],
                );
              }),
        ),
      )),
    );
  }
}
