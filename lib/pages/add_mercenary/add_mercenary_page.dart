import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_mercenary/components/editor_section.dart';
import 'package:software_engineering/pages/add_mercenary/components/member_section.dart';
import 'package:software_engineering/pages/add_mercenary/components/title_section.dart';
import 'package:software_engineering/pages/add_mercenary/controller/add_mercenary_controller.dart';
import 'package:software_engineering/pages/add_mercenary/components/phone_number_section.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class AddMercenaryPage extends StatelessWidget {
  AddMercenaryPage({super.key});

  final addMercenaryController = Get.put(AddMercenaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: phoneSize.width * 0.1,
              vertical: phoneSize.height * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleSection(),
                      SizedBox(
                        height: phoneSize.height * 0.01,
                      ),
                      EditorSection(),
                      SizedBox(
                        height: phoneSize.height * 0.01,
                      ),
                      Row(children: [
                        PhoneNumberSection(),
                        SizedBox(width: phoneSize.width * 0.01),
                        MemberSection(),
                      ]),
                      SizedBox(
                        height: phoneSize.height * 0.01,
                      ),
                      Container(
                          height: phoneSize.height * 0.45,
                          padding: EdgeInsets.symmetric(
                              horizontal: phoneSize.width * 0.05,
                              vertical: phoneSize.height * 0.01),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: phoneSize.width * 0.15,
                                  padding: EdgeInsets.only(
                                      top: phoneSize.height * 0.02),
                                  child: const Text(
                                    "내용",
                                  ),
                                ),
                                Flexible(
                                    child: TextField(
                                  controller:
                                      addMercenaryController.contentController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '내용을 입력해주세요',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300])),
                                  cursorColor: Colors.blue,
                                ))
                              ])),
                    ]),
              ),
              SizedBox(
                width: phoneSize.width,
                child: ElevatedButton(
                  onPressed: () {
                    addMercenaryController.addMercenary();
                    Get.back();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text('완료', style: elevatedButtonStyle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
