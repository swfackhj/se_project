import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:software_engineering/pages/match/controller/match_controller.dart';
import 'package:software_engineering/pages/match_detail/match_detail_page.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class MatchPage extends StatelessWidget {
  MatchPage({super.key});

  final matchContoller = Get.put(MatchContorller());

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('오늘의 매치', style: titleStyle),
            SizedBox(height: phoneSize.height * 0.025),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('team').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  matchContoller.getTodayTeams(snapshot);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: matchContoller.combination.length,
                    itemBuilder: (context, index) {
                      return Container(
                          width: phoneSize.width,
                          height: phoneSize.height * 0.2,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('team')
                                  .doc(matchContoller.combination[index][0])
                                  .snapshots(),
                              builder: (context, snapshot1) {
                                return StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('team')
                                        .doc(matchContoller.combination[index]
                                            [1])
                                        .snapshots(),
                                    builder: (context, snapshot2) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: phoneSize.height * 0.08,
                                                height: phoneSize.height * 0.08,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                  height:
                                                      phoneSize.height * 0.01),
                                              Text(
                                                  '${snapshot1.data?['teamName']}',
                                                  style: subTitleStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'VS',
                                                style: titleStyle.copyWith(
                                                    fontSize: 32.0),
                                              ),
                                              SizedBox(
                                                height: phoneSize.height * 0.03,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    String today = DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(DateTime.now())
                                                        .toString();
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('match')
                                                        .doc(today)
                                                        .get()
                                                        .then((snapshot) async {
                                                      if (snapshot.exists) {
                                                        if (snapshot.data()![
                                                                '${snapshot1.data?['teamName']} VS ${snapshot2.data?['teamName']}'] ==
                                                            null) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'match')
                                                              .doc(today)
                                                              .update({
                                                            '${snapshot1.data?['teamName']} VS ${snapshot2.data?['teamName']}':
                                                                []
                                                          });
                                                        } else {}
                                                      } else {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('match')
                                                            .doc(today)
                                                            .set({});
                                                      }
                                                      Get.to(() => MatchDetailPage(
                                                          team1: matchContoller
                                                                  .combination[
                                                              index][0],
                                                          teamName1:
                                                              snapshot1.data?[
                                                                  'teamName'],
                                                          team2: matchContoller
                                                                  .combination[
                                                              index][1],
                                                          teamName2:
                                                              snapshot2.data?[
                                                                  'teamName']));
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.black),
                                                  child: const Text('기록하기'),
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: phoneSize.height * 0.08,
                                                height: phoneSize.height * 0.08,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                  height:
                                                      phoneSize.height * 0.01),
                                              Text(
                                                  '${snapshot2.data?['teamName']}',
                                                  style: subTitleStyle.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          )
                                        ],
                                      );
                                    });
                              }));
                    },
                  );
                }),
          ])),
    );
  }
}
