part of 'stop_foundation_bloc.dart';

abstract class StopFoundationState extends Equatable {
  @override
  List<Object> get props => [];

  const StopFoundationState();
}

class StopFoundationInitial extends StopFoundationState {}

class LoadingStopFoundationState extends StopFoundationState {}

// ignore: must_be_immutable
class SuccessStopFoundationState extends StopFoundationState {
  String message;

  SuccessStopFoundationState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorStopFoundationState extends StopFoundationState {
  final String message;

  const ErrorStopFoundationState(this.message);
}
