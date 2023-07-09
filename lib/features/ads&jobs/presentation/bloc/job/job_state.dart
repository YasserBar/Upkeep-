part of 'job_bloc.dart';

abstract class JobState extends Equatable {
  final List<SlidersAdsJobs>? jobs;
  final bool hasMore;
  final bool loaded;
  const JobState(this.jobs, this.hasMore, this.loaded);

  @override
  List<Object> get props => [jobs!, hasMore, loaded];
}

class JobInitial extends JobState {
  const JobInitial(super.jobs, super.hasMore, super.loaded);
}

class LoadingJobState extends JobState {
  const LoadingJobState(super.jobs, super.hasMore, super.loaded);
}

class FailureJobState extends JobState {
  final String message;

  const FailureJobState({required this.message}) : super(null, false, true);
  @override
  List<Object> get props => [message];
}

class LoadedJobState extends JobState {
  const LoadedJobState({required jobs, required hasMore, required loaded})
      : super(jobs, hasMore, loaded);
  @override
  List<Object> get props => [jobs!, hasMore, loaded];
}
