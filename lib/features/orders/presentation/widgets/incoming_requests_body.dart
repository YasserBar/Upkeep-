import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utilities/loading_widget.dart';
import '../../../../core/utilities/snackbar_message.dart';
import '../../../locations/presentation/widgets/appbar.dart';
import '../../domain/entities/order.dart';
import '../bloc/get_all_orders_bloc/get_all_orders_bloc.dart';
import 'incoming_request_show_item.dart';

class IncomingRequestBody extends StatelessWidget {
  const IncomingRequestBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 117),
                BlocBuilder<GetAllOrdersBloc, GetAllOrdersState>(
                  builder: (context, state) {
                    context.read<GetAllOrdersBloc>().id = null;
                    if (state is SuccessGetAllOrdersState) {
                      List<MyOrder> myOrders = state.myOrders!;
                      if (myOrders.isEmpty) {
                        return const Center(child: Text("لا يوجد طلبات"));
                      }
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.73,
                        child: ListView.builder(
                          controller:
                              context.read<GetAllOrdersBloc>().scrollController,
                          clipBehavior: Clip.none,
                          physics: const BouncingScrollPhysics(),
                          itemCount: myOrders.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < myOrders.length) {
                              return IncomingRequestShowItem(
                                serviceName: "${myOrders[index].name} ",
                                serviceImg: myOrders[index].description,
                                serviceDate: myOrders[index].date,
                                serviceDescription: myOrders[index].description,
                                requestId: myOrders[index].id,
                              );
                            } else {
                              return state.loaded
                                  ? const SizedBox()
                                  : Container(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 40),
                                      child: state.hasMore
                                          ? const LoadingWidget(
                                              vertical: 0.0,
                                            )
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
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        SnackBarMessage().showErrorSnackBar(
                            message: state.message, context: context);
                      });
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * .6,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.message,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: LoadingWidget());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBarrr(
            enableLocation: false,
            pageName: 'طلباتي الواردة',
            setCountryId: () {},
            setCityId: () {},
            setRegionId: () {},
          ),
        ),
      ],
    );
  }
}
