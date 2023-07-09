import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    this.title,
    this.icon,
    this.hintT,
    this.onChange,
    this.controller,
    this.keyboardType,
    this.validator,
    this.isPassword = false,
  });

  final bool isPassword;
  final String? title;
  final IconData? icon;
  final String? hintT;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleTextFiled(title: title, icon: icon),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Container(
          //  height: MediaQuery.of(context).size.height * .05,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: isPassword,
            validator: validator,
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            onChanged: onChange,
            style: const TextStyle(overflow: TextOverflow.clip),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintT,
                hintStyle: const TextStyle(color: Color(0xffC0BEBE))),
          ),
        ),
      ],
    );
  }
}

class TitleTextFiled extends StatelessWidget {
  const TitleTextFiled({
    super.key,
    required this.title,
    required this.icon,
  });

  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title!,
          style: const TextStyle(
              color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .01,
        ),
        Icon(
          icon,
          color: primaryColor,
        ),
      ],
    );
  }
}
