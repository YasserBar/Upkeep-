part of 'stop_service_bloc.dart';

abstract class StopServiceState extends Equatable {
  @override
  List<Object> get props => [];

  const StopServiceState();
}

class StopServiceInitial extends StopServiceState {}

class LoadingStopServiceState extends StopServiceState {}

// ignore: must_be_immutable
class SuccessStopServiceState extends StopServiceState {
  String message;

  SuccessStopServiceState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorStopServiceState extends StopServiceState {
  final String message;

  const ErrorStopServiceState(this.message);
}
