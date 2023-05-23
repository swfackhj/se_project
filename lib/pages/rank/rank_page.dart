import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class RankPage extends StatelessWidget {
  const RankPage({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('랭킹', style: titleStyle),
            SizedBox(height: phoneSize.height * 0.025),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('team')
                  .orderBy('win', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: phoneSize.height * 0.01,
                      childAspectRatio: 2.5),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      padding: const EdgeInsets.all(10),
                      width: phoneSize.width,
                      height: phoneSize.width * 0.3,
                      child: Row(children: [
                        Text('${index + 1}등'),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: phoneSize.width * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data?.docs[index]['teamName']}',
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                        '${snapshot.data!.docs[index]['win']}승'),
                                    Text(
                                        '${snapshot.data!.docs[index]['lose']}패'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
