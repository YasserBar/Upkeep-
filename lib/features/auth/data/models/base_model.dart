import '../../domain/entities/Base.dart';

class BaseModel extends Base {
  const BaseModel({required String email, required String password})
      : super(email: email, password: password);

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
