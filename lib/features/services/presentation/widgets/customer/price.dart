import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/theme/colors.dart';

class Price extends StatelessWidget {
  // final ServiceFoundation ?serviceFoundation;

  const Price({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double priceWiddth = (390 / 390) * width;
    return Container(
      width: priceWiddth,
      // height: (50/390)*priceWiddth,

      margin: const EdgeInsets.all(20),
      child: const AutoSizeText(
        '250,000 ',
        maxFontSize: 20,
        minFontSize: 10,
        // maxLines: 2,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: secondryColor),
        textAlign: TextAlign.end,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
