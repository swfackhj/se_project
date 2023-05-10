import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/components/error_dialog.dart';

class AddTeamController extends GetxController {
  String teamImage = "";
  TextEditingController teamNameController = TextEditingController();
  String gender = "남자";
  String place = "히딩크";
  TextEditingController middleNumberController = TextEditingController();
  TextEditingController endNumberController = TextEditingController();
  bool haveBall = false;
  bool haveVest = false;
  bool isMercenary = false;
  TextEditingController addMemberController = TextEditingController();
  List<String> membersUid = [];

  void changeGender(String changedGender) {
    gender = changedGender;
    update();
  }

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

  void changeMercenary(bool changeMercenary) {
    isMercenary = changeMercenary;
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
}
