import '../../domain/entities/login.dart';

class LoginModel extends Login {
  const LoginModel(String email, String password) : super(email, password);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      json['email'] as String,
      json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
