import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../../../main.dart';
import '../../../domain/entities/service_foundation.dart';
import '../../../domain/usecases/get_all_service_for_foundation_usecase.dart';

part 'foundation_services_event.dart';
part 'foundation_services_state.dart';

class FoundationServicesBloc
    extends Bloc<FoundationServicesEvent, FoundationServicesState> {
  GetAllServiceForFoundationUsecase getAllServiceForFoundationUsecase;

  int page = 1;
  incrementPage() {
    page--;
  }

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  FoundationServicesBloc({required this.getAllServiceForFoundationUsecase})
      : super(const FoundationServicesInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        add(LoadMoreServiceForFoundationEvent(globalFoundationId!));
      }
    });

    on<FoundationServicesEvent>((event, emit) async {
      if (event is GetAllServiceForFoundationEvent) {
        emit(const LoadingFoundationServicesState(null, true, true));
        page = 1;
        final failureOrDoneMessage =
            await getAllServiceForFoundationUsecase(globalFoundationId!, 1);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE, null, () {}),
        );
      }
    });

    on<LoadMoreServiceForFoundationEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(SuccessFoundationServicesState(
            myServices: state.myServices, hasMore: true, loaded: false));
        page++;
        final failureOrDoneMessage =
            await getAllServiceForFoundationUsecase(globalFoundationId!, page);

        emit(
          _eitherDoneMessageOrErrorStateResponse(failureOrDoneMessage,
              Success_MESSAGE, state.myServices, incrementPage),
        );
        isLoadingMore = false;
      }
    });
  }
}

FoundationServicesState _eitherDoneMessageOrErrorStateResponse(
  Either<Failure, List<ServiceFoundation>> either,
  String message,
  List<ServiceFoundation>? prevServicesFoundation,
  Function incrementPage,
) {
  return either.fold((failure) {
    incrementPage();
    return ErrorFoundationServicesState(
      mapFailureToMessage(failure),
    );
  }, (myServices) {
    if (prevServicesFoundation != null) {
      if (myServices.isEmpty) {
        incrementPage();
        return SuccessFoundationServicesState(
            myServices: prevServicesFoundation, hasMore: false, loaded: false);
      }
      return SuccessFoundationServicesState(
          myServices: [...prevServicesFoundation, ...myServices],
          hasMore: true,
          loaded: true);
    } else {
      return SuccessFoundationServicesState(
          myServices: myServices, hasMore: true, loaded: true);
    }
  });
}
