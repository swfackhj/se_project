import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/utils/styles.dart';

class MercenaryComponent extends StatelessWidget {
  MercenaryComponent(
      {super.key,
      required this.title,
      required this.editor,
      required this.phoneNumber,
      required this.members,
      required this.content,
      required this.createTime});
  final String title;
  final String editor;
  final String phoneNumber;
  final String members;
  final String content;
  final String createTime;

  final phoneSize = Get.context!.mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: phoneSize.width,
      height: phoneSize.height * 0.15,
      decoration: BoxDecoration(
          border: Border.all(width: 1.0),
          borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: phoneSize.width * 0.05,
            vertical: phoneSize.width * 0.03),
        child: Column(children: [
          Row(
            children: [
              const CircleAvatar(
                  backgroundImage: AssetImage('assets/default.png')),
              SizedBox(width: phoneSize.width * 0.05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: subTitleStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: phoneSize.width * 0.01),
                            Text(editor),
                          ],
                        ),
                        Text(createTime)
                      ],
                    ),
                    SizedBox(height: phoneSize.height * 0.01),
                    Text(content)
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: phoneSize.height * 0.01,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person),
                    SizedBox(width: phoneSize.width * 0.01),
                    Text('$members / 6'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.phone),
                    SizedBox(width: phoneSize.width * 0.01),
                    Text(phoneNumber)
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
