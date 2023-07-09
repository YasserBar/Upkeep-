
import 'package:equatable/equatable.dart';

abstract class GetLocationsEvent extends Equatable {
  const GetLocationsEvent();

  @override
  List<Object> get props => [];
}
class GetAllCountryEvent extends GetLocationsEvent{

  const GetAllCountryEvent();

}