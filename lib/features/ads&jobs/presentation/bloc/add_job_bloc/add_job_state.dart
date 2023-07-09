part of 'add_job_bloc.dart';

abstract class AddJobState extends Equatable {
  const AddJobState();

  @override
  List<Object> get props => [];
}

class AddJobInitial extends AddJobState {}

class LoadingAddJobState extends AddJobState {
  const LoadingAddJobState();

  @override
  List<Object> get props => [];
}

class SuccessAddJobState extends AddJobState {
  final String message;

  const SuccessAddJobState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorAddJobState extends AddJobState {
  final String message;

  const ErrorAddJobState(this.message);

  @override
  List<Object> get props => [message];
}
