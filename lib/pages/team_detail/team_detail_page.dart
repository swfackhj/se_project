import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/controller/user_controller.dart';
import 'package:software_engineering/pages/team_detail/controller/team_detail_controller.dart';
import 'package:software_engineering/pages/team_edit/tean_edit_page.dart';
import 'package:software_engineering/pages/user_detail/user_detail_page.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class TeamDetailPage extends StatelessWidget {
  TeamDetailPage({super.key, required this.docID});

  final String docID;
  final teamDetailController = Get.put(TeamDetailController());
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    teamDetailController.getLeaderUid(docID);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          '팀 정보',
          style: appBarTitileStyle,
        ),
        actions: [
          // ignore: unrelated_type_equality_checks
          Obx(() => teamDetailController.leaderUid ==
                  FirebaseAuth.instance.currentUser?.uid
              ? GestureDetector(
                  onTap: () {
                    Get.to(() => TeamEditPage(), arguments: {'docID': docID});
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.edit),
                  ),
                )
              : Container())
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('team')
            .doc(docID)
            .snapshots(),
        builder: (context, teamSnapshot) {
          if (!teamSnapshot.hasData) {
            return Container();
          }

          return Padding(
            padding: defaultPadding,
            child: Column(
              children: [
                image(teamSnapshot),
                SizedBox(height: phoneSize.height * 0.01),
                teamName(teamSnapshot),
                SizedBox(height: phoneSize.height * 0.05),
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .doc(teamSnapshot.data?['leaderUid'])
                        .snapshots(),
                    builder: (context, userSnapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          teamLeaderSection(userSnapshot),
                          SizedBox(height: phoneSize.height * 0.01),
                          teamMemberSection(teamSnapshot),
                          SizedBox(height: phoneSize.height * 0.01),
                          haveBallSection(teamSnapshot),
                          SizedBox(height: phoneSize.height * 0.01),
                          haveVestSection(teamSnapshot),
                        ],
                      );
                    })
              ],
            ),
          );
        },
      ),
    );
  }

  Widget image(dynamic teamSnapshot) {
    return teamSnapshot.data?['image'] ??
        CircleAvatar(
          radius: phoneSize.height * 0.1,
          backgroundImage: const AssetImage('assets/default.png'),
        );
  }

  Widget teamName(dynamic teamSnapshot) {
    return Text('${teamSnapshot.data?['teamName']}',
        style: titleStyle.copyWith(fontSize: 28.0));
  }

  Widget teamLeaderSection(dynamic userSnapshot) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('팀 리더', style: titleStyle.copyWith(fontSize: 20.0)),
      SizedBox(height: phoneSize.height * 0.01),
      Text('${userSnapshot.data?['name']}',
          style: subTitleStyle.copyWith(fontSize: 18.0)),
    ]);
  }

  Widget teamMemberSection(dynamic teamSnapshot) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        '팀 멤버',
        style: titleStyle.copyWith(fontSize: 20.0),
      ),
      SizedBox(height: phoneSize.height * 0.01),
      ListView.builder(
          shrinkWrap: true,
          itemCount: teamSnapshot.data?['members'].length,
          itemBuilder: (context, index) {
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(teamSnapshot.data?['members'][index].trim())
                    .snapshots(),
                builder: (context, membersSnapshot) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Text('- '),
                          GestureDetector(
                            onTap: () {
                              Get.to(UserDetailPage(
                                  docID: membersSnapshot.data?['uid'].trim()));
                            },
                            child: Text('${membersSnapshot.data?['name']}',
                                style: underLineStyle.copyWith(fontSize: 18.0)),
                          ),
                        ],
                      ),
                      SizedBox(height: phoneSize.height * 0.005),
                    ],
                  );
                });
          })
    ]);
  }

  Widget haveBallSection(var teamSnapshot) {
    return Row(children: [
      const Text('볼 보유', style: titleStyle),
      SizedBox(width: phoneSize.width * 0.05),
      teamSnapshot.data?['haveBall']
          ? SizedBox(
              width: 18.0,
              height: 18.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Checkbox(
                    activeColor: Colors.black,
                    value: true,
                    onChanged: (value) {}),
              ),
            )
          : SizedBox(
              width: 18.0,
              height: 18.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Checkbox(
                    activeColor: Colors.black,
                    value: false,
                    onChanged: (value) {}),
              ),
            )
    ]);
  }

  Widget haveVestSection(var teamSnapshot) {
    return Row(children: [
      const Text('조끼 보유', style: titleStyle),
      SizedBox(width: phoneSize.width * 0.05),
      teamSnapshot.data?['haveVest']
          ? SizedBox(
              width: 18.0,
              height: 18.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Checkbox(
                    activeColor: Colors.black,
                    value: true,
                    onChanged: (value) {}),
              ),
            )
          : SizedBox(
              width: 18.0,
              height: 18.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Checkbox(
                    activeColor: Colors.black,
                    value: false,
                    onChanged: (value) {}),
              ),
            )
    ]);
  }
}
