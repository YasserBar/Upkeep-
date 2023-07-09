import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/url.dart';
import '../../../../core/helpers/header.dart';
import '../../../../core/helpers/switch_status_code.dart';
import '../models/add_service.dart';
import '../models/date.dart';
import '../models/reservation.dart';
import '../models/service_foundation.dart';

abstract class ServiceRemoteDataSource {
  Future<List<ServiceFoundationModel>> getAllServiceForFoundation(
      String token, int foundationId, int page);
  Future<Unit> reservationService(
      String token, ReservationModel reservationModel);
  Future<List<DateModel>> getAvailableTime(String token, int id);

  Future<Unit> addService(String token, AddServiceModel addServiceModel);
  Future<Unit> editService(String token, AddServiceModel editServiceModel);
  Future<Unit> stopService(String token, int id);
}

class ServiceRemoteDataSourceImplWithHttp extends ServiceRemoteDataSource {
  final http.Client client;

  ServiceRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<Unit> addService(String token, AddServiceModel addServiceModel) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointServices.addServiceToFoundation),
        body: json.encode(addServiceModel.toJson()),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> editService(
      String token, AddServiceModel editServiceModel) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointServices.editService),
        body: json.encode(editServiceModel.toJson()),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ServiceFoundationModel>> getAllServiceForFoundation(
      String token, int foundationId, int page) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointServices.getAllServiceForFoundation)
            .replace(
                queryParameters: {"page": page}
                    .map((key, value) => MapEntry(key, value.toString()))),
        body: json.encode({"foundation_id": foundationId}
            .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      if (kDebugMode) {
        print(
            "ssssssssssssssssssseeeeeeeeeeeeeeeeeeeeeeeeerrrrrrrrrrrrrrrrrrrrrvvvvvvvvvvvvvvvvviiiiiiiiiiiiiiiiiccccccccccccceeeeeeeeeeeeeeeeeeeee");
        print(dataJson);
      }
      final List<ServiceFoundationModel> listServiceFoundationModel = dataJson
          .map<ServiceFoundationModel>((jsonServiceFoundationModel) =>
              ServiceFoundationModel.fromJson(jsonServiceFoundationModel))
          .toList();
      return Future.value(listServiceFoundationModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DateModel>> getAvailableTime(String token, int id) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointServices.getAvailableTime),
        body: json.encode(
            {"id": id}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"];
     final List<DateModel> listDataModel = dataJson
          .map<String>((jsonDateModel) => jsonDateModel.toString())
          .map<DateModel>((stringDateModel) => DateModel(date: stringDateModel))
          .toList();
      return Future.value(listDataModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> reservationService(
      String token, ReservationModel reservationModel) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointServices.reservationService),
        body: json.encode(reservationModel.toJson()),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> stopService(String token, int id) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointServices.stopService),
        body: json.encode(
            {"id": id}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }
}
