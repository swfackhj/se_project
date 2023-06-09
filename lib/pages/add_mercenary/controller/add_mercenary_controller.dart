import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/controller/user_controller.dart';

class AddMercenaryController extends GetxController {
  final userController = Get.find<UserController>();

  TextEditingController titleContoller = TextEditingController();
  TextEditingController editorController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String members = '1';

  void addMercenary() async {
    await FirebaseFirestore.instance.collection('mercenary').add({
      'title': titleContoller.text,
      'editor': userController.name,
      'phoneNumber': phoneNumberController.text,
      'members': members,
      'content': contentController.text,
      'createTime': DateTime.now(),
    });
  }

  void changeMembers(String members) {
    this.members = members;
    update();
  }
}
