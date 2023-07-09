part of 'get_jop_foundation_bloc.dart';

abstract class GetJopFoundationState extends Equatable {
  final List<JobAd>? myJobFoundations;
  final bool hasMore;
  final bool loaded;
  const GetJopFoundationState(this.myJobFoundations, this.hasMore, this.loaded);

  @override
  List<Object> get props => [myJobFoundations!, hasMore, loaded];
}

class GetJopFoundationInitial extends GetJopFoundationState {
  const GetJopFoundationInitial(super.myJobFoundations, super.hasMore, super.loaded);
     
}

class LoadingGetJopFoundationState extends GetJopFoundationState {
  const LoadingGetJopFoundationState(super.myJobFoundations, super.hasMore, super.loaded);

  @override
  List<Object> get props => [];
}

class ErrorGetJopFoundationState extends GetJopFoundationState {
  final String message;

  const ErrorGetJopFoundationState({required this.message})
      : super(null, false, true);

  @override
  List<Object> get props => [message];
}

class SuccessGetJopFoundationState extends GetJopFoundationState {
  const SuccessGetJopFoundationState(
      {required myJobFoundations, required hasMore, required loaded}) : super(myJobFoundations, hasMore, loaded);

  @override
  List<Object> get props => [myJobFoundations!, hasMore, loaded];
}
