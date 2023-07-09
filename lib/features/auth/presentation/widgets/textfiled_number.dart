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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.height * .08,
              //  height: MediaQuery.of(context).size.height * .05,
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "+963",
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .08,
              width: MediaQuery.of(context).size.width * .7,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                validator: validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Phone Number",
                    hintStyle: TextStyle(color: Color(0xffC0BEBE))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
