import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/user_detail/user_detail_page.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class TeamDetailPage extends StatelessWidget {
  final String docID;

  const TeamDetailPage({super.key, required this.docID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          '팀 정보',
          style: appBarTitileStyle,
        ),
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

          return Center(
            child: Padding(
              padding: defaultPadding,
              child: Column(
                children: [
                  teamSnapshot.data?['image'] ??
                      Image.asset('assets/default.png'),
                  SizedBox(height: phoneSize.height * 0.01),
                  Text('${teamSnapshot.data?['teamName']}', style: titleStyle),
                  SizedBox(height: phoneSize.height * 0.01),
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
            ),
          );
        },
      ),
    );
  }

  Widget teamLeaderSection(dynamic userSnapshot) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('팀 리더', style: titleStyle),
      Text('${userSnapshot.data?['name']}',
          style: subTitleStyle.copyWith(fontSize: 16.0)),
    ]);
  }

  Widget teamMemberSection(dynamic teamSnapshot) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        '팀 멤버',
        style: titleStyle,
      ),
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
                  return Row(
                    children: [
                      const Text('- '),
                      GestureDetector(
                        onTap: () {
                          Get.to(UserDetailPage(
                              docID: membersSnapshot.data?['uid']));
                        },
                        child: Text('${membersSnapshot.data?['name']}',
                            style: underLineStyle.copyWith(fontSize: 16.0)),
                      ),
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
