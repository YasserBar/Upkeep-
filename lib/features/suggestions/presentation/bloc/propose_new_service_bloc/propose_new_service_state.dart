part of 'propose_new_service_bloc.dart';

abstract class ProposeNewServiceState extends Equatable {
  const ProposeNewServiceState();

  @override
  List<Object> get props => [];
}

class ProposeNewServiceInitial extends ProposeNewServiceState {
  @override
  List<Object> get props => [];
}

class LoadingProposeNewServiceState extends ProposeNewServiceState {
  const LoadingProposeNewServiceState();

  @override
  List<Object> get props => [];
}

class SuccessProposeNewServiceState extends ProposeNewServiceState {
  final String message;

  const SuccessProposeNewServiceState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorProposeNewServiceState extends ProposeNewServiceState {
  final String message;

  const ErrorProposeNewServiceState({required this.message});

  @override
  List<Object> get props => [message];
}
