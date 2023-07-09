import 'package:dartz/dartz.dart';

import '../entities/change_password.dart';
import '../entities/signup.dart';
import '../entities/verify_pin_forget.dart';
import '../entities/verify_pin_signup.dart';
import '../entities/login.dart';
import '../entities/response_auth.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, ResponseAuth>> loginProvider(
      Login login, bool remmberMe);

  Future<Either<Failure, ResponseAuth>> loginCustomer(
      Login login, bool remmberMe);

  Future<Either<Failure, ResponseAuth>> verifyPinSignup(
      VerifyPinSignup verifyPinSignup, bool remmberMe);

  Future<Either<Failure, ResponseAuth>> verifyPinForget(
      VerifyPinForget verifyPinForget, bool remmberMe);

  Future<Either<Failure, Unit>> signup(Signup signup);

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> forgetPassword(String email);

  Future<Either<Failure, Unit>> resendPin(String email);

  Future<Either<Failure, Unit>> changePassword(ChangePassword changePassword);
}
