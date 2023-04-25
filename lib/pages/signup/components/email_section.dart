import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/signup/controller/signup_controller.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class EmailSection extends StatelessWidget {
  const EmailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (signUpController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('이메일', style: titleStyle),
          SizedBox(height: phoneSize.height * 0.01),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: phoneSize.height * 0.05,
                  child: TextField(
                    controller: signUpController.emailController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(
                            phoneSize.width * 0.03, 0, 0, 0),
                        hintText: '이메일을 입력해주세요'),
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ),
              ),
              SizedBox(width: phoneSize.width * 0.01),
              const Text('@', style: TextStyle(fontSize: 14.0)),
              SizedBox(width: phoneSize.width * 0.01),
              const Text('handong.ac.kr', style: TextStyle(fontSize: 14.0)),
              SizedBox(width: phoneSize.width * 0.01),
            ],
          )
        ],
      );
    });
  }
}
