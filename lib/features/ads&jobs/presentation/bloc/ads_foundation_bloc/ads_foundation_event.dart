part of 'ads_foundation_bloc.dart';

abstract class AdsFoundationEvent extends Equatable {
  final int id;
  const AdsFoundationEvent(this.id);

  @override
  List<Object> get props => [];
}

class ShowAllAdsForFoundationEvent extends AdsFoundationEvent {
  const ShowAllAdsForFoundationEvent({required id}) : super(id);

  @override
  List<Object> get props => [id];
}

class LoadMoreAdsForFoundationEvent extends AdsFoundationEvent {
  const LoadMoreAdsForFoundationEvent(super.id);

  @override
  List<Object> get props => [];
}
