// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:scholar_chat/core/constant/color.dart';

class CustomButtomLogin extends StatelessWidget {
  final String textbuttom;
  final Function()? onPressed;

  const CustomButtomLogin({
    Key? key,
    required this.textbuttom,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: AppColor.back,
        textColor: AppColor.white,

        onPressed: onPressed,
        child: Text(
          textbuttom,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}
