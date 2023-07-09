part of 'service_for_foundation_bloc.dart';

abstract class ServiceForFoundationState extends Equatable {
  const ServiceForFoundationState();
  @override
  List<Object> get props => [];
}

class ServiceForFoundationInitial extends ServiceForFoundationState {}

class LoadingServiceForFoundationState extends ServiceForFoundationState {}

class LoadedServiceForFoundationState extends ServiceForFoundationState {
  final List<ServiceFoundation> serviceFoundation;
  const LoadedServiceForFoundationState({required this.serviceFoundation});
}

class FailureServiceForFoundationState extends ServiceForFoundationState {
  final String message;

  const FailureServiceForFoundationState({required this.message});
}
