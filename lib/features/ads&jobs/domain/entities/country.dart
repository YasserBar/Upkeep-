import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final int id;
  final String name;

  const Country({required this.id, required this.name});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  List<Object> get props => [id, name];
}
