import 'package:flutter/material.dart';

import 'custom_textfiled.dart';

class TextFiledFullName extends StatelessWidget {
  const TextFiledFullName({
    super.key,
    this.onChangeFirstName,
    this.onChangeLastName, this.firstController, this.lastController,
  });
  final TextEditingController? firstController;
  final TextEditingController? lastController;
  final void Function(String)? onChangeFirstName;
  final void Function(String)? onChangeLastName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleTextFiled(title: " الاسم والشهرة", icon: Icons.person),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                height: 45,
                width: 82,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextFormField(
                  controller: lastController,
                  onChanged: onChangeLastName,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "الشهرة",
                      hintStyle: TextStyle(color: Color(0xffC0BEBE))),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 45,
                width: 265,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextFormField(
                  controller: firstController,
                  onChanged: onChangeFirstName,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "الاسم",
                      hintStyle: TextStyle(color: Color(0xffC0BEBE))),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
