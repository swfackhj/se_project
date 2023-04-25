import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/pages/add_mercenary/controller/add_mercenary_controller.dart';
import 'package:software_engineering/utils/sizes.dart';

class MemberSection extends StatefulWidget {
  MemberSection({super.key});

  final List<String> list = ['1', '2', '3', '4', '5'];

  @override
  State<MemberSection> createState() => _MemberSectionState();
}

class _MemberSectionState extends State<MemberSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMercenaryController>(
        builder: (addMercenaryController) {
      return Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: phoneSize.width * 0.15,
            height: phoneSize.height * 0.05,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButton(
                value: addMercenaryController.members,
                underline: Container(),
                icon: const Icon(Icons.person),
                iconSize: 21.0,
                items: widget.list.map((String item) {
                  return DropdownMenuItem<String>(
                      value: item, child: Text(item));
                }).toList(),
                onChanged: (members) {
                  addMercenaryController.changeMembers(members!);
                }),
          )
        ],
      );
    });
  }
}
