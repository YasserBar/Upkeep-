import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class CostumeAppBarAuth extends StatelessWidget {
  const CostumeAppBarAuth({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 3,bottom: 3),
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: const BoxDecoration(
        color: secondryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(200),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(200),
          ),
        ),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: Text(
                title,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )),
      ),
    );
  }
}
