part of 'add_service_foundation_bloc.dart';

abstract class AddServiceFoundationState extends Equatable {
  const AddServiceFoundationState();

  @override
  List<Object> get props => [];
}

class AddServiceFoundationInitial extends AddServiceFoundationState {}

class LoadingAddServiceFoundationState extends AddServiceFoundationState {}

// ignore: must_be_immutable
class SuccessAddServiceFoundationState extends AddServiceFoundationState {
  String message;

  SuccessAddServiceFoundationState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorAddServiceFoundationState extends AddServiceFoundationState {
  final String message;

  const ErrorAddServiceFoundationState(this.message);

  @override
  List<Object> get props => [message];
}
