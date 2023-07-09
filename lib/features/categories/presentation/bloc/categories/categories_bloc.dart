import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/failure_to_message.dart';
import '../../../domain/usecases/get_all_service_in_system_usecase.dart';
import 'categories_state.dart';
part 'categories_event.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetAllServiceInSystemUsecase getAllServiceInSystemUsecase;

  int page = 1;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  CategoriesBloc({required this.getAllServiceInSystemUsecase})
      : super(const CategoriesInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) add(const LoadMoreCategoriesEvent());
    });
    on<CategoriesEvent>((event, emit) async {
      if (event is GetAllCategoriesEvent) {
        emit(const LoadingCategoriesState(null, true, true));
        page = 1;
        final categories = await getAllServiceInSystemUsecase(1);
        categories.fold((failure) {
          emit(FailureCategoriesState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (categories) {
          emit(LoadedCategoriesState(
              categories: categories, hasMore: true, loaded: true));
        });
      }
    });

    on<LoadMoreCategoriesEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedCategoriesState(
            categories: state.categories, hasMore: true, loaded: false));
        page++;
        final categories = await getAllServiceInSystemUsecase(page);
        categories.fold((failure) {
          page--;
          emit(FailureCategoriesState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (categories) {
          if (categories.isEmpty) {
            page--;
            emit(LoadedCategoriesState(
                categories: state.categories!, hasMore: false, loaded: false));
          } else {
            emit(
              LoadedCategoriesState(
                categories: [...state.categories!, ...categories],
                hasMore: true,
                loaded: true,
              ),
            );
          }
        });
      }
      isLoadingMore = false;
    });
  }
}
