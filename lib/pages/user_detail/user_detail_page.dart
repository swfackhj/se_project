import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class UserDetailPage extends StatelessWidget {
  final String docID;

  const UserDetailPage({super.key, required this.docID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          '유저 정보',
          style: appBarTitileStyle,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(docID)
            .snapshots(),
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData) {
            return Container();
          }

          return Center(
            child: Padding(
              padding: defaultPadding,
              child: Column(
                children: [
                  userSnapshot.data?['image'] ??
                      Image.asset('assets/default.png'),
                  SizedBox(height: phoneSize.height * 0.01),
                  Text('${userSnapshot.data?['name']}', style: titleStyle),
                  SizedBox(height: phoneSize.height * 0.01),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
