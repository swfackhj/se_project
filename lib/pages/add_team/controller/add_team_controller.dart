import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/components/error_dialog.dart';

class AddTeamController extends GetxController {
  String teamImage = "";
  TextEditingController teamNameController = TextEditingController();
  String place = "히딩크";
  TextEditingController middleNumberController = TextEditingController();
  TextEditingController endNumberController = TextEditingController();
  bool haveBall = false;
  bool haveVest = false;
  TextEditingController addMemberController = TextEditingController();
  List<String> membersUid = [];

  void changePlace(String changedPlace) {
    place = changedPlace;
    update();
  }

  void chnageBall(bool changeBall) {
    haveBall = changeBall;
    update();
  }

  void changeVest(bool changeVest) {
    haveVest = changeVest;
    update();
  }

  void addMember(String email) async {
    final userEmail = '$email@handong.ac.kr';
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: userEmail)
        .get();
    try {
      if (!membersUid.contains(snapshot.docs[0]['uid'])) {
        membersUid.add(snapshot.docs[0]['uid']);
      } else {
        errorDialog('이미 추가되어있습니다.');
      }
    } catch (e) {
      errorDialog('해당 유저가 존재하지 않습니다.');
    }
    update();
  }

  void addTeam() async {
    if (teamNameController.text.trim().isEmpty ||
        middleNumberController.text.trim().isEmpty ||
        endNumberController.text.trim().isEmpty) {
      errorDialog('필수 항목을 입력해주세요.');
    } else if (middleNumberController.text.length != 4 ||
        endNumberController.text.length != 4 ||
        !middleNumberController.text.isNum ||
        !endNumberController.text.isNum) {
      errorDialog('전화번호 형식이 잘못되었습니다.');
    } else {
      String docID = FirebaseFirestore.instance.collection('team').doc().id;
      membersUid.add(FirebaseAuth.instance.currentUser!.uid);
      await FirebaseFirestore.instance.collection('team').doc(docID).set({
        'teamName': teamNameController.text,
        'place': place,
        'phoneNumber':
            '010${middleNumberController.text}${endNumberController.text}',
        'haveBall': haveBall,
        'haveVest': haveVest,
        'createTime': DateTime.now(),
        'members': membersUid,
        'leaderUid': FirebaseAuth.instance.currentUser?.uid,
        'docID': docID,
        'image': null,
        'win': 0,
        'lose': 0,
      });
      Get.back();
    }
  }
}
