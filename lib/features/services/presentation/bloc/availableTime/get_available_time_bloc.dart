import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utilities/failure_to_message.dart';
import '../../../domain/usecases/get_available_time_usecase.dart';
import 'get_available_time_event.dart';
import 'get_available_time_state.dart';

class AvailableTimeBloc
    extends Bloc<GetAvailableTimeEvent, GetAvailableTimeState> {
  final GetAvailableTimeUsecase getAvailableTimeUsecase;
  AvailableTimeBloc({  required  this.getAvailableTimeUsecase}) : super(GetAvailableTimeInitial()) {
    on<GetAvailableTimeEvent>((event, emit) async {
      if (event is LoadedGetAvailableTimeEvent) {
        emit(LoadingGetAvailableTimeState());
        final availableTime = await getAvailableTimeUsecase(event.id);
        availableTime.fold((failure) {
          emit(FailureGetAvailableTimeState(
              message: FailureToMessage().mapFailureToMessage(failure)));
        }, (availableTime) {
          emit(LoadedGetAvailableTimeState(date:availableTime ));
        });
      }
    });
  }
}
