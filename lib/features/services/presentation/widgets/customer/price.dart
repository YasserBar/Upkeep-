import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/theme/colors.dart';

class Price extends StatelessWidget {
  // final ServiceFoundation ?serviceFoundation;

  const Price({
    super.key,
    required this.price,
  });
  final int price;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double priceWiddth = (390 / 390) * width;
    return Container(
      width: priceWiddth,
      margin: const EdgeInsets.all(20),
      child: AutoSizeText(
        price.toString(),
        maxFontSize: 20,
        minFontSize: 10,
        // maxLines: 2,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: secondryColor),
        textAlign: TextAlign.end,
      ),
    );
  }
}
