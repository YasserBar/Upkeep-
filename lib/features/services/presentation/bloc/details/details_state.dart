// part of 'details_bloc.dart';
//
// abstract class DetailsState extends Equatable {
//   const DetailsState();
//
//   @override
//   List<Object> get props => [];
// }
// class OrdersInitial extends  DetailsState{}
// class LoadingDetailsState extends DetailsState {}
//
// class LoadedDetailsState extends  DetailsState{
//   final List<ServiceFoundation> orders;
//   const LoadedDetailsState(this.orders);
//   @override
//   List<Object> get props => [orders];
// }
// class FailureDetailsState extends  DetailsState{
//   final String message;
//
//   const FailureDetailsState({required this.message});
//   @override
//   List<Object> get props => [message];
// }