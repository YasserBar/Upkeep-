import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class TiltleOfListview extends StatelessWidget {
  const TiltleOfListview({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
                color: secondryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
