
import 'package:equatable/equatable.dart';
import '../../../../locations/domain/entities/country.dart';

abstract class GetLocationsState extends Equatable {
  const GetLocationsState();
  
  @override
  List<Object> get props => [];
}
class GetLocationsInitial extends GetLocationsState {}
class LoadingGetLocationsState extends GetLocationsState{

}
class LoadedGetAllCountryState extends GetLocationsState{
  final List<Country>country;

  const LoadedGetAllCountryState({ required  this.country});

}
class FailureGetLocationsState extends GetLocationsState{
  final String message;

 const FailureGetLocationsState({ required  this.message});

}