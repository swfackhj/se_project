import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_team/controller/add_team_controller.dart';

class GenderSection extends StatelessWidget {
  GenderSection({super.key});

  final addTeamController = Get.find<AddTeamController>();

  final phoneSize = Get.context!.mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '성별',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: phoneSize.height * 0.01,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                addTeamController.changeGender('남자');
              },
              child: Image.asset(
                addTeamController.gender == '남자'
                    ? 'assets/selected.png'
                    : 'assets/unselected.png',
                width: 18.0,
                height: 18.0,
              ),
            ),
            SizedBox(width: phoneSize.width * 0.01),
            const Text(
              '남자',
              style: TextStyle(fontSize: 16.0),
            )
          ],
        ),
        SizedBox(
          height: phoneSize.height * 0.01,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                addTeamController.changeGender('여자');
              },
              child: Image.asset(
                addTeamController.gender == '여자'
                    ? 'assets/selected.png'
                    : 'assets/unselected.png',
                width: 18.0,
                height: 18.0,
              ),
            ),
            SizedBox(width: phoneSize.width * 0.01),
            const Text(
              '여자',
              style: TextStyle(fontSize: 16.0),
            )
          ],
        )
      ],
    );
  }
}
