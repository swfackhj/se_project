import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:software_engineering/pages/match_detail/controller/match_detail_controller.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class MatchDetailPage extends StatelessWidget {
  MatchDetailPage({super.key});

  final matchDetailController = Get.put(MatchDetailController(
    teamUid1: Get.arguments['team1'],
    teamUid2: Get.arguments['team2'],
    teamName1: Get.arguments['teamName1'],
    teamName2: Get.arguments['teamName2'],
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            '매치 정보',
            style: appBarTitileStyle,
          ),
        ),
        body: GetBuilder<MatchDetailController>(builder: (context) {
          return Padding(
            padding: defaultPadding,
            child: Column(children: [
              Container(
                  width: phoneSize.width,
                  height: phoneSize.height * 0.2,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('team')
                              .doc(Get.arguments['team1'])
                              .snapshots(),
                          builder: (context, snapshot) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: phoneSize.height * 0.08,
                                  height: phoneSize.height * 0.08,
                                  color: Colors.black,
                                ),
                                SizedBox(height: phoneSize.height * 0.01),
                                Text('${snapshot.data?['teamName']}',
                                    style: subTitleStyle.copyWith(
                                        fontWeight: FontWeight.bold)),
                              ],
                            );
                          }),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'VS',
                            style: titleStyle.copyWith(fontSize: 32.0),
                          ),
                        ],
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('team')
                              .doc(Get.arguments['team2'])
                              .snapshots(),
                          builder: (context, snapshot) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: phoneSize.height * 0.08,
                                  height: phoneSize.height * 0.08,
                                  color: Colors.black,
                                ),
                                SizedBox(height: phoneSize.height * 0.01),
                                Text('${snapshot.data?['teamName']}',
                                    style: subTitleStyle.copyWith(
                                        fontWeight: FontWeight.bold)),
                              ],
                            );
                          }),
                    ],
                  )),
              SizedBox(height: phoneSize.height * 0.025),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('match')
                          .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()))
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: phoneSize.width * 0.25,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () => matchDetailController
                                              .addScore(index, 0),
                                          child: plusIcon()),
                                      SizedBox(width: phoneSize.width * 0.015),
                                      Container(
                                        alignment: Alignment.center,
                                        width: phoneSize.width * 0.1,
                                        child: Text(Get.arguments['teamName1'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(width: phoneSize.width * 0.015),
                                      GestureDetector(
                                          onTap: () => matchDetailController
                                              .minusScore(index, 0),
                                          child: minusIcon()),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        leftScores(index),
                                        Row(
                                          children: [
                                            Text('${index + 1}경기'),
                                          ],
                                        ),
                                        rightScores(index),
                                      ]),
                                ),
                                SizedBox(
                                  width: phoneSize.width * 0.25,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () => matchDetailController
                                              .addScore(index, 1),
                                          child: plusIcon()),
                                      SizedBox(width: phoneSize.width * 0.015),
                                      Container(
                                        alignment: Alignment.center,
                                        width: phoneSize.width * 0.1,
                                        child: Text(Get.arguments['teamName2'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(width: phoneSize.width * 0.015),
                                      GestureDetector(
                                          onTap: () => matchDetailController
                                              .minusScore(index, 1),
                                          child: minusIcon()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                          ],
                        );
                      });
                },
              )
            ]),
          );
        }));
  }

  Widget plusIcon() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(width: 1.0),
          borderRadius: BorderRadius.circular(10.0)),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 16.0,
      ),
    );
  }

  Widget minusIcon() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(width: 1.0),
          borderRadius: BorderRadius.circular(10.0)),
      child: const Icon(
        Icons.remove,
        color: Colors.white,
        size: 16.0,
      ),
    );
  }

  Widget leftScores(int index) {
    return SizedBox(
      width: phoneSize.width * 0.09,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          index <= matchDetailController.scores.length - 1
              ? Text('${matchDetailController.scores[index][1]}')
              : Container(),
          index <= matchDetailController.scores.length - 1 &&
                  matchDetailController.scores[index][0] !=
                      matchDetailController.scores[index][1]
              ? matchDetailController.scores[index][0] <
                      matchDetailController.scores[index][1]
                  ? const Text('L',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold))
                  : const Text('W',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold))
              : Container()
        ],
      ),
    );
  }

  Widget rightScores(int index) {
    return SizedBox(
      width: phoneSize.width * 0.09,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          index <= matchDetailController.scores.length - 1
              ? Text('${matchDetailController.scores[index][1]}')
              : Container(),
          index <= matchDetailController.scores.length - 1 &&
                  matchDetailController.scores[index][0] !=
                      matchDetailController.scores[index][1]
              ? matchDetailController.scores[index][0] <
                      matchDetailController.scores[index][1]
                  ? const Text('W',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold))
                  : const Text('L',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold))
              : Container()
        ],
      ),
    );
  }
}
