import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failure_to_message.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/usecases/cancel_order_usecase.dart';
import '../../../domain/usecases/get_all_order_usecase.dart';
import '../../../domain/usecases/set_assessment_usecase.dart';
part 'orders_customer_event.dart';
part 'orders_customer_state.dart';

class OrdersCustomerBloc
    extends Bloc<OrdersCustomerEvent, OrdersCustomerState> {
  final GetAllOrderUsecase getAllOrderUsecase;
  final CancelOrderUsecase cancelOrderUsecase;
  final SetAssessmentUsecase setAssessmentUsecase;

  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  OrdersCustomerBloc({
    required this.getAllOrderUsecase,
    required this.setAssessmentUsecase,
    required this.cancelOrderUsecase,
  }) : super(const OrdersCustomerInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        add(const LoadMoreOrdersEvent());
      }
    });

    on<OrdersCustomerEvent>((event, emit) async {
      if (event is GetAllOrdersEvent) {
        emit(const LoadingOrdersCustomerState(null, true, true));
        page = 1;
        final myOrders = await getAllOrderUsecase(1);
        myOrders.fold((failure) {
          emit(FailureOrdersCustomerState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (myOrders) {
          emit(LoadedOrdersCustomerState(
              myOrders: myOrders, hasMore: true, loaded: true));
        });
      } else if (event is SetAssessmentEvent) {
        emit(const LoadingOrdersCustomerState(null, true, true));
        final failureOrDoneMessage =
            await setAssessmentUsecase(event.orderId!, event.assessment!);
        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, Success_MESSAGE),
        );
      } else if (event is CancelOrderEvent) {
        emit(const LoadingOrdersCustomerState(null, true, true));
        final failureOrDoneMessage = await cancelOrderUsecase(event.orderId!);
        emit(
          _eitherDoneMessageOrErrorState(failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });

    on<LoadMoreOrdersEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedOrdersCustomerState(
            myOrders: state.myOrders!, hasMore: true, loaded: false));
        page++;
        final myOrders = await getAllOrderUsecase(page);

        myOrders.fold((failure) {
          page--;
          emit(FailureOrdersCustomerState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (myOrders) {
          if (myOrders.isEmpty) {
            page--;
            emit(LoadedOrdersCustomerState(
                myOrders: state.myOrders!,
                hasMore: false,
                loaded: false));
          } else {
            emit(
              LoadedOrdersCustomerState(
                myOrders: [...state.myOrders!, ...myOrders],
                hasMore: true,
                loaded: true,
              ),
            );
          }
        });
        isLoadingMore = false;
      }
    });
  }

  OrdersCustomerState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) => FailureOrdersCustomerState(
              message: FailureToMessage().mapFailureToMessage(failure),
            ),
        (_) => MessageOrdersCustomerState(message: message));
  }
}
