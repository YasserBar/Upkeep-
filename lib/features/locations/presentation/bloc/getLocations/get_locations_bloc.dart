import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utilities/failure_to_message.dart';
import '../../../domain/usecases/get_locations.dart';
import 'get_locations_event.dart';
import 'get_locations_state.dart';

class GetLocationsBloc extends Bloc<GetLocationsEvent, GetLocationsState> {
  final GetLocationsUsecase getLocationsUsecase;
  GetLocationsBloc({required this.getLocationsUsecase})
      : super(GetLocationsInitial()) {
    on<GetLocationsEvent>((event, emit) async {
      emit(LoadingGetLocationsState());
      final country = await getLocationsUsecase();
      country.fold((failure) {
        emit(FailureGetLocationsState(
            message: FailureToMessage().mapFailureToMessage(failure)));
      }, (country) {
        emit(LoadedGetAllCountryState(country: country));
      });
    });
  }
}
