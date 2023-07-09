import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/aseets/assets.dart';
import '../../../../../core/theme/colors.dart';
import '../../../domain/entities/order.dart';
import '../../pages/customer/show_order_page.dart';

class MyOrderContainer extends StatelessWidget {
  final MyOrder myOrder;

  const MyOrderContainer({
    super.key,
    required this.myOrder,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double conWidth = (358 / 390) * width;
    double photoWidth = (143 / 358) * conWidth;
    double colWidth = (188 / 358) * conWidth;
    double textDescriptionWidth = (188 / 188) * colWidth;
    double textDateWidth = (141 / 188) * colWidth;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShowOrderPage(
            myOrder: myOrder,
          ),
        )),
        child: Container(
          width: conWidth,
          height: (133 / 358) * conWidth,
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: colWidth,
                  height: (133 / 188) * colWidth,
                  margin: const EdgeInsets.only(left: 10, right: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: textDescriptionWidth,
                        height: (77 / 188) * textDescriptionWidth,
                        margin: const EdgeInsets.only(top: 20, right: 10),
                        child: AutoSizeText(
                          myOrder.description,
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          maxFontSize: 16,
                          minFontSize: 8,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        width: textDateWidth,
                        height: (21 / 141) * textDateWidth,
                        child: AutoSizeText(
                          myOrder.date == ''
                              ? ''
                              : DateFormat('yyyy/MM/dd hh:mm')
                                  .format(DateTime.parse(myOrder.date)),
                          maxFontSize: 16,
                          minFontSize: 8,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: secondryColor),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: photoWidth,
                height: (111 / 143) * photoWidth,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage(AssetClass.Logo),
                    ),
                    border: Border.all(color: secondryColor, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
