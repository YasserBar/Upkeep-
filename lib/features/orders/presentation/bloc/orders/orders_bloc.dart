import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/failure_to_message.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/usecases/cancel_order_usecase.dart';
import '../../../domain/usecases/get_all_order_usecase.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetAllOrderUsecase getAllOrderUsecase;
  final CancelOrderUsecase cancelOrderUsecase;
  OrdersBloc({required this.getAllOrderUsecase, required this.cancelOrderUsecase}) : super(OrdersInitial()) {
    on<OrdersEvent>((event, emit) async{
      if (event is GetAllOrdersEvent) {
        emit(LoadingOrdersState());
        final orders = await getAllOrderUsecase.call(1);
        orders.fold((failure) {
          emit(FailureOrdersState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (orders) {
          emit(LoadedOrdersState(orders));
        });
      }
    });
  }
}
