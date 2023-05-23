import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/components/error_dialog.dart';
import 'package:software_engineering/pages/add_team/controller/add_team_controller.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class TeamNameSection extends StatelessWidget {
  TeamNameSection({super.key});

  final addTeamController = Get.find<AddTeamController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: phoneSize.width * 0.2,
          height: phoneSize.width * 0.2,
          color: Colors.black,
        ),
        SizedBox(width: phoneSize.width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '팀 이름',
              style: titleStyle,
            ),
            SizedBox(height: phoneSize.height * 0.01),
            Row(
              children: [
                SizedBox(
                  width: phoneSize.width * 0.3,
                  height: phoneSize.height * 0.05,
                  child: TextField(
                    controller: addTeamController.teamNameController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(
                            phoneSize.width * 0.03, 0, 0, 0),
                        hintText: '팀 이름을 입력해주세요'),
                  ),
                ),
                SizedBox(
                    height: phoneSize.height * 0.05,
                    child: ElevatedButton(
                      onPressed: () async {
                        final snapshot = await FirebaseFirestore.instance
                            .collection('team')
                            .where('teamName',
                                isEqualTo:
                                    addTeamController.teamNameController.text)
                            .get();
                        if (snapshot.docs.isNotEmpty) {
                          errorDialog('중복된 팀 이름입니다.');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: const Text('중복확인'),
                    ))
              ],
            )
          ],
        )
      ],
    );
  }
}
