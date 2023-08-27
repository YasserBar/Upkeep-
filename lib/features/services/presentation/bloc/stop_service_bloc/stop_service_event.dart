part of 'stop_service_bloc.dart';

abstract class StopServiceEvent extends Equatable {
  @override
  List<Object> get props => [];

  const StopServiceEvent();
}
class DoStopServiceEvent extends StopServiceEvent {
  final int id;

  const DoStopServiceEvent(this.id);

  @override
  List<Object> get props => [id];
}
