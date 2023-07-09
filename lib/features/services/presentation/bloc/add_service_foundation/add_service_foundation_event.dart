part of 'add_service_foundation_bloc.dart';

abstract class AddServiceFoundationEvent extends Equatable {
  const AddServiceFoundationEvent();

  @override
  List<Object> get props => [];
}

class AddServiceToFoundationEvent extends AddServiceFoundationEvent {
  final AddService myService;

  const AddServiceToFoundationEvent(this.myService);

  @override
  List<Object> get props => [myService];
}
