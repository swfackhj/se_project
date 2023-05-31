import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/login/controller/login_controller.dart';
import 'package:software_engineering/pages/signup/signup_page.dart';
import 'package:software_engineering/utils/sizes.dart';
import 'package:software_engineering/utils/styles.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  final logInController = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: phoneSize.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: logInController.emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  label: Text('ID'),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                cursorColor: Colors.black,
              ),
              SizedBox(
                height: phoneSize.height * 0.025,
              ),
              TextField(
                controller: logInController.passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  label: Text('Password'),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                cursorColor: Colors.black,
                obscureText: true,
              ),
              SizedBox(
                height: phoneSize.height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      logInController.signInWithEmail(
                          logInController.emailController.text,
                          logInController.passwordController.text);
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: phoneSize.width * 0.375,
                        height: phoneSize.height * 0.05,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black),
                        child: const Text(
                          '로그인',
                          style: elevatedButtonStyle,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SignUpPage());
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: phoneSize.width * 0.375,
                        height: phoneSize.height * 0.05,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          '회원가입',
                          style:
                              elevatedButtonStyle.copyWith(color: Colors.black),
                        )),
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
