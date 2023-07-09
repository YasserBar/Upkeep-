part of 'ads_bloc.dart';

abstract class AdsState extends Equatable {
  final List<SlidersAdsJobs>? ads;
  final bool hasMore;
  final bool loaded;
  const AdsState(this.ads, this.hasMore, this.loaded);

  @override
  List<Object> get props => [ads!, hasMore, loaded];
}

class AdsInitial extends AdsState {
  const AdsInitial(super.ads, super.hasMore, super.loaded);
}

class LoadingAdsState extends AdsState {
  const LoadingAdsState(super.ads, super.hasMore, super.loaded);
}

class FailureAdsState extends AdsState {
  final String message;

  const FailureAdsState(super.ads, super.hasMore, super.loaded,
      {required this.message});

  @override
  List<Object> get props => [message];
}

class LoadedAdsState extends AdsState {
  const LoadedAdsState({required ads, required hasMore, required loaded})
      : super(ads, hasMore, loaded);

  @override
  List<Object> get props => [ads!, hasMore, loaded];
}
