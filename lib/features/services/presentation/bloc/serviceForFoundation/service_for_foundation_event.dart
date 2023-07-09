part of 'service_for_foundation_bloc.dart';

abstract class ServiceForFoundationEvent extends Equatable {
  const ServiceForFoundationEvent();

  @override
  List<Object> get props => [];
}
class GetServiceForFoundationEvent extends ServiceForFoundationEvent{
 final int foundationId;
 final  int page;

 const GetServiceForFoundationEvent({ required  this.foundationId,required this.page});
}
