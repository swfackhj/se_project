import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/controller/user_controller.dart';
import 'package:software_engineering/pages/add_team/controller/add_team_controller.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class MemberSection extends StatelessWidget {
  MemberSection({super.key});

  final addTeamController = Get.find<AddTeamController>();
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('멤버', style: titleStyle),
        SizedBox(height: phoneSize.height * 0.01),
        Row(
          children: [
            SizedBox(
              width: phoneSize.width * 0.5,
              height: phoneSize.height * 0.05,
              child: TextField(
                controller: addTeamController.addMemberController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.fromLTRB(phoneSize.width * 0.03, 0, 0, 0),
                    hintText: '아이디를 입력해주세요'),
              ),
            ),
            SizedBox(width: phoneSize.width * 0.05),
            SizedBox(
              height: phoneSize.height * 0.05,
              child: ElevatedButton(
                onPressed: () {
                  addTeamController
                      .addMember(addTeamController.addMemberController.text);
                  addTeamController.addMemberController.clear();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text('추가하기'),
              ),
            )
          ],
        ),
        SizedBox(height: phoneSize.height * 0.01),
        GetBuilder<AddTeamController>(builder: (addTeamController) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: addTeamController.membersUid.length,
            itemBuilder: (context, index) {
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .where('uid',
                          isEqualTo: addTeamController.membersUid[index])
                      .snapshots(),
                  builder: (context, snapshot) {
                    return Text(
                      '${snapshot.data?.docs[0]['name']}',
                      style: subTitleStyle.copyWith(fontSize: 16.0),
                    );
                  });
            },
          );
        }),
      ],
    );
  }
}
