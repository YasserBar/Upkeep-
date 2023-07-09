import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/get_token.dart';
import '../../../../core/helpers/network_info.dart';
import '../../../../core/helpers/get_message.dart';
import '../../../../main.dart';
import '../../domain/entities/change_password.dart';
import '../../domain/entities/login.dart';
import '../../domain/entities/response_auth.dart';
import '../../domain/entities/signup.dart';
import '../../domain/entities/verify_pin_forget.dart';
import '../../domain/entities/verify_pin_signup.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/change_password_model.dart';
import '../models/login_model.dart';
import '../models/response_auth_model.dart';
import '../models/signup_model.dart';
import '../models/verify_pin_forget_model.dart';
import '../models/verify_pin_signup_model.dart';

typedef GetResponse = Future<ResponseAuthModel> Function();

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseAuth>> loginProvider(
      Login login, bool remmberMe) async {
        if (kDebugMode) {
          print("remmberMe $remmberMe  +++++++++++++++++++++++++++++++++++++");
        }
    final LoginModel loginModel = LoginModel(login.email, login.password);

    return await _getResponse(remmberMe, () {
      return remoteDataSource.login(loginModel, false);
    });
  }

  @override
  Future<Either<Failure, ResponseAuth>> loginCustomer(
      Login login, bool remmberMe) async {
    final LoginModel loginModel = LoginModel(login.email, login.password);

    return await _getResponse(remmberMe, () {
      return remoteDataSource.login(loginModel, true);
    });
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );
    return await getMessage(() {
      return remoteDataSource.logout(token!);
    }, networkInfo, isLogout: true, localDataSource: localDataSource);
  }

  @override
  Future<Either<Failure, Unit>> signup(Signup signup) async {
    final SignupModel signupModel = SignupModel(
      email: signup.email,
      password: signup.password,
      fName: signup.fName,
      lName: signup.lName,
      gender: signup.gender,
      dateOfBirth: signup.dateOfBirth,
      country: signup.country,
      city: signup.city,
      region: signup.region,
      mobilePhoneNumber: signup.mobilePhoneNumber,
    );

    return await getMessage(() {
      return remoteDataSource.signup(signupModel);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> changePassword(
      ChangePassword changePassword) async {
    final ChangePasswordModel changePasswordModel = ChangePasswordModel(
      oldPassword: changePassword.oldPassword,
      password: changePassword.password,
      passwordConfirmation: changePassword.passwordConfirmation,
    );

    final Either<Failure, String> getTokenResult = await getToken();
    getTokenResult.fold(
      (l) {
        return l;
      },
      (r) {
        token = r;
      },
    );

    return await getMessage(() {
      return remoteDataSource.changePassword(changePasswordModel, token!);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword(String email) async {
    return await getMessage(() {
      return remoteDataSource.forgetPassword(email);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, Unit>> resendPin(String email) async {
    return await getMessage(() {
      return remoteDataSource.resendPin(email);
    }, networkInfo);
  }

  @override
  Future<Either<Failure, ResponseAuth>> verifyPinForget(
      VerifyPinForget verifyPinForget, bool remmberMe) async {
    final VerifyPinForgetModel verifyPinForgetModel = VerifyPinForgetModel(
        email: verifyPinForget.email,
        password: verifyPinForget.password,
        verificationCode: verifyPinForget.verificationCode,
        passwordConfirmation: verifyPinForget.passwordConfirmation);

    return await _getResponse(remmberMe, () {
      return remoteDataSource.verifyPinForget(verifyPinForgetModel);
    });
  }

  @override
  Future<Either<Failure, ResponseAuth>> verifyPinSignup(
      VerifyPinSignup verifyPinSignup, bool remmberMe) async {
    final VerifyPinSignupModel verifyPinSignupModel = VerifyPinSignupModel(
      email: verifyPinSignup.email,
      password: verifyPinSignup.password,
      verificationCode: verifyPinSignup.verificationCode,
    );

    return await _getResponse(remmberMe, () {
      return remoteDataSource.verifyPinSignup(verifyPinSignupModel);
    });
  }

  Future<Either<Failure, ResponseAuth>> _getResponse(
      bool rememberMe, GetResponse func) async {
    return performRequest<ResponseAuth>(func, networkInfo,
        remmberMe: rememberMe, localDataSource: localDataSource);
  }
}
