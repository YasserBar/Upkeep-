import 'package:flutter_bloc/flutter_bloc.dart';

part 'propose_service_event.dart';
part 'propose_service_state.dart';

class ProposeServiceBloc
    extends Bloc<ProposeServiceEvent, ProposeServiceState> {
  ProposeServiceBloc() : super(ProposeServiceInitial()) {
    on<ProposeServiceEvent>((event, emit) {
    });
  }
}
