import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/utilities/loading_widget.dart';
import '../../../../../core/utilities/snackbar_message.dart';
import '../../../../../core/widgets/custom_service_button.dart';
import '../../../../../injection_countainer.dart' as di;
import '../../../domain/entities/order.dart';
import '../../bloc/ordersCustomer/orders_customer_bloc.dart';

class ShowOrderContainer extends StatelessWidget {
  final MyOrder myOrder;
  const ShowOrderContainer({
    super.key,
    required this.myOrder,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(myOrder.date);
    double width = MediaQuery.of(context).size.width;
    double conWidth = (358 / 390) * width;
    double textWidth = (298 / 358) * conWidth;
    double statusDateWidth = (358 / 358) * conWidth;
    double dateWidth = (170 / 358) * statusDateWidth;
    double statusWidth = (142 / 358) * statusDateWidth;
    double costWidth = (173 / 358) * conWidth;
    double startWidth = (266 / 358) * conWidth;
    double buttonWidth = (318 / 358) * conWidth;

    return Container(
      width: conWidth,
      height: (347 / 358) * conWidth,
      margin: const EdgeInsets.only(
        top: 120,
        // left: 10,right: 10
      ),
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(42))),
      child: Container(
        width: conWidth,
        height: (347 / 358) * conWidth,
        margin: const EdgeInsets.only(top: 20, right: 10),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => di.sl<OrdersCustomerBloc>()
                  ..add(SetAssessmentEvent(
                      orderId: myOrder.id, assessment: myOrder.assessment))),
            BlocProvider(create: (_) => di.sl<OrdersCustomerBloc>()
                // ..add(CancelOrderEvent(orderId: myOrder.id))
                ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: textWidth,
                height: (70 / 298) * textWidth,
                // color: Colors.amberAccent,
                child: AutoSizeText(
                  myOrder.description,
                  maxFontSize: 20,
                  minFontSize: 10,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.right,
                ),
              ),

              SizedBox(
                width: statusDateWidth,
                height: (40 / 358) * statusDateWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: statusWidth,

                      // color: Colors.white,
                      child: AutoSizeText(
                        myOrder.status,
                        // 'موافق',
                        maxFontSize: 18,
                        minFontSize: 9,

                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondryColor),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                        width: dateWidth,
                        child: AutoSizeText(
                          DateFormat('yyyy/MM/dd hh:mm').format(dateTime),

                          maxFontSize: 18,
                          minFontSize: 9,

                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: secondryColor),
                          //  textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    width: costWidth,
                    height: (38 / 173) * costWidth,
                    child: AutoSizeText(
                      '${myOrder.serviceCost}',
                      maxFontSize: 18,
                      minFontSize: 9,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: secondryColor),
                      textAlign: TextAlign.right,
                    )),
              ),
              // const SizedBox(
              //   height:5 ,
              // ),
              BlocConsumer<OrdersCustomerBloc, OrdersCustomerState>(
                listener: (context, state) {
                  if (state is MessageOrdersCustomerState) {
                    SnackBarMessage().showSuccessSnackBar(
                        message: state.message, context: context);
                    if (kDebugMode) {
                      print("trueeeeeeeeeeeee");
                    }
                  } else if (state is FailureOrdersCustomerState) {
                    SnackBarMessage().showErrorSnackBar(
                        message: state.message, context: context);
                    if (kDebugMode) {
                      print("failureeeeeeeeeeeee");
                    }
                  }
                },
                builder: (context, state) {
                  if (state is LoadingOrdersCustomerState) {
                    // return const LoadingWidget();
                  }
                  return Container(
                    margin: const EdgeInsets.only(right: 30, left: 20),
                    width: startWidth,
                    height: (30.22 / 266) * startWidth,
                    child: Center(
                      child: RatingBar.builder(
                        itemSize: 30,
                        itemCount: 5,
                        initialRating: myOrder.assessment.toDouble(),
                        direction: Axis.horizontal,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 6),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (value) {
                          if (kDebugMode) {
                            print(value);
                          }
                          BlocProvider.of<OrdersCustomerBloc>(context).add(
                              SetAssessmentEvent(
                                  orderId: myOrder.id,
                                  assessment: value.toInt()));
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              BlocConsumer<OrdersCustomerBloc, OrdersCustomerState>(
                listener: (context, state) {
                  if (state is MessageOrdersCustomerState) {
                    Navigator.of(context).pop();
                    SnackBarMessage().showSuccessSnackBar(
                        message: state.message, context: context);
                    if (kDebugMode) {
                      print("trueeeeeeeeeeeee");
                    }
                  } else if (state is FailureOrdersCustomerState) {
                    Navigator.of(context).pop();
                    SnackBarMessage().showErrorSnackBar(
                        message: state.message, context: context);
                    if (kDebugMode) {
                      print("falseeeeeeeeeeeeeeeeee");
                      print(state.message);
                    }
                  }
                },
                builder: (context, state) {
                  if (state is LoadingOrdersCustomerState) {
                    return const LoadingWidget();
                  }
                  return Container(
                      margin: const EdgeInsets.only(right: 10, left: 15),
                      width: buttonWidth,
                      height: (45 / 318) * buttonWidth,
                      child: Center(
                        child: CustomServiceButton(
                          icon: Icons.delete_outline,
                          bgColor: Colors.white,
                          title: 'إلغاء',
                          bsColor: Colors.red,
                          onPressed: () {
                            BlocProvider.of<OrdersCustomerBloc>(context)
                                .add(CancelOrderEvent(orderId: myOrder.id));
                          },
                        ),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
