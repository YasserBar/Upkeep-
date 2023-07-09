import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final int id;
  final String? photo;
  final String name;
  final String description;

  const Service(
      {required this.id,
      this.photo,
      required this.name,
      required this.description});

  @override
  List<Object?> get props => [id, photo, name, description];
}
