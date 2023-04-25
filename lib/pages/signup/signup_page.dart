import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/signup/components/club_section.dart';
import 'package:software_engineering/pages/signup/components/email_section.dart';
import 'package:software_engineering/pages/signup/components/gender_section.dart';
import 'package:software_engineering/pages/signup/components/name_section.dart';
import 'package:software_engineering/pages/signup/components/password_section.dart';
import 'package:software_engineering/pages/signup/controller/signup_controller.dart';
import 'package:software_engineering/utils/paddings.dart';
import 'package:software_engineering/utils/styles.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final singnUpController = Get.put(SignUpController());

  final phoneSize = Get.context!.mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('회원가입'),
      ),
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                const EmailSection(),
                SizedBox(height: phoneSize.height * 0.03),
                const PasswordSection(),
                SizedBox(height: phoneSize.height * 0.03),
                const NameSection(),
                SizedBox(height: phoneSize.height * 0.03),
                const GenderSection(),
                SizedBox(height: phoneSize.height * 0.03),
                const ClubSection(),
              ]),
              SizedBox(width: phoneSize.width, child: button()),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget button() {
    return ElevatedButton(
        onPressed: () {
          singnUpController.signUpWithEamil();
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        child: const Text('확인', style: elevatedButtonStyle));
  }
}
