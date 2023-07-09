part of 'subservice_bloc.dart';

abstract class SubServiceState extends Equatable {
  final List<Service>? subService;
  final bool hasMore;
  final bool loaded;
  const SubServiceState(this.subService, this.hasMore, this.loaded);

  @override
  List<Object> get props => [subService!, hasMore, loaded];
}

class SubServiceInitial extends SubServiceState {
  const SubServiceInitial(super.subService, super.hasMore, super.loaded);
}

class LoadingSubServiceState extends SubServiceState {
  const LoadingSubServiceState(super.subService, super.hasMore, super.loaded);
}

class FailureSubServiceState extends SubServiceState {
  final String message;

  const FailureSubServiceState({required this.message})
      : super(null, false, true);
  @override
  List<Object> get props => [message];
}

class LoadedSubServiceState extends SubServiceState {
  const LoadedSubServiceState(
      {required subService, required hasMore, required loaded})
      : super(subService, hasMore, loaded);
  @override
  List<Object> get props => [subService!, hasMore, loaded];
}
