part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class GetAllJobEvent extends JobEvent {
  const GetAllJobEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreJobEvent extends JobEvent {
  const LoadMoreJobEvent();

  @override
  List<Object> get props => [];
}
