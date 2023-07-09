import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../../../main.dart';
import '../../../domain/entities/job_ad.dart';
import '../../../domain/usecases/show_all_ads_for_foundation.dart';

part 'ads_foundation_event.dart';
part 'ads_foundation_state.dart';

class AdsFoundationBloc extends Bloc<AdsFoundationEvent, AdsFoundationState> {
  ShowAllAdsForFoundationUsecase showAllAdsForFoundationUsecase;

  int page = 1;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  AdsFoundationBloc({required this.showAllAdsForFoundationUsecase})
      : super(const AdsFoundationInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        add(LoadMoreAdsForFoundationEvent(globalFoundationId!));
      }
    });

    on<AdsFoundationEvent>((event, emit) async {
      if (event is ShowAllAdsForFoundationEvent) {
        emit(const LoadingAdsFoundationState(null, true, true));
        page = 1;
        final failureOrDoneMessage =
            await showAllAdsForFoundationUsecase(1, globalFoundationId!);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });

    on<LoadMoreAdsForFoundationEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(SuccessAdsFoundationState(
            myAdsFoundation: state.myAdsFoundations!,
            hasMore: true,
            loaded: false));
        page++;
        final failureOrDoneMessage =
            await showAllAdsForFoundationUsecase(page, globalFoundationId!);
        failureOrDoneMessage.fold((failure) {
          page--;
          emit(
            ErrorAdsFoundationState(
              message: mapFailureToMessage(failure),
            ),
          );
        }, (myAdsFoundations) {
          if (myAdsFoundations.isEmpty) {
            page--;
            emit(SuccessAdsFoundationState(
                myAdsFoundation: state.myAdsFoundations!,
                hasMore: false,
                loaded: false));
          } else {
            emit(SuccessAdsFoundationState(myAdsFoundation: [
              ...state.myAdsFoundations!,
              ...myAdsFoundations
            ], hasMore: true, loaded: true));
          }
        });
        isLoadingMore = false;
      }
    });
  }
}

AdsFoundationState _eitherDoneMessageOrErrorStateResponse(
    Either<Failure, List<JobAd>> either, String message) {
  return either.fold(
    (failure) => ErrorAdsFoundationState(
      message: mapFailureToMessage(failure),
    ),
    (myAdsFoundations) => SuccessAdsFoundationState(
        myAdsFoundation: myAdsFoundations, hasMore: true, loaded: true),
  );
}
