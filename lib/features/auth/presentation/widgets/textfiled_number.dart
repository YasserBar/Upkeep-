import 'package:flutter/material.dart';

import 'custom_textfiled.dart';

// ignore: must_be_immutable
class TexetFiledNumber extends StatelessWidget {
  TexetFiledNumber({
    super.key,
    this.onChange,
    this.controller,
    this.validator,
  });

  String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleTextFiled(title: "رقم الهاتف", icon: Icons.phone),
        TextFormField(
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          textAlign: TextAlign.right,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              hintText: "رقم الهاتف",
              fillColor: Colors.white,
              filled: true,
              isDense: true,
              prefix: Text(
                "+963 ",
                style: TextStyle(color: Colors.black),
              ),
              hintStyle: TextStyle(color: Color(0xffC0BEBE))),
        ),
      ],
    );
  }
}
