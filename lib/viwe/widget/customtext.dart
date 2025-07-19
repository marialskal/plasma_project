import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constant/color.dart';

class CustomText extends StatelessWidget {

  final TextEditingController myController;
  final String? Function(String?)? valid;
  final bool? obscureText;
  final IconData? iconData;
  final void Function()? onTapIcon;

  const CustomText(
      {
      this.onTapIcon,
      this.obscureText,
      this.iconData,
      required this.myController,
      this.valid});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
     
      child: TextFormField(
        validator: valid,
        controller: myController,
        obscureText: obscureText == null || obscureText == false ? false : true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColor.back, width: 4)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
 
          suffixIcon: InkWell(
            
            onTap: onTapIcon,
            child: Icon(
            
              iconData,
              color: AppColor.back,
            ),
          ),
        ),
      ),
    );
  }
}
