import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title1,
    required this.title2,
    required this.onPressButton,
    this.colorTitle1 = Colors.white,
    this.bgColor = primaryColor,
  });
  final String title1;
  final String title2;
  final Color colorTitle1;
  final Color bgColor;

  final void Function() onPressButton;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressButton,
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .055,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title2,
                style: const TextStyle(
                    color: secondryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .01,
              ),
              Text(
                title1,
                style: TextStyle(color: colorTitle1, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
