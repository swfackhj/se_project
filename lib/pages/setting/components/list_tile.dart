import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  Icon icon;
  String title;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(title),
      iconColor: Colors.black,
      textColor: Colors.black,
    );
  }
}
