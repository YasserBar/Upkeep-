import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/features/foundations/domain/usecases/foundations_in_system_filtering_usecase.dart';
import '../../../../../core/helpers/failure_to_message.dart';
import '../../../domain/entities/filter_foundations.dart';
import '../../../domain/entities/foundation.dart';
part 'filter_foundations_in_system_event.dart';
part 'filter_foundations_in_system_state.dart';

class FilterFoundationsInSystemBloc extends Bloc<FilterFoundationsInSystemEvent,
    FilterFoundationsInSystemState> {
  final FilterFoundationsInSystemUsecase filterFoundationsInSystemUsecase;

  int page = 1;
  late FilterFoundations filterFoun;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  FilterFoundationsInSystemBloc(
      {required this.filterFoundationsInSystemUsecase})
      : super(const FilterFoundationsInSystemInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        if (kDebugMode) {
          print('$filterFoun))))))))))))))))))))))))');
        }
        add(LoadMoreFilterFoundationsInSystemEvent(filterFoun));
      }
    });

    on<FilterFoundationsInSystemEvent>((event, emit) async {
      if (event is LoadedFilterFoundationsInSystemEvent) {
        emit(const LoadingFilterFoundationsInSystemState(null, true, true));
        page = 1;
        final filter = await filterFoundationsInSystemUsecase(
            event.filterFoundations, page);
        filter.fold((failure) {
          emit(FailureFilterFoundationsInSystemState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (filter) {
          emit(LoadedFilterFoundationsInSystemState(
              foundations: filter, hasMore: true, loaded: true));
        });
      }
    });

    on<LoadMoreFilterFoundationsInSystemEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedFilterFoundationsInSystemState(
            foundations: state.foundations!, hasMore: true, loaded: false));
        page++;
        final filter = await filterFoundationsInSystemUsecase.call(
            event.filterFoundations, page);
        filter.fold((failure) {
          page--;
          emit(FailureFilterFoundationsInSystemState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (foundations) {
          if (foundations.isEmpty) {
            page--;
            emit(LoadedFilterFoundationsInSystemState(
                foundations: state.foundations!,
                hasMore: false,
                loaded: false));
          } else {
            emit(
              LoadedFilterFoundationsInSystemState(
                foundations: [...state.foundations!, ...foundations],
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
