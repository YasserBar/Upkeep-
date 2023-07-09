part of 'edit_service_foundation_bloc.dart';

abstract class EditServiceFoundationState extends Equatable {
  @override
  List<Object> get props => [];

  const EditServiceFoundationState();
}

class EditServiceFoundationInitial extends EditServiceFoundationState {}

class LoadingEditServiceFoundationState extends EditServiceFoundationState {}

// ignore: must_be_immutable
class SuccessEditServiceFoundationState extends EditServiceFoundationState {
  String message;

  SuccessEditServiceFoundationState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorEditServiceFoundationState extends EditServiceFoundationState {
  final String message;

  const ErrorEditServiceFoundationState(this.message);

  @override
  List<Object> get props => [message];
}
