import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utilities/failure_to_message.dart';
import '../../../domain/entities/service_foundation.dart';
import '../../../domain/usecases/get_all_service_for_foundation_usecase.dart';
part 'service_for_foundation_event.dart';
part 'service_for_foundation_state.dart';

class ServiceForFoundationBloc
    extends Bloc<ServiceForFoundationEvent, ServiceForFoundationState> {
  final GetAllServiceForFoundationUsecase getAllServiceForFoundationUsecase;
  ServiceForFoundationBloc({required this.getAllServiceForFoundationUsecase})
      : super(ServiceForFoundationInitial()) {
    on<ServiceForFoundationEvent>((event, emit) async {
      if (event is GetServiceForFoundationEvent) {
        emit(LoadingServiceForFoundationState());
        final serviceFoundation =
            await getAllServiceForFoundationUsecase(event.foundationId, 1);
        serviceFoundation.fold((failure) {
          emit(FailureServiceForFoundationState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (serviceFoundation) {
          emit(LoadedServiceForFoundationState(
              serviceFoundation: serviceFoundation));
        });
      }
    });
  }
}
