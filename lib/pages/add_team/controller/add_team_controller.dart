import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
