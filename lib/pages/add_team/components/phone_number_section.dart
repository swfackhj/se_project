import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_team/controller/add_team_controller.dart';

class PhoneNumberSection extends StatelessWidget {
  PhoneNumberSection({super.key});

  final addTeamController = Get.put(AddTeamController());

  final phoneSize = Get.context!.mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '휴대폰 번호',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            const Text(
              '010',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              width: phoneSize.width * 0.025,
            ),
            const Text('-'),
            SizedBox(
              width: phoneSize.width * 0.025,
            ),
            SizedBox(
              width: phoneSize.width * 0.15,
              height: phoneSize.height * 0.05,
              child: TextField(
                controller: addTeamController.middleNumberController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.fromLTRB(phoneSize.width * 0.03, 0, 0, 0)),
              ),
            ),
            SizedBox(
              width: phoneSize.width * 0.025,
            ),
            const Text('-'),
            SizedBox(
              width: phoneSize.width * 0.025,
            ),
            SizedBox(
              width: phoneSize.width * 0.15,
              height: phoneSize.height * 0.05,
              child: TextField(
                controller: addTeamController.endNumberController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.fromLTRB(phoneSize.width * 0.03, 0, 0, 0)),
              ),
            ),
          ],
        )
      ],
    );
  }
}
