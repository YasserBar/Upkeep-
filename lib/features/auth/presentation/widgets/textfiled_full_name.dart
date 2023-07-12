import 'package:flutter/material.dart';
import 'custom_textfiled.dart';

class TextFiledFullName extends StatelessWidget {
  const TextFiledFullName({
    super.key,
    this.onChangeFirstName,
    this.onChangeLastName,
    this.firstController,
    this.lastController,
    this.firstValidator,
    this.lastValidator,
  });

  final TextEditingController? firstController;
  final TextEditingController? lastController;
  final void Function(String)? onChangeFirstName;
  final void Function(String)? onChangeLastName;
  final String? Function(String?)? firstValidator;
  final String? Function(String?)? lastValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleTextFiled(title: " الاسم والشهرة", icon: Icons.person),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                controller: lastController,
                onChanged: onChangeLastName,
                validator: lastValidator,
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
              width: 15,
            ),
            Expanded(
              child: TextFormField(
                controller: firstController,
                onChanged: onChangeFirstName,
                validator: firstValidator,
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
      ],
    );
  }
}
