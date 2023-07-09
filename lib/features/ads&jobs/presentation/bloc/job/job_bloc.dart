import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/failure_to_message.dart';
import '../../../domain/entities/sliders_ads_jobs.dart';
import '../../../domain/usecases/get_jobs_sliders_usecase.dart';
part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final GetJobsSlidersUsecase getJobsSlidersUsecase;

  int page = 1;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  JobBloc({required this.getJobsSlidersUsecase})
      : super(const JobInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        add(const LoadMoreJobEvent());
      }
    });

    on<JobEvent>((event, emit) async {
      if (event is GetAllJobEvent) {
        emit(const LoadingJobState(null, true, true));
        page = 1;
        final jobs = await getJobsSlidersUsecase.call(1);
        jobs.fold((failure) {
          emit(FailureJobState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (jobs) {
          emit(LoadedJobState(jobs: jobs, hasMore: true, loaded: true));
        });
      }
    });

    on<LoadMoreJobEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedJobState(jobs: state.jobs, hasMore: true, loaded: false));
        page++;
        final jobs =
            await getJobsSlidersUsecase.call(page);
        jobs.fold((failure) {
          page--;
          emit(FailureJobState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (jobs) {
          if (jobs.isEmpty) {
            page--;
            emit(LoadedJobState(
                jobs: state.jobs!, hasMore: false, loaded: false));
          } else {
            emit(
              LoadedJobState(
                jobs: [...state.jobs!, ...jobs],
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
