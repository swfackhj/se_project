import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_team/controller/add_team_controller.dart';

class PlaceSection extends StatelessWidget {
  PlaceSection({super.key});

  final addTeamController = Get.find<AddTeamController>();

  final phoneSize = Get.context!.mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '장소',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: phoneSize.height * 0.01,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                addTeamController.changePlace('히딩크');
              },
              child: Image.asset(
                addTeamController.place == '히딩크'
                    ? 'assets/selected.png'
                    : 'assets/unselected.png',
                width: 18.0,
                height: 18.0,
              ),
            ),
            SizedBox(width: phoneSize.width * 0.01),
            const Text(
              '히딩크',
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
                addTeamController.changePlace('평봉');
              },
              child: Image.asset(
                addTeamController.place == '평봉'
                    ? 'assets/selected.png'
                    : 'assets/unselected.png',
                width: 18.0,
                height: 18.0,
              ),
            ),
            SizedBox(width: phoneSize.width * 0.01),
            const Text(
              '평봉',
              style: TextStyle(fontSize: 16.0),
            )
          ],
        ),
      ],
    );
  }
}
