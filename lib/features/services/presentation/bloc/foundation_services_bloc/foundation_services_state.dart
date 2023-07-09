part of 'foundation_services_bloc.dart';

abstract class FoundationServicesState extends Equatable {
  final List<ServiceFoundation>? myServices;
  final bool hasMore;
  final bool loaded;
  const FoundationServicesState(this.myServices, this.hasMore, this.loaded);

  @override
  List<Object> get props => [myServices!, hasMore, loaded];
}

class FoundationServicesInitial extends FoundationServicesState {
  const FoundationServicesInitial(
      super.myServices, super.hasMore, super.loaded);
}

class LoadingFoundationServicesState extends FoundationServicesState {
  const LoadingFoundationServicesState(
      super.myServices, super.hasMore, super.loaded);
}

class ErrorFoundationServicesState extends FoundationServicesState {
  final String message;

  const ErrorFoundationServicesState(this.message) : super(null, false, true);

  @override
  List<Object> get props => [message];
}

class SuccessFoundationServicesState extends FoundationServicesState {
  const SuccessFoundationServicesState(
      {required myServices, required hasMore, required loaded})
      : super(myServices, hasMore, loaded);

  @override
  List<Object> get props => [myServices!, hasMore, loaded];
}
