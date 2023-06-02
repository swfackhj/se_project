import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/signup/controller/signup_controller.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class PasswordSection extends StatelessWidget {
  const PasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (signUpController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('비밀번호', style: titleStyle),
          SizedBox(height: phoneSize.height * 0.01),
          SizedBox(
            height: phoneSize.height * 0.05,
            child: TextField(
              controller: signUpController.passwordController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.fromLTRB(phoneSize.width * 0.03, 0, 0, 0),
                  hintText: '비밀번호를 입력해주세요'),
              obscureText: true,
              cursorColor: Colors.black,
            ),
          )
        ],
      );
    });
  }
}
