part of 'filter_foundations_in_system_bloc.dart';

abstract class FilterFoundationsInSystemEvent extends Equatable {
  final FilterFoundations filterFoundations;
  const FilterFoundationsInSystemEvent(this.filterFoundations);

  @override
  List<Object> get props => [];
}

class LoadedFilterFoundationsInSystemEvent extends FilterFoundationsInSystemEvent {
  const LoadedFilterFoundationsInSystemEvent({required filterFoundations})
      : super(filterFoundations);
  @override
  List<Object> get props => [filterFoundations];
}

class LoadMoreFilterFoundationsInSystemEvent extends FilterFoundationsInSystemEvent {
  const LoadMoreFilterFoundationsInSystemEvent(super.filterFoundations);

  @override
  List<Object> get props => [];
}
