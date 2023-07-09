part of 'ads_bloc.dart';

abstract class AdsEvent extends Equatable {
  const AdsEvent();

  @override
  List<Object> get props => [];
}
class GetAllAdsEvent extends AdsEvent {

  const GetAllAdsEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreAdsEvent extends AdsEvent {
  const LoadMoreAdsEvent();

  @override
  List<Object> get props => [];
}