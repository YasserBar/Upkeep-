import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/url.dart';
import '../../../../core/helpers/header.dart';
import '../../../../core/helpers/switch_status_code.dart';
import '../models/change_password_model.dart';
import '../models/login_model.dart';
import '../models/response_auth_model.dart';
import '../models/signup_model.dart';
import '../models/verify_pin_forget_model.dart';
import '../models/verify_pin_signup_model.dart';

abstract class AuthRemoteDataSource {
  Future<ResponseAuthModel> login(LoginModel login, bool customer);

  Future<ResponseAuthModel> verifyPinSignup(
      VerifyPinSignupModel verifyPinSignup);

  Future<ResponseAuthModel> verifyPinForget(
      VerifyPinForgetModel verifyPinForget);

  Future<Unit> logout(String token);

  Future<Unit> signup(SignupModel signup);

  Future<Unit> forgetPassword(String email);

  Future<Unit> resendPin(String email);

  Future<Unit> changePassword(ChangePasswordModel changePassword, String token);
}

class AuthRemoteDataSourceImplWithHttp extends AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<Unit> changePassword(
      ChangePasswordModel changePassword, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointAuth.changePassword),
        body: json.encode(changePassword.toJson()),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> forgetPassword(String email) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointAuth.forgotPassword),
        body: json.encode({"email": email}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeaders());
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> resendPin(String email) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointAuth.resendPin),
        body: json.encode({"email": email}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeaders());
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseAuthModel> login(LoginModel login, bool customer) async {
    String endpointlogin =
        customer ? EndPointAuth.loginCustomer : EndPointAuth.loginProvider;
    final response = await client.post(
      Uri.parse(baseUrl + endpointlogin),
      body: json.encode(login.toJson()),
      headers: setHeaders(),
    );
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final ResponseAuthModel responseAuthModel =
          ResponseAuthModel.fromJson(responseJson["Data"]);
      return Future.value(responseAuthModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> logout(String token) async {
    final response = await client.post(Uri.parse(baseUrl + EndPointAuth.logout),
        body: null, headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> signup(SignupModel signup) async {
    final response = await client.post(Uri.parse(baseUrl + EndPointAuth.signup),
        body: json.encode(signup.toJson()), headers: setHeaders());
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseAuthModel> verifyPinForget(
      VerifyPinForgetModel verifyPinForget) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointAuth.verifyPinForgetPassword),
        body: json.encode(verifyPinForget.toJson()),
        headers: setHeaders());
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final ResponseAuthModel responseAuthModel =
          ResponseAuthModel.fromJson({"token":responseJson["Data"]});
      return Future.value(responseAuthModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseAuthModel> verifyPinSignup(
      VerifyPinSignupModel verifyPinSignup) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointAuth.verifyPinSignup),
        body: json.encode(verifyPinSignup.toJson()),
        headers: setHeaders());
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final ResponseAuthModel responseAuthModel =
          ResponseAuthModel.fromJson(responseJson["Data"]);
      return Future.value(responseAuthModel);
    } catch (e) {
      rethrow;
    }
  }
}
