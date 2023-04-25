import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_mercenary/controller/add_mercenary_controller.dart';
import 'package:software_engineering/utils/sizes.dart';

class PhoneNumberSection extends StatelessWidget {
  PhoneNumberSection({super.key});

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
                child: const Text("전화번호"),
              ),
              Flexible(
                  child: TextField(
                controller: addMercenaryController.phoneNumberController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'ex. 010-0000-0000',
                    hintStyle: TextStyle(color: Colors.grey[300])),
                cursorColor: Colors.black,
              ))
            ])));
  }
}
