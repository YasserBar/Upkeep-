import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utilities/failure_to_message.dart';
import '../../../domain/entities/filter_foundations.dart';
import '../../../domain/entities/foundation.dart';
import '../../../domain/usecases/filter_foundations_usecase.dart';
part 'filter_foundations_event.dart';
part 'filter_foundations_state.dart';

class FilterFoundationsBloc
    extends Bloc<FilterFoundationsEvent, FilterFoundationsState> {
  final FilterFoundationsUsecase filterFoundationsUsecase;

  int page = 1;
  late FilterFoundations filterFoundations;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  FilterFoundationsBloc({required this.filterFoundationsUsecase})
      : super(const FilterFoundationsInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        if (kDebugMode) {
          print('$filterFoundations))))))))))))))))))))))))');
        }
        add(LoadMoreFilterFoundationsEvent(filterFoundations));
      }
    });

    on<FilterFoundationsEvent>((event, emit) async {
      if (event is LoadedFilterFoundationsEvent) {
        emit(const LoadingFilterFoundationsState(null, true, true));
        page = 1;
        final filter =
            await filterFoundationsUsecase(event.filterFoundations, 1);
        filter.fold((failure) {
          emit(FailureFilterFoundationsState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (filter) {
          emit(LoadedFilterFoundationsState(
              foundations: filter, hasMore: true, loaded: true));
        });
      }
    });

    on<LoadMoreFilterFoundationsEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedFilterFoundationsState(
            foundations: state.foundations!, hasMore: true, loaded: false));
        page++;
        final filter =
            await filterFoundationsUsecase.call(event.filterFoundations, page);
        filter.fold((failure) {
          page--;
          emit(FailureFilterFoundationsState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (foundations) {
          if (foundations.isEmpty) {
            page--;
            emit(LoadedFilterFoundationsState(
                foundations: state.foundations!,
                hasMore: false,
                loaded: false));
          } else {
            emit(
              LoadedFilterFoundationsState(
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
