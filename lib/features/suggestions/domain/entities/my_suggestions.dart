import 'package:equatable/equatable.dart';

class MySuggestion extends Equatable {
  final String description;
  final String response;

  const MySuggestion({required this.description, required this.response});

  @override
  List<Object?> get props => [description, response];
}
