// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class CustomTextFiled extends StatelessWidget {
  CustomTextFiled({
    super.key,
    this.title,
    this.icon,
    this.hintT,
    this.onChange,
    this.controller,
    this.keyboardType,
    this.validator,
    this.isPassword = false,
    this.onTap,
    this.enableInteractiveSelection,
    this.readOnly,
  });

  final bool isPassword;
  final String? title;
  final IconData? icon;
  final String? hintT;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final void Function()? onTap;
  bool? enableInteractiveSelection;
  bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleTextFiled(title: title, icon: icon),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        TextFormField(
          readOnly: readOnly ?? false,
          enableInteractiveSelection: enableInteractiveSelection,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: isPassword,
          validator: validator,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          style: const TextStyle(overflow: TextOverflow.clip),
          textAlign: TextAlign.right,
          onTap: onTap,
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              hintText: hintT,
              filled: true,
              fillColor: Colors.white,
              hintStyle: const TextStyle(color: Color(0xffC0BEBE))),
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
