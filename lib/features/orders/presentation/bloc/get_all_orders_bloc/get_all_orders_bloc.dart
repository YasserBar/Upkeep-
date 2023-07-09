import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../../../main.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/usecases/get_all_order_for_foundation_usecase.dart';
import '../../../domain/usecases/get_all_order_for_service_usecase.dart';

part 'get_all_orders_event.dart';
part 'get_all_orders_state.dart';

class GetAllOrdersBloc extends Bloc<GetAllOrdersEvent, GetAllOrdersState> {
  GetAllOrderForFoundationUsecase getAllOrderForFoundationUsecase;
  GetAllOrderForServiceUsecase getAllOrderForServiceUsecase;

  int page = 1;
  incrementPage() {
    page--;
  }

  int? id;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  GetAllOrdersBloc(
      {required this.getAllOrderForServiceUsecase,
      required this.getAllOrderForFoundationUsecase})
      : super(const GetAllOrdersInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        add(LoadMoreOrderEvent(foundationId: globalFoundationId!, id: id));
      }
    });
    on<GetAllOrdersEvent>((event, emit) async {
      if (event is GetAllOrderForFoundationEvent) {
        emit(const LoadingGetAllOrdersState(null, true, true));
        page = 1;
        final failureOrDoneMessage =
            await getAllOrderForFoundationUsecase.call(1, globalFoundationId!);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      } else if (event is GetAllOrderForServiceEvent) {
        emit(const LoadingGetAllOrdersState(null, true, true));
        page = 1;
        final failureOrDoneMessage =
            await getAllOrderForServiceUsecase.call(1, event.id!);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });

    on<LoadMoreOrderEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(SuccessGetAllOrdersState(
            myOrders: state.myOrders, hasMore: true, loaded: false));
        page++;
        final failureOrDoneMessage = id == null
            ? await getAllOrderForFoundationUsecase.call(
                page, globalFoundationId!)
            : await getAllOrderForServiceUsecase.call(page, event.id!);
        failureOrDoneMessage.fold((failure) {
          page--;
          emit(ErrorGetAllOrdersState(
            mapFailureToMessage(failure),
          ));
        }, (myOrders) {
          if (myOrders.isEmpty) {
            page--;
            emit(SuccessGetAllOrdersState(
                myOrders: state.myOrders!, hasMore: false, loaded: false));
          } else {
            emit(SuccessGetAllOrdersState(
                myOrders: [...state.myOrders!,...myOrders], hasMore: true, loaded: true));
          }
        });
        isLoadingMore = false;
      }
    });
  }
}

GetAllOrdersState _eitherDoneMessageOrErrorStateResponse(
    Either<Failure, List<MyOrder>> either, String message) {
  return either.fold(
    (failure) {
      return ErrorGetAllOrdersState(
        mapFailureToMessage(failure),
      );
    },
    (myOrders) {
      return SuccessGetAllOrdersState(
          myOrders: myOrders, hasMore: true, loaded: true);
    },
  );
}
