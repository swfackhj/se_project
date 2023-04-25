import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_team/controller/add_team_controller.dart';

class MercenarySection extends StatelessWidget {
  MercenarySection({super.key});

  final addTeamController = Get.find<AddTeamController>();

  final phoneSize = Get.context!.mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '용병 모집 여부',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                value: addTeamController.isMercenary,
                onChanged: (value) {
                  addTeamController.changeMercenary(value!);
                }),
          ),
        )
      ],
    );
  }
}
