import 'package:flutter/material.dart';

import 'custom_textfiled.dart';

class TextFiledFullName extends StatelessWidget {
  const TextFiledFullName({
    super.key,
    this.onChangeFirstName,
    this.onChangeLastName,
    this.firstController,
    this.lastController,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextFormField(
                  controller: lastController,
                  onChanged: onChangeLastName,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      hintText: "الشهرة",
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Color(0xffC0BEBE))),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: firstController,
                  onChanged: onChangeFirstName,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      hintText: "الاسم",
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Color(0xffC0BEBE))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
