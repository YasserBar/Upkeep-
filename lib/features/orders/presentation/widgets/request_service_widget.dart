import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/aseets/assets.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/helpers/loading_widget.dart';
import '../../../locations/presentation/widgets/appbar.dart';
import '../../../services/domain/entities/service_foundation.dart';
import '../../domain/entities/order.dart';
import '../bloc/accept_cancel_order_bloc/accept_rejected_order_bloc.dart';
import '../bloc/get_all_orders_bloc/get_all_orders_bloc.dart';

class RequestServiceBody extends StatelessWidget {
  const RequestServiceBody({Key? key, required this.service}) : super(key: key);

  final ServiceFoundation service;
  @override
  Widget build(BuildContext context) {
    final String serviceName = service.name;
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 117),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            BlocBuilder<GetAllOrdersBloc, GetAllOrdersState>(
              builder: (context, state) {
                context.read<GetAllOrdersBloc>().id = service.id;
                if (state is SuccessGetAllOrdersState) {
                  List<MyOrder> myOrders = state.myOrders!;
                  if (myOrders.isEmpty) {
                    return const Text("لا يوجد طلبات");
                  }
                  return Expanded(
                    child: ListView.builder(
                      controller:
                          context.read<GetAllOrdersBloc>().scrollController,
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: myOrders.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < myOrders.length) {
                          return Column(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Text(
                                            serviceName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            margin:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                            child: const Text(
                                              "serviceDate",
                                              style: TextStyle(
                                                  color: secondryColor,
                                                  fontSize: 17,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                BlocProvider.of<
                                                            AcceptRejectedOrderBloc>(
                                                        context)
                                                    .add(
                                                  AcceptOrderEvent(
                                                    1,
                                                  ),
                                                );
                                              },
                                              child: Image.asset(
                                                  AssetClass.Correct),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                  isScrollControlled: true,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(60),
                                                    ),
                                                  ),
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child: Container(
                                                        margin:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 20,
                                                                horizontal:
                                                                    30),
                                                        child: const Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize
                                                                  .min,
                                                          children: <Widget>[
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Text(
                                                                'شرح طلب الزبون',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        22),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Text(
                                                                "serviceDescription",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Image.asset(
                                                AssetClass.Chat,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                BlocProvider.of<
                                                            AcceptRejectedOrderBloc>(
                                                        context)
                                                    .add(RejectedOrderEvent(
                                                  service.id,
                                                ));
                                              },
                                              child: Image.asset(
                                                  AssetClass.False),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return state.loaded
                              ? const SizedBox()
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: state.hasMore
                                      ? const LoadingWidget()
                                      : const Center(
                                          child: Text(
                                              "لا يوجد المزيد من الطلبات"),
                                        ),
                                );
                        }
                      },
                    ),
                  );
                } else if (state is ErrorGetAllOrdersState) {
                  return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(state.message));
                }
                return const Center(child: LoadingWidget());
              },
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBarrr(
            enableLocation: false,
            pageName: 'طلبات الخدمة',
            setCountryId: () {},
            setCityId: () {},
            setRegionId: () {},
          ),
        ),
      ],
    );
  }
}
