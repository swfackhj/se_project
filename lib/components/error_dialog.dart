import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/utils/styles.dart';

Future<dynamic> errorDialog(String content) {
  return Get.defaultDialog(
    title: '오류',
    titleStyle: titleStyle,
    content: Text(content),
    textConfirm: '확인',
    buttonColor: Colors.black,
    confirmTextColor: Colors.white,
    onConfirm: Get.back,
  );
}

Future<dynamic> dialog(String content) {
  return Get.defaultDialog(
    title: '알림',
    titleStyle: titleStyle,
    content: Text(content),
    textConfirm: '확인',
    buttonColor: Colors.black,
    confirmTextColor: Colors.white,
    onConfirm: Get.back,
  );
}
