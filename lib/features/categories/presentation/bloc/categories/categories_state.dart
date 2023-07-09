import 'package:equatable/equatable.dart';
import '../../../domain/entities/service.dart';

abstract class CategoriesState extends Equatable {
  final List<Service>? categories;
  final bool hasMore;
  final bool loaded;
  const CategoriesState(this.categories, this.hasMore, this.loaded);

  @override
  List<Object> get props => [categories!, hasMore, loaded];
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial(super.categories, super.hasMore, super.loaded);
}

class LoadingCategoriesState extends CategoriesState {
  const LoadingCategoriesState(super.categories, super.hasMore, super.loaded);
}

class FailureCategoriesState extends CategoriesState {
  final String message;

  const FailureCategoriesState({required this.message})
      : super(null, false, true);
  @override
  List<Object> get props => [message];
}

class LoadedCategoriesState extends CategoriesState {
  const LoadedCategoriesState(
      {required categories, required hasMore, required loaded})
      : super(categories, hasMore, loaded);
  @override
  List<Object> get props => [categories!, hasMore, loaded];
}
