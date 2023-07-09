import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class TitleDetails extends StatelessWidget {
  final String name;

  const TitleDetails({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double titleDetailsWidth = (318 / 390) * width;
    return SizedBox(
      width: titleDetailsWidth,
      // height: (50/318)*titleDetailsWidth,
      child: AutoSizeText(
        name,
        maxFontSize: 22,
        minFontSize: 10,
        maxLines: 2,
        style: const TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
