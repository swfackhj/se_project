import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_team/components/equipment_section.dart';
import 'package:software_engineering/pages/add_team/components/member_section.dart';
import 'package:software_engineering/pages/add_team/components/phone_number_section.dart';
import 'package:software_engineering/pages/add_team/components/place_section.dart';
import 'package:software_engineering/pages/add_team/components/team_name_section.dart';
import 'package:software_engineering/pages/add_team/controller/add_team_controller.dart';

class AddTeamPage extends StatelessWidget {
  AddTeamPage({super.key});

  final addTeamController = Get.put(AddTeamController());

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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: phoneSize.width * 0.1,
            vertical: phoneSize.height * 0.05),
        child: GetBuilder<AddTeamController>(builder: (context) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  TeamNameSection(),
                  SizedBox(height: phoneSize.height * 0.015),
                  PlaceSection(),
                  SizedBox(height: phoneSize.height * 0.015),
                  PhoneNumberSection(),
                  SizedBox(height: phoneSize.height * 0.015),
                  EquipmentSection(),
                  SizedBox(height: phoneSize.height * 0.015),
                  MemberSection(),
                ]),
                ElevatedButton(
                    onPressed: () async {
                      addTeamController.addTeam();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text('등록 완료'))
              ]);
        }),
      ),
    );
  }
}
