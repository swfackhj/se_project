import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/signup/controller/signup_controller.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class NameSection extends StatelessWidget {
  const NameSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (signUpController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('이름', style: titleStyle),
          SizedBox(height: phoneSize.height * 0.01),
          SizedBox(
            height: phoneSize.height * 0.05,
            child: TextField(
              controller: signUpController.nameController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.fromLTRB(phoneSize.width * 0.03, 0, 0, 0),
                  hintText: '이름을 입력해주세요'),
              cursorColor: Colors.black,
            ),
          )
        ],
      );
    });
  }
}
