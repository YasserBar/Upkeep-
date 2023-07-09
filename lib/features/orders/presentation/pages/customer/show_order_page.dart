import 'package:flutter/material.dart';
import '../../../../locations/presentation/widgets/appbar.dart';
import '../../../domain/entities/order.dart';
import '../../widgets/customer/show_order_container.dart';

class ShowOrderPage extends StatelessWidget {
  final MyOrder myOrder;
  const ShowOrderPage({super.key, required this.myOrder});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          AppBarrr(
            pageName: ' عرض الطلب  ',
            setCountryId: () {},
            setCityId: () {},
            setRegionId: () {},
          ),
          ShowOrderContainer(
            myOrder: myOrder,
          )
        ],
      ),
    ));
  }
}
