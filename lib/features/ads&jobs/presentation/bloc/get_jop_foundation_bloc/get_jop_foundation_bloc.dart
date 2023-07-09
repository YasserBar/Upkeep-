import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/messages.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/helpers/failuer_message.dart';
import '../../../../../main.dart';
import '../../../domain/entities/job_ad.dart';
import '../../../domain/usecases/show_all_job_for_foundation.dart';

part 'get_jop_foundation_event.dart';
part 'get_jop_foundation_state.dart';

class GetJopFoundationBloc
    extends Bloc<GetJopFoundationEvent, GetJopFoundationState> {
  final ShowAllJobForFoundationUsecase showAllJobForFoundationUsecase;

  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  GetJopFoundationBloc({required this.showAllJobForFoundationUsecase})
      : super(const GetJopFoundationInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        add(LoadMoreJopsForFoundationEvent(globalFoundationId!));
      }
    });

    on<GetJopFoundationEvent>((event, emit) async {
      if (event is ShowAllJopsForFoundationEvent) {
        emit(const LoadingGetJopFoundationState(null, true, true));
        page = 1;
        final failureOrDoneMessage =
            await showAllJobForFoundationUsecase(1, globalFoundationId!);

        emit(
          _eitherDoneMessageOrErrorStateResponse(
              failureOrDoneMessage, Success_MESSAGE),
        );
      }
    });

    on<LoadMoreJopsForFoundationEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(
          SuccessGetJopFoundationState(
            myJobFoundations: state.myJobFoundations!,
            hasMore: true,
            loaded: false,
          ),
        );
        page++;

        final failureOrDoneMessage =
            await showAllJobForFoundationUsecase(page, globalFoundationId!);
        failureOrDoneMessage.fold((failure) {
          page--;
          emit(ErrorGetJopFoundationState(
            message: mapFailureToMessage(failure),
          ));
        }, (myJobFoundations) {
          if (myJobFoundations.isEmpty) {
            page--;
            emit(SuccessGetJopFoundationState(
                myJobFoundations: state.myJobFoundations!,
                hasMore: false,
                loaded: false));
          } else {
            emit(
              SuccessGetJopFoundationState(
                myJobFoundations: [
                  ...state.myJobFoundations!,
                  ...myJobFoundations
                ],
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
}

GetJopFoundationState _eitherDoneMessageOrErrorStateResponse(
    Either<Failure, List<JobAd>> either, String message) {
  return either.fold(
      (failure) => ErrorGetJopFoundationState(
            message: mapFailureToMessage(failure),
          ),
      (myJobFoundations) => SuccessGetJopFoundationState(
          myJobFoundations: myJobFoundations, hasMore: true, loaded: true));
}
