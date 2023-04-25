import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_team/components/equipment_section.dart';
import 'package:software_engineering/pages/add_team/components/gender_section.dart';
import 'package:software_engineering/pages/add_team/components/mercenary_section.dart';
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
                  SizedBox(height: phoneSize.height * 0.05),
                  GenderSection(),
                  SizedBox(height: phoneSize.height * 0.015),
                  PlaceSection(),
                  SizedBox(height: phoneSize.height * 0.015),
                  PhoneNumberSection(),
                  SizedBox(height: phoneSize.height * 0.015),
                  EquipmentSection(),
                  SizedBox(height: phoneSize.height * 0.015),
                  MercenarySection(),
                ]),
                ElevatedButton(
                    onPressed: () async {
                      FirebaseFirestore.instance.collection('team').add({
                        'teamName': addTeamController.teamNameController.text,
                        'gender': addTeamController.gender,
                        'place': addTeamController.place,
                        'phoneNumber':
                            '010${addTeamController.middleNumberController.text}${addTeamController.endNumberController.text}',
                        'haveBall': addTeamController.haveBall,
                        'haveVest': addTeamController.haveVest,
                        'isMercenary': addTeamController.isMercenary,
                        'createTime': DateTime.now(),
                      });
                      print(addTeamController.teamNameController.text);
                      Get.back();
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
