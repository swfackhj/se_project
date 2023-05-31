import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/components/error_dialog.dart';
import 'package:software_engineering/controller/user_controller.dart';

class TeamEditController extends GetxController {
  TeamEditController({required this.docID});

  final userController = Get.find<UserController>();

  String docID;

  String teamLeader = '';
  List<dynamic> teamMembers = [];
  bool haveBall = false;
  bool haveVest = false;

  TextEditingController teamMembersController = TextEditingController();

  @override
  void onInit() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('team').doc(docID).get();
    teamLeader = snapshot.data()!['leaderUid'];
    teamMembers = snapshot.data()!['members'];
    haveBall = snapshot.data()!['haveBall'];
    haveVest = snapshot.data()!['haveVest'];
    super.onInit();
  }

  void addMember(String email) async {
    String userEmail = '';
    if (email.contains('handong.ac.kr')) {
      userEmail = email;
    } else {
      userEmail = '$email@handong.ac.kr';
    }
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: userEmail)
        .get();
    try {
      if (!teamMembers.contains(snapshot.docs[0].data()['uid'])) {
        teamMembers.add(snapshot.docs[0].data()['uid']);
        await FirebaseFirestore.instance
            .collection('team')
            .doc(docID)
            .update({'members': FieldValue.arrayUnion(teamMembers)});
      } else {
        errorDialog('이미 추가되어있습니다.');
      }
    } catch (e) {
      errorDialog('해당 유저가 존재하지 않습니다.');
    }
    update();
  }

  void deleteMember(String uid) async {
    teamMembers.remove(uid);
    await FirebaseFirestore.instance.collection('team').doc(docID).update({
      'members': FieldValue.arrayRemove([uid])
    });
  }

  void changeLeader(String uid) async {
    await FirebaseFirestore.instance
        .collection('team')
        .doc(docID)
        .update({'leaderUid': uid});
  }
}
