import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/team_edit/controller/team_edit_controller.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class TeamEditPage extends StatelessWidget {
  TeamEditPage({super.key});

  final teamEditController =
      Get.put(TeamEditController(docID: Get.arguments['docID']));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          '팀 정보 수정',
          style: appBarTitileStyle,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('team')
            .doc(Get.arguments['docID'])
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
                          teamLeaderSection(teamSnapshot, userSnapshot),
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

  Widget teamLeaderSection(dynamic teamSnapshot, dynamic userSnapshot) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('팀 리더', style: titleStyle.copyWith(fontSize: 20.0)),
          SizedBox(width: phoneSize.width * 0.025),
          PopupMenuButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            itemBuilder: (context) {
              return List.generate(teamSnapshot.data?['members'].length,
                  (index) {
                return PopupMenuItem(
                    onTap: () {
                      teamEditController
                          .changeLeader(teamSnapshot.data?['members'][index]);
                    },
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('user')
                            .where('uid',
                                isEqualTo: teamSnapshot.data?['members'][index])
                            .snapshots(),
                        builder: (context, snapshot) {
                          return Text(
                              '${snapshot.data?.docs[0].data()['name']}');
                        }));
              });
            },
            child: const Text('리더 변경'),
          )
        ],
      ),
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
      Row(
        children: [
          Container(
              width: phoneSize.width * 0.4,
              height: phoneSize.height * 0.05,
              padding: EdgeInsets.symmetric(horizontal: phoneSize.width * 0.03),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1.0, color: Colors.black)),
              child: Row(children: <Widget>[
                Flexible(
                    child: TextField(
                  controller: teamEditController.teamMembersController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: ''),
                  cursorColor: Colors.black,
                ))
              ])),
          SizedBox(width: phoneSize.width * 0.025),
          GestureDetector(
            onTap: () {
              teamEditController
                  .addMember(teamEditController.teamMembersController.text);
            },
            child: Container(
              alignment: Alignment.center,
              width: phoneSize.width * 0.25,
              height: phoneSize.height * 0.05,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: const Text(
                '추가하기',
                style: elevatedButtonStyle,
              ),
            ),
          )
        ],
      ),
      SizedBox(height: phoneSize.height * 0.01),
      ListView.builder(
          shrinkWrap: true,
          itemCount: teamSnapshot.data?['members'].length,
          itemBuilder: (context, index) {
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(teamSnapshot.data?['members'][index])
                    .snapshots(),
                builder: (context, membersSnapshot) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Text('- '),
                          Text('${membersSnapshot.data?['name']}',
                              style: subTitleStyle.copyWith(fontSize: 16.0)),
                          SizedBox(width: phoneSize.width * 0.025),
                          GestureDetector(
                            onTap: () {
                              teamEditController
                                  .deleteMember(membersSnapshot.data?['uid']);
                            },
                            child: Text(
                              'X',
                              style: subTitleStyle.copyWith(fontSize: 16.0),
                            ),
                          )
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
      SizedBox(
        width: 18.0,
        height: 18.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Checkbox(
              activeColor: Colors.black,
              value: teamSnapshot.data?['haveBall'],
              onChanged: (value) {
                FirebaseFirestore.instance
                    .collection('team')
                    .doc(teamSnapshot.data?['docID'])
                    .update({'haveBall': value});
              }),
        ),
      )
    ]);
  }

  Widget haveVestSection(dynamic teamSnapshot) {
    return Row(children: [
      const Text('조끼 보유', style: titleStyle),
      SizedBox(width: phoneSize.width * 0.05),
      SizedBox(
        width: 18.0,
        height: 18.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Checkbox(
              activeColor: Colors.black,
              value: teamSnapshot.data?['haveVest'],
              onChanged: (value) {
                FirebaseFirestore.instance
                    .collection('team')
                    .doc(teamSnapshot.data?['docID'])
                    .update({'haveVest': value});
              }),
        ),
      )
    ]);
  }
}
