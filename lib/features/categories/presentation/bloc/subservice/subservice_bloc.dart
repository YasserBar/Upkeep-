import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utilities/failure_to_message.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/usecases/get_all_subservice_in_system_usecase.dart';

part 'subservice_event.dart';
part 'subservice_state.dart';

class SubServiceBloc extends Bloc<SubServiceEvent, SubServiceState> {
  final GetAllSubServiceInSystemUsecase getAllSubServiceInSystemUsecase;

  int page = 1;
  late int serviceId;

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  SubServiceBloc({required this.getAllSubServiceInSystemUsecase})
      : super(const SubServiceInitial(null, true, true)) {
    scrollController.addListener(() {
      if (!isLoadingMore) {
        if (kDebugMode) {
          print('$serviceId))))))))))))))))))))))))');
        }
        add(LoadMoreSubServiceEvent(serviceId));
      }
    });

    on<SubServiceEvent>((event, emit) async {
      if (event is GetAllSubServiceEvent) {
        emit(const LoadingSubServiceState(null, true, true));
        page = 1;
        final subService =
            await getAllSubServiceInSystemUsecase.call(event.serviceId, 1);
        subService.fold((failure) {
          emit(FailureSubServiceState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (subService) {
          emit(LoadedSubServiceState(
              subService: subService, hasMore: true, loaded: true));
        });
      }
    });

    on<LoadMoreSubServiceEvent>((event, emit) async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        isLoadingMore = true;
        emit(LoadedSubServiceState(
            subService: state.subService, hasMore: true, loaded: false));
        page++;
        final subService =
            await getAllSubServiceInSystemUsecase.call(event.serviceId, page);
        subService.fold((failure) {
          page--;
          emit(FailureSubServiceState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (subService) {
          if (subService.isEmpty) {
            page--;
            emit(LoadedSubServiceState(
                subService: state.subService!, hasMore: false,loaded: false));
          } else {
            emit(
              LoadedSubServiceState(
                subService: [...state.subService!, ...subService],
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
