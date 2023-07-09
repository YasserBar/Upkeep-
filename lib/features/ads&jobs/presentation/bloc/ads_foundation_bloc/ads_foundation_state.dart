part of 'ads_foundation_bloc.dart';

abstract class AdsFoundationState extends Equatable {
  final List<JobAd>? myAdsFoundations;
  final bool hasMore;
  final bool loaded;
  const AdsFoundationState(this.myAdsFoundations, this.hasMore, this.loaded);

  @override
  List<Object> get props => [myAdsFoundations!, hasMore, loaded];
}

class AdsFoundationInitial extends AdsFoundationState {
  const AdsFoundationInitial(
      super.myAdsFoundations, super.hasMore, super.loaded);

  @override
  List<Object> get props => [];
}

class LoadingAdsFoundationState extends AdsFoundationState {
  const LoadingAdsFoundationState(
      super.myAdsFoundations, super.hasMore, super.loaded);

  @override
  List<Object> get props => [];
}

class ErrorAdsFoundationState extends AdsFoundationState {
  final String message;

  const ErrorAdsFoundationState({required this.message})
      : super(null, false, false);

  @override
  List<Object> get props => [message];
}

class SuccessAdsFoundationState extends AdsFoundationState {
  const SuccessAdsFoundationState(
      {required myAdsFoundation, required hasMore, required loaded})
      : super(myAdsFoundation, hasMore, loaded);

  @override
  List<Object> get props => [myAdsFoundations!, hasMore, loaded];
}
