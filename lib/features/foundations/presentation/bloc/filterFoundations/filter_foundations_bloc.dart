import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upkeep_plus/features/services/domain/entities/service_foundation.dart';
import '../../../../../core/helpers/failure_to_message.dart';
import '../../../domain/entities/filter_foundations.dart';
import '../../../domain/usecases/filter_foundations_usecase.dart';
part 'filter_foundations_event.dart';
part 'filter_foundations_state.dart';

class FilterServicesFoundationsBloc
    extends Bloc<FilterServicesFoundationsEvent, FilterServicesFoundationsState> {
  final FilterServicesFoundationsUsecase filterServicesFoundationsUsecase;

  int page = 1;
  late FilterFoundations filterServicesFoundations;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  FilterServicesFoundationsBloc({required this.filterServicesFoundationsUsecase})
      : super(const FilterFoundationsInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        if (kDebugMode) {
          print('$filterServicesFoundations))))))))))))))))))))))))');
        }
        add(LoadMoreFilterServicesFoundationsEvent(filterServicesFoundations));
      }
    });

    on<FilterServicesFoundationsEvent>((event, emit) async {
      if (event is LoadedFilterServicesFoundationsEvent) {
        emit(const LoadingFilterServicesFoundationsState(null, true, true));
        page = 1;
        final filter =
            await filterServicesFoundationsUsecase(event.filterFoundations, 1);
        filter.fold((failure) {
          emit(FailureFilterServicesFoundationsState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (filter) {
          emit(LoadedFilterServicesFoundationsState(
              foundations: filter, hasMore: true, loaded: true));
        });
      }
    });

    on<LoadMoreFilterServicesFoundationsEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedFilterServicesFoundationsState(
            foundations: state.servicefoundations!, hasMore: true, loaded: false));
        page++;
        final filter =
            await filterServicesFoundationsUsecase.call(event.filterFoundations, page);
        filter.fold((failure) {
          page--;
          emit(FailureFilterServicesFoundationsState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (foundations) {
          if (foundations.isEmpty) {
            page--;
            emit(LoadedFilterServicesFoundationsState(
                foundations: state.servicefoundations!,
                hasMore: false,
                loaded: false));
          } else {
            emit(
              LoadedFilterServicesFoundationsState(
                foundations: [...state.servicefoundations!, ...foundations],
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
