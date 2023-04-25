import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_mercenary/controller/add_mercenary_controller.dart';
import 'package:software_engineering/utils/sizes.dart';

class TitleSection extends StatelessWidget {
  TitleSection({super.key});

  final addMercenaryController = Get.find<AddMercenaryController>();

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
            height: phoneSize.height * 0.05,
            padding: EdgeInsets.symmetric(horizontal: phoneSize.width * 0.03),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.black)),
            child: Row(children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: phoneSize.width * 0.15,
                child: const Text("제목"),
              ),
              Flexible(
                  child: TextField(
                controller: addMercenaryController.titleContoller,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '제목을 입력해주세요',
                    hintStyle: TextStyle(color: Colors.grey[300])),
                cursorColor: Colors.blue,
              ))
            ])));
  }
}
