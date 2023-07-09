import 'package:equatable/equatable.dart';

import 'base.dart';

class Login extends Base with EquatableMixin {
  const Login(String email, String password)
      : super(email: email, password: password);

  @override
  List<Object> get props {
    return [email, password];
  }
}
