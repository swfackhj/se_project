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
      if (FirebaseAuth.instance.currentUser?.emailVerified == false) {
        errorDialog('이메일을 인증해주세요.');
        FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
          return errorDialog('존재하지 않는 계정입니다.');
        case 'wrong-password':
          return errorDialog('비밀번호가 틀렸습니다.');

        default:
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
