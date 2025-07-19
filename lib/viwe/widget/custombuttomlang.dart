import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constant/color.dart';
class CustomButtomLang extends StatelessWidget {
  final String textbuttom;
  final void Function()? onPressed;

  const CustomButtomLang({Key? key, required this.textbuttom, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
   
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      width: double.infinity,
      child: MaterialButton(
        color: Color.fromARGB(255, 202, 125, 217),
        textColor: AppColor.white,
        height: height / 10,
        // minWidth: width / 3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: const Radius.circular(30))),
        onPressed: onPressed,
        child: Text(
          textbuttom,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
