part of 'add_job_bloc.dart';

abstract class AddJobEvent extends Equatable {
  const AddJobEvent();

  @override
  List<Object> get props => [];
}

class AddJobForFoundationEvent extends AddJobEvent {
  final JobAd job;
  final int foundationId;
  const AddJobForFoundationEvent(this.job, this.foundationId);

  @override
  List<Object> get props => [job, foundationId];
}
