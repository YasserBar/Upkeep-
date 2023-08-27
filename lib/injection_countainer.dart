import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upkeep_plus/features/foundations/domain/usecases/foundations_in_system_filtering_usecase.dart';
import 'package:upkeep_plus/features/foundations/domain/usecases/stop_foundation_usecase.dart';
import 'package:upkeep_plus/features/foundations/presentation/bloc/stop_foundation_bloc/stop_foundation_bloc.dart';
import 'package:upkeep_plus/features/services/presentation/bloc/stop_service_bloc/stop_service_bloc.dart';
import 'core/helpers/network_info.dart';
import 'features/ads&jobs/data/datasources/ads_and_jobs_remote_data_source.dart';
import 'features/ads&jobs/data/repositories/ads_and_jobs_repo_impl.dart';
import 'features/ads&jobs/domain/repositories/ads_and_jobs_repo.dart';
import 'features/ads&jobs/domain/usecases/add_job._usecase.dart';
import 'features/ads&jobs/domain/usecases/get_ads_sliders_usecase.dart';
import 'features/ads&jobs/domain/usecases/get_jobs_sliders_usecase.dart';
import 'features/ads&jobs/domain/usecases/show_all_ads_for_foundation.dart';
import 'features/ads&jobs/domain/usecases/show_all_job_for_foundation.dart';
import 'features/ads&jobs/presentation/bloc/add_job_bloc/add_job_bloc.dart';
import 'features/ads&jobs/presentation/bloc/ads/ads_bloc.dart';
import 'features/ads&jobs/presentation/bloc/ads_foundation_bloc/ads_foundation_bloc.dart';
import 'features/ads&jobs/presentation/bloc/get_jop_foundation_bloc/get_jop_foundation_bloc.dart';
import 'features/ads&jobs/presentation/bloc/job/job_bloc.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repo_impl.dart';
import 'features/auth/domain/repositories/auth_repo.dart';
import 'features/auth/domain/usecases/change_password.dart';
import 'features/auth/domain/usecases/forget_password.dart';
import 'features/auth/domain/usecases/login_customer.dart';
import 'features/auth/domain/usecases/login_provider.dart';
import 'features/auth/domain/usecases/logout.dart';
import 'features/auth/domain/usecases/resend_pin.dart';
import 'features/auth/domain/usecases/signup.dart';
import 'features/auth/domain/usecases/verify_pin_forget.dart';
import 'features/auth/domain/usecases/verify_pin_signup.dart';
import 'features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/change_password_logout_bloc/change_password_logout_bloc.dart';
import 'features/categories/data/datasources/categories_remote_data_source.dart';
import 'features/categories/data/repositories/categories_repo_impl.dart';
import 'features/categories/domain/repositories/categories_repo.dart';
import 'features/categories/domain/usecases/get_all_service_in_system_usecase.dart';
import 'features/categories/domain/usecases/get_all_subservice_in_system_usecase.dart';
import 'features/categories/presentation/bloc/categories/categories_bloc.dart';
import 'features/categories/presentation/bloc/subservice/subservice_bloc.dart';
import 'features/foundations/data/datasources/foundations_remote_data_source.dart';
import 'features/foundations/data/repositories/foundations_repo_impl.dart';
import 'features/foundations/domain/repositories/foundations_repo.dart';
import 'features/foundations/domain/usecases/filter_foundations_usecase.dart';
import 'features/foundations/domain/usecases/get_all_foundations_for_owner_usecase.dart';
import 'features/foundations/presentation/bloc/filterFoundations/filter_foundations_bloc.dart';
import 'features/foundations/presentation/bloc/filterFoundationsInSystem/filter_foundations_in_system_bloc.dart';
import 'features/foundations/presentation/bloc/get_all_foundation_bloc/get_all_foundations_bloc.dart';
import 'features/locations/data/datasources/locations_remote_data_source.dart';
import 'features/locations/data/repositories/locations_repo_impl.dart';
import 'features/locations/domain/repositories/locations_repo.dart';
import 'features/locations/domain/usecases/get_locations.dart';
import 'features/locations/presentation/bloc/getLocations/get_locations_bloc.dart';
import 'features/orders/data/datasources/order_remote_data_source.dart';
import 'features/orders/data/repositories/order_repo_impl.dart';
import 'features/orders/domain/repositories/order_repo.dart';
import 'features/orders/domain/usecases/accept_order_usecase.dart';
import 'features/orders/domain/usecases/block_user_foundation_usecase.dart';
import 'features/orders/domain/usecases/block_user_service_usecase.dart';
import 'features/orders/domain/usecases/cancel_order_usecase.dart';
import 'features/orders/domain/usecases/get_all_order_for_foundation_usecase.dart';
import 'features/orders/domain/usecases/get_all_order_for_service_usecase.dart';
import 'features/orders/domain/usecases/get_all_order_usecase.dart';
import 'features/orders/domain/usecases/rejected_order_usecase.dart';
import 'features/orders/domain/usecases/set_assessment_usecase.dart';
import 'features/orders/presentation/bloc/accept_cancel_order_bloc/accept_rejected_order_bloc.dart';
import 'features/orders/presentation/bloc/get_all_orders_bloc/get_all_orders_bloc.dart';
import 'features/orders/presentation/bloc/orders/orders_bloc.dart';
import 'features/orders/presentation/bloc/ordersCustomer/orders_customer_bloc.dart';
import 'features/services/data/datasources/service_remote_data_source.dart';
import 'features/services/data/repositories/service_repo_impl.dart';
import 'features/services/domain/repositories/service_repo.dart';
import 'features/services/domain/usecases/add_service_to_foundation_usecase.dart';
import 'features/services/domain/usecases/edit_service_usecase.dart';
import 'features/services/domain/usecases/get_all_service_for_foundation_usecase.dart';
import 'features/services/domain/usecases/get_available_time_usecase.dart';
import 'features/services/domain/usecases/reservation_service_usecase.dart';
import 'features/services/domain/usecases/stop_service_usecase.dart';
import 'features/services/presentation/bloc/add_service_foundation/add_service_foundation_bloc.dart';
import 'features/services/presentation/bloc/availableTime/get_available_time_bloc.dart';
import 'features/services/presentation/bloc/edit_service_foundation_bloc/edit_service_foundation_bloc.dart';
import 'features/services/presentation/bloc/foundation_services_bloc/foundation_services_bloc.dart';
import 'features/services/presentation/bloc/reservation/reservation_bloc.dart';
import 'features/suggestions/data/datasources/suggestion_remote_data_source.dart';
import 'features/suggestions/data/repositories/suggestions_repo_impl.dart';
import 'features/suggestions/domain/repositories/suggestions_repo.dart';
import 'features/suggestions/domain/usecases/get_all_my_propose_usecase.dart';
import 'features/suggestions/domain/usecases/propose_new_service_usecase.dart';
import 'features/suggestions/presentation/bloc/get_all_my_propose_bloc/get_all_my_propose_bloc.dart';
import 'features/suggestions/presentation/bloc/propose_new_service_bloc/propose_new_service_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//? Features ================================

//! Feature - Ads&Jobs
// Bloc

  sl.registerFactory(() => AdsBloc(getAdsSlidersUsecase: sl()));
  sl.registerFactory(() => JobBloc(getJobsSlidersUsecase: sl()));
  sl.registerFactory(
      () => AdsFoundationBloc(showAllAdsForFoundationUsecase: sl()));
  sl.registerFactory(
      () => GetJopFoundationBloc(showAllJobForFoundationUsecase: sl()));
  sl.registerFactory(() => AddJobBloc(addJobUsecase: sl()));
// Usecases

  sl.registerLazySingleton(() => AddJobUsecase(sl()));
  sl.registerLazySingleton(() => GetAdsSlidersUsecase(sl()));
  sl.registerLazySingleton(() => GetJobsSlidersUsecase(sl()));
  sl.registerLazySingleton(() => ShowAllAdsForFoundationUsecase(sl()));
  sl.registerLazySingleton(() => ShowAllJobForFoundationUsecase(sl()));
// Repository
  sl.registerLazySingleton<AdsAndJobsRepo>(() => AdsAndJobsRepoImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
// Datasources
  sl.registerLazySingleton<AdsAndJobsRemoteDataSource>(
      () => AdsAndJobsRemoteDataSourceImplWithHttp(client: sl()));

//! Feature - auth
// Bloc
  sl.registerFactory(() => AuthBloc(
        loginCustomerUsecase: sl(),
        loginProviderUsecase: sl(),
        forgetPasswordUsecase: sl(),
        signupUsecase: sl(),
        resendPinUsecase: sl(),
        verifyPinForgetUsecase: sl(),
        verifyPinSignupUsecase: sl(),
      ));
  sl.registerFactory(() => ChangePasswordLogoutBloc(
        logoutUsecase: sl(),
        changePasswordUsecase: sl(),
      ));

// Usecases
  sl.registerLazySingleton(() => ChangePasswordUsecase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => LoginCustomerUsecase(sl()));
  sl.registerLazySingleton(() => LoginProviderUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => ResendPinUsecase(sl()));
  sl.registerLazySingleton(() => SignupUsecase(sl()));
  sl.registerLazySingleton(() => VerifyPinForgetUsecase(sl()));
  sl.registerLazySingleton(() => VerifyPinSignupUsecase(sl()));

// Repository
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplWithHttp(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImplWithSharedPreferences(pref: sl()));

//! Feature - categories
// Bloc

  sl.registerFactory(() => CategoriesBloc(getAllServiceInSystemUsecase: sl()));
  sl.registerFactory(
      () => SubServiceBloc(getAllSubServiceInSystemUsecase: sl()));

// Usecases
  sl.registerLazySingleton(() => GetAllServiceInSystemUsecase(sl()));
  sl.registerLazySingleton(() => GetAllSubServiceInSystemUsecase(sl()));

// Repository
  sl.registerLazySingleton<CategoriesRepo>(() => CategoriesRepoImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
      () => CategoriesRemoteDataSourceImplWithHttp(client: sl()));

//! Feature - locations

// Bloc

  sl.registerFactory(() => GetLocationsBloc(getLocationsUsecase: sl()));

// Usecases
  sl.registerFactory(() => GetLocationsUsecase(sl()));

// Repository
  sl.registerLazySingleton<LocationsRepo>(
      () => LocationsRepoImpl(remoteDataSource: sl(), networkInfo: sl()));

// Datasources
  sl.registerLazySingleton<LocationsRemoteDataSource>(
      () => LocationsRemoteDataSourceImplWithHttp(client: sl()));

//! Feature - foundations

// Bloc
  sl.registerFactory(() => GetAllFoundationsBloc(
        getAllFoundationsForOwnerUsecase: sl(),
      ));
  sl.registerFactory(() => FilterFoundationsInSystemBloc(
        filterFoundationsInSystemUsecase: sl(),
      ));

  sl.registerFactory(() =>
      FilterServicesFoundationsBloc(filterServicesFoundationsUsecase: sl()));

  sl.registerFactory(() => StopFoundationBloc(stopServiceUsecase: sl()));
// Usecases
  sl.registerLazySingleton(() => GetAllFoundationsForOwnerUsecase(sl()));
  sl.registerLazySingleton(() => FilterServicesFoundationsUsecase(sl()));
  sl.registerLazySingleton(() => StopFoundationUsecase(sl()));
  sl.registerLazySingleton(() => FilterFoundationsInSystemUsecase(sl()));

// Repository
  sl.registerLazySingleton<FoundationsRepo>(() => FoundationsRepoImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources
  sl.registerLazySingleton<FoundationsRemoteDataSource>(
      () => FoundationsRemoteDataSourceImplWithHttp(client: sl()));

//! Feature - orders

// Bloc
  sl.registerFactory(() => OrdersCustomerBloc(
        getAllOrderUsecase: sl(),
        cancelOrderUsecase: sl(),
        setAssessmentUsecase: sl(),
      ));
  sl.registerFactory(
      () => OrdersBloc(getAllOrderUsecase: sl(), cancelOrderUsecase: sl()));
  sl.registerFactory(() => GetAllOrdersBloc(
      getAllOrderForServiceUsecase: sl(),
      getAllOrderForFoundationUsecase: sl()));
  sl.registerFactory(() => AcceptRejectedOrderBloc(
      acceptOrderUsecase: sl(), rejectedOrderUsecase: sl()));
// Usecases
  sl.registerLazySingleton(() => AcceptOrderUsecase(sl()));
  sl.registerLazySingleton(() => BlockUserFoundationUsecase(sl()));
  sl.registerLazySingleton(() => BlockUserServiceUsecase(sl()));
  sl.registerLazySingleton(() => CancelOrderUsecase(sl()));
  sl.registerLazySingleton(() => GetAllOrderForFoundationUsecase(sl()));
  sl.registerLazySingleton(() => GetAllOrderForServiceUsecase(sl()));
  sl.registerLazySingleton(() => GetAllOrderUsecase(sl()));
  sl.registerLazySingleton(() => RejectedOrderUsecase(sl()));
  sl.registerLazySingleton(() => SetAssessmentUsecase(sl()));

// Repository
  sl.registerLazySingleton<OrderRepo>(() => OrderRepoImpl(sl(), sl(), sl()));

// Datasources
  sl.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImplWithHttp(client: sl()));

//! Feature - services

// Bloc

  sl.registerFactory(() => AvailableTimeBloc(getAvailableTimeUsecase: sl()));
  sl.registerFactory(() => ReservationBloc(reservationServiceUsecase: sl()));

  sl.registerFactory(() => FoundationServicesBloc(
        getAllServiceForFoundationUsecase: sl(),
      ));
  sl.registerFactory(() => AddServiceFoundationBloc(
        addServiceToFoundationUsecase: sl(),
      ));
  sl.registerFactory(() => EditServiceFoundationBloc(
        editServiceUsecase: sl(),
      ));
  sl.registerFactory(() => StopServiceBloc(
        stopServiceUsecase: sl(),
      ));
// sl.registerFactory(

// Usecases
  sl.registerLazySingleton(() => AddServiceToFoundationUsecase(sl()));
  sl.registerLazySingleton(() => EditServiceUsecase(sl()));
  sl.registerLazySingleton(() => GetAllServiceForFoundationUsecase(sl()));
  sl.registerLazySingleton(() => GetAvailableTimeUsecase(sl()));
  sl.registerLazySingleton(() => ReservationServiceUsecase(sl()));
  sl.registerLazySingleton(() => StopServiceUsecase(sl()));

// Repository
  sl.registerLazySingleton<ServiceRepo>(
      () => ServiceRepoImpl(sl(), sl(), sl()));

// Datasources
  sl.registerLazySingleton<ServiceRemoteDataSource>(
      () => ServiceRemoteDataSourceImplWithHttp(client: sl()));

//! Feature - suggestions

// Bloc
  sl.registerFactory(() => GetAllMyProposeBloc(
        getAllMyProposeUsecase: sl(),
      ));
  sl.registerFactory(() => ProposeNewServiceBloc(
        proposeNewServiceUsecase: sl(),
      ));
// sl.registerFactory(

// Usecases
  sl.registerLazySingleton(() => GetAllMyProposeUsecase(sl()));
  sl.registerLazySingleton(() => ProposeNewServiceUsecase(sl()));

// Repository
  sl.registerLazySingleton<SuggestionsRepo>(() => SuggestionsRepoImpl(
      localDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()));

// Datasources
  sl.registerLazySingleton<SuggestionsRemoteDataSource>(
      () => SuggestionsRemoteDataSourceImplWithHttp(client: sl()));

//? ========================================

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//? ========================================

//! External

  final SharedPreferences pref = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => pref);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
