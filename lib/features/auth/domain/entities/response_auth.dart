import 'package:equatable/equatable.dart';

class ResponseAuth extends Equatable {
  final String token;

  const ResponseAuth({required this.token});

  @override
  List<Object?> get props => [token];
}
