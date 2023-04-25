import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_team/controller/add_team_controller.dart';

class EquipmentSection extends StatelessWidget {
  EquipmentSection({super.key});

  final addTeamController = Get.find<AddTeamController>();

  final phoneSize = Get.context!.mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '장비',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: phoneSize.height * 0.01,
        ),
        Row(
          children: [
            const Text(
              '볼 보유',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              width: phoneSize.width * 0.02,
            ),
            SizedBox(
              width: 18.0,
              height: 18.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Checkbox(
                    activeColor: Colors.black,
                    value: addTeamController.haveBall,
                    onChanged: (value) {
                      addTeamController.chnageBall(value!);
                    }),
              ),
            )
          ],
        ),
        SizedBox(
          height: phoneSize.height * 0.01,
        ),
        Row(
          children: [
            const Text(
              '조끼 보유',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              width: phoneSize.width * 0.02,
            ),
            SizedBox(
              width: 18.0,
              height: 18.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Checkbox(
                    activeColor: Colors.black,
                    value: addTeamController.haveVest,
                    onChanged: (value) {
                      addTeamController.changeVest(value!);
                    }),
              ),
            )
          ],
        ),
      ],
    );
  }
}
