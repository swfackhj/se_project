import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/components/buttons/radio_button.dart';
import 'package:software_engineering/pages/signup/controller/signup_controller.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class ClubSection extends StatelessWidget {
  const ClubSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (signUpController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('동아리', style: titleStyle),
          SizedBox(height: phoneSize.height * 0.01),
          RadioButton(
              text: '밀란',
              type: signUpController.club,
              function: () => signUpController.changeClub('밀란')),
          SizedBox(height: phoneSize.height * 0.01),
          RadioButton(
              text: 'FCL',
              type: signUpController.club,
              function: () => signUpController.changeClub('FCL')),
          SizedBox(height: phoneSize.height * 0.01),
          RadioButton(
              text: '차요차요',
              type: signUpController.club,
              function: () => signUpController.changeClub('차요차요')),
          SizedBox(height: phoneSize.height * 0.01),
          RadioButton(
              text: '없다',
              type: signUpController.club,
              function: () => signUpController.changeClub('없다')),
        ],
      );
    });
  }
}
