import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/failure_to_message.dart';
import '../../../domain/entities/sliders_ads_jobs.dart';
import '../../../domain/usecases/get_ads_sliders_usecase.dart';
part 'ads_event.dart';
part 'ads_state.dart';

class AdsBloc extends Bloc<AdsEvent, AdsState> {
  final GetAdsSlidersUsecase getAdsSlidersUsecase;

  int page = 1;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  AdsBloc({required this.getAdsSlidersUsecase})
      : super(const AdsInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) add(const LoadMoreAdsEvent());
    });
    on<AdsEvent>((event, emit) async {
      if (event is GetAllAdsEvent) {
        emit(const LoadingAdsState(null, true, true));
        final ads = await getAdsSlidersUsecase(page);
        ads.fold((failure) {
          emit(FailureAdsState(null, true, true,
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (ads) {
          emit(LoadedAdsState(ads: ads, hasMore: true, loaded: true));
        });
      }
    });
    on<LoadMoreAdsEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedAdsState(ads: state.ads, hasMore: true, loaded: false));
        if (kDebugMode) {
          print("$isLoadingMore-*****************************--");
        }
        page++;
        if (kDebugMode) {
          print("page   $page-+++++++++++++++++++++++++++++");
        }
        final ads = await getAdsSlidersUsecase(page);
        ads.fold((failure) {
          page--;
          emit(FailureAdsState(null, true, true,
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (ads) {
          if (ads.isEmpty) {
            page--;
            emit(
                LoadedAdsState(ads: state.ads!, hasMore: false, loaded: false));
          } else {
            emit(LoadedAdsState(
                ads: [...state.ads!, ...ads], hasMore: true, loaded: true));
          }
        });
      }
      isLoadingMore = false;
      if (kDebugMode) {
        print("$isLoadingMore-------------------------");
      }
    });
  }
}
