import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/models/user_model.dart';
import 'package:software_engineering/utils/styles.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String gender = '남자';
  String club = '없다';

  void changeGender(String gender) {
    this.gender = gender;
    update();
  }

  void changeClub(String club) {
    this.club = club;
    update();
  }

  Future<void> signUpWithEamil() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: '${emailController.text}@handong.ac.kr',
              password: passwordController.text)
          .then((userCredential) {
        final user = UserModel(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
            gender: gender,
            club: club,
            emailVerified: 'false',
            uid: userCredential.user!.uid);
        FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential.user?.uid)
            .set(user.toJson());
        FirebaseAuth.instance.currentUser?.sendEmailVerification();
        Get.back();
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'email-already-in-use':
          return errorDialog('이미 사용중인 이메일입니다.');
        case 'weak-password':
          return errorDialog('비밀번호 형식이 잘못되었습니다.');
      }
    }
  }

  Future<dynamic> errorDialog(String content) {
    return Get.defaultDialog(
      title: '회원가입 오류',
      titleStyle: titleStyle,
      content: Text(content),
      textConfirm: '확인',
      buttonColor: Colors.black,
      confirmTextColor: Colors.white,
      onConfirm: Get.back,
    );
  }
}
