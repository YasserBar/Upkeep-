import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/messages.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/helpers/failuer_message.dart';

import '../../../domain/entities/foundation.dart';
import '../../../domain/usecases/get_all_foundations_for_owner_usecase.dart';

part 'get_all_foundations_event.dart';
part 'get_all_foundations_state.dart';

class GetAllFoundationsBloc
    extends Bloc<GetAllFoundationsEvent, GetAllFoundationsState> {
  GetAllFoundationsForOwnerUsecase getAllFoundationsForOwnerUsecase;

  int page = 1;
  incrementPage() {
    page--;
  }

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  GetAllFoundationsBloc({required this.getAllFoundationsForOwnerUsecase})
      : super(const GetAllFoundationsInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) add(const LoadMoreFoundationOwnerEvent());
    });

    on<GetAllFoundationsEvent>((event, emit) async {
      if (event is GetAllFoundationOwnerEvent) {
        emit(const LoadingGetAllFoundationsState(null, true, true));
        page = 1;
        final failureOrDoneMessage = await getAllFoundationsForOwnerUsecase(1);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE, null, () {}),
        );
      }
    });
    on<LoadMoreFoundationOwnerEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(SuccessGetAllFoundationsState(
            foundations: state.foundations, hasMore: true, loaded: false));
        if (kDebugMode) {
          print("$isLoadingMore-*****************************--");
        }
        page++;
        if (kDebugMode) {
          print("page   $page-+++++++++++++++++++++++++++++");
        }

        final failureOrDoneMessage =
            await getAllFoundationsForOwnerUsecase(page);
        emit(
          _eitherDoneMessageOrErrorStateResponse(failureOrDoneMessage,
              Success_MESSAGE, state.foundations, incrementPage),
        );
        isLoadingMore = false;
        if (kDebugMode) {
          print("$isLoadingMore-------------------------");
        }
      }
    });
  }
}

GetAllFoundationsState _eitherDoneMessageOrErrorStateResponse(
  Either<Failure, List<Foundation>> either,
  String message,
  List<Foundation>? prevFoundations,
  Function incrementPage,
) {
  return either.fold((failure) {
    incrementPage();
    return ErrorGetAllFoundationsState(null, false, true,
        message: mapFailureToMessage(failure));
  }, (foundations) {
    if (kDebugMode) {
      print("prevFoundations  $prevFoundations @@@@@@@@@@@@@@@@@@@@@@@@@@");
    }
    if (prevFoundations != null) {
      if (kDebugMode) {
        print("${foundations.isEmpty} 55555555555555555555555555");
      }
      if (foundations.isEmpty) {
        incrementPage();
        return SuccessGetAllFoundationsState(
            foundations: prevFoundations, hasMore: false, loaded: false);
      }
      return SuccessGetAllFoundationsState(
        foundations: [...prevFoundations, ...foundations],
        hasMore: true,
        loaded: true,
      );
    } else {
      return SuccessGetAllFoundationsState(
          foundations: foundations, hasMore: true, loaded: true);
    }
  });
}
