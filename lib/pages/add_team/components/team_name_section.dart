import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_team/controller/add_team_controller.dart';

class TeamNameSection extends StatelessWidget {
  TeamNameSection({super.key});

  final addTeamController = Get.find<AddTeamController>();
  final phoneSize = Get.context!.mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: phoneSize.width * 0.2,
          height: phoneSize.width * 0.2,
          color: Colors.black,
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '팀 이름: ',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  width: 100,
                  height: phoneSize.height * 0.025,
                  child: TextField(
                      controller: addTeamController.teamNameController),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
