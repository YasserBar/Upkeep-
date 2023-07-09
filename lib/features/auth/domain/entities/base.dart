import 'package:equatable/equatable.dart';

class Base extends Equatable {
  final String email;
  final String password;

  const Base({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
