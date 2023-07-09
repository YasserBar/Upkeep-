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
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        border: Border.all(
          color: secondryColor,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.only(
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
    );
  }
}
