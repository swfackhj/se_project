import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/components/buttons/radio_button.dart';
import 'package:software_engineering/pages/signup/controller/signup_controller.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class GenderSection extends StatelessWidget {
  const GenderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (signUpController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('성별', style: titleStyle),
          SizedBox(height: phoneSize.height * 0.01),
          RadioButton(
              text: '남자',
              type: signUpController.gender,
              function: () => signUpController.changeGender('남자')),
          SizedBox(height: phoneSize.height * 0.01),
          RadioButton(
              text: '여자',
              type: signUpController.gender,
              function: () => signUpController.changeGender('여자')),
        ],
      );
    });
  }
}
