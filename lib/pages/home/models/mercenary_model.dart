import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engineering/utils/styles.dart';

class MercenaryModel extends StatelessWidget {
  MercenaryModel(
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
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.withOpacity(0.1)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: phoneSize.width * 0.05,
            vertical: phoneSize.width * 0.03),
        child: Column(children: [
          Row(
            children: [
              SizedBox(
                width: phoneSize.width * 0.15,
                height: phoneSize.width * 0.15,
                child: Image.asset('assets/default.png'),
              ),
              SizedBox(width: phoneSize.width * 0.05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          editor,
                          style: subTitleStyle.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(createTime)
                      ],
                    ),
                    SizedBox(height: phoneSize.height * 0.01),
                    Text(title)
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
                    Text('$members/6'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [Icon(Icons.location_on), Text('히딩크 드림필드')],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
