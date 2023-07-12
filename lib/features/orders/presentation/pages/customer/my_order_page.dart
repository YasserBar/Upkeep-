import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/core/theme/colors.dart';
import '../../../../../core/pages/pages/empty_pages.dart';
import '../../../../../core/widgets/loading_widget.dart';

import '../../../../../injection_countainer.dart' as di;
import '../../../../locations/presentation/widgets/appbar.dart';
import '../../../domain/entities/order.dart';
import '../../bloc/ordersCustomer/orders_customer_bloc.dart';
import '../../widgets/customer/my_order_container.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});
  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 80),
              BlocProvider(
                create: (_) =>
                    di.sl<OrdersCustomerBloc>()..add(const GetAllOrdersEvent()),
                child: BlocBuilder<OrdersCustomerBloc, OrdersCustomerState>(
                  builder: (context, state) {
                    if (state is LoadingOrdersCustomerState) {
                      return const Center(
                        child: LoadingWidget(
                          vertical: 200,
                        ),
                      );
                    } else if (state is LoadedOrdersCustomerState) {
                      List<MyOrder> myOrders = state.myOrders!;

                      if (myOrders.isEmpty) {
                        return const EmptyPages();
                      }
                      return Expanded(
                        child: ListView.builder(
                            controller: context
                                .read<OrdersCustomerBloc>()
                                .scrollController,
                            clipBehavior: Clip.none,
                            physics: const BouncingScrollPhysics(),
                            itemCount: myOrders.length + 1,
                            itemBuilder: (context, index) {
                              if (index < myOrders.length) {
                                if (kDebugMode) {
                                  print("$myOrders=======================");
                                }
                                return MyOrderContainer(
                                  myOrder: myOrders[index],
                                );
                              } else {
                                return state.loaded
                                    ? const SizedBox()
                                    : Container(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 40),
                                        child: state.hasMore
                                            ? const LoadingWidget(vertical: 0.0)
                                            : const Center(
                                                child: Text(
                                                    "لا يوجد المزيد من الطلبات"),
                                              ),
                                      );
                              }
                            }),
                      );
                    } else if (state is FailureOrdersCustomerState) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  state.message,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blueGrey[50],
                                child: IconButton(
                                  onPressed: () {
                                    context.read<OrdersCustomerBloc>().add(
                                          const GetAllOrdersEvent(),
                                        );
                                  },
                                  icon: const Icon(
                                    Icons.replay_sharp,
                                    color: secondryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: LoadingWidget(
                        vertical: 200,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBarrr(
              enableLocation: false,
              pageName: 'طلباتي',
              setCountryId: () {},
              setCityId: () {},
              setRegionId: () {},
            ),
          ),
        ],
      ),
    );
  }
}
