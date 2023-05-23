import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

enum Items { add, delete }

class TeamListPage extends StatelessWidget {
  const TeamListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('소속팀', style: titleStyle),
            SizedBox(height: phoneSize.height * 0.025),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('team')
                  .where('members',
                      arrayContains: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          '${snapshot.data!.docs[index]['teamName']}',
                          style: subTitleStyle,
                        ),
                        trailing: PopupMenuButton<Items>(
                            onSelected: (selected) async {
                              final doc = FirebaseFirestore.instance
                                  .collection('team')
                                  .doc(snapshot.data!.docs[index]['docID']);
                              if (selected == Items.add) {
                                doc.update({'createTime': DateTime.now()});
                              } else if (selected == Items.delete) {
                                doc.update({
                                  'members': FieldValue.arrayRemove(
                                      [FirebaseAuth.instance.currentUser!.uid])
                                });
                              }
                            },
                            itemBuilder: (context) => <PopupMenuEntry<Items>>[
                                  const PopupMenuItem(
                                      value: Items.add, child: Text('추가하기')),
                                  const PopupMenuItem(
                                      value: Items.delete, child: Text('삭제하기'))
                                ]),
                        contentPadding: EdgeInsets.zero,
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
