import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/utils/styles.dart';

class LogInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
          return errorDialog('존재하지 않는 계정입니다.');
      }
    }
  }

  Future<dynamic> errorDialog(String content) {
    return Get.defaultDialog(
      title: '로그인 오류',
      titleStyle: titleStyle,
      content: Text(content),
      textConfirm: '확인',
      buttonColor: Colors.black,
      confirmTextColor: Colors.white,
      onConfirm: Get.back,
    );
  }
}
