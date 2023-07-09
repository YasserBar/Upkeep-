// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import '../../../../../core/utilities/failure_to_message.dart';
// import '../../../domain/entities/service_foundation.dart';
// import '../../../domain/usecases/add_service_to_foundation_usecase.dart';
// import '../../../domain/usecases/get_available_time_usecase.dart';
// part 'details_event.dart';
// part 'details_state.dart';
// class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
//   final GetAvailableTimeUsecase getAvailableTimeUsecase;
//   final AddServiceToFoundationUsecase addServiceToFoundationUsecase;
//   DetailsBloc(this.addServiceToFoundationUsecase, this.getAvailableTimeUsecase) : super(OrdersInitial()) {
//     on<DetailsEvent>((event, emit) async{
//       if (event is GetAllOrdersEvent) {
//         emit(LoadingOrdersState());
//         final orders = await getAllOrderUsecase.call(1);
//         orders.fold((failure) {
//           emit(FailureOrdersState(
//               message: FailureToMessage().mapFailureToMessage(failure)));
//         }, (orders) {
//           emit(LoadedOrdersState(orders));
//         });
//       }
//     });
//   }
// }
