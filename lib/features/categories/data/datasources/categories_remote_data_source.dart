import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../core/constants/url.dart';
import '../../../../core/helpers/header.dart';
import '../../../../core/helpers/switch_status_code.dart';
import '../models/service.dart';
import 'package:http/http.dart' as http;

abstract class CategoriesRemoteDataSource {
  Future<List<ServiceModel>> getAllServiceInSystem(int page, String token);
  Future<List<ServiceModel>> getAllSubServiceInSystem(
      int page, String token, int serviceIid);
}

class CategoriesRemoteDataSourceImplWithHttp
    extends CategoriesRemoteDataSource {
  final http.Client client;

  CategoriesRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<List<ServiceModel>> getAllServiceInSystem(
      int page, String token) async {
    final response = await client.get(
        Uri.parse(baseUrl + EndPointCategories.getAllServiceInSystem).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<ServiceModel> servicesModel = dataJson
          .map<ServiceModel>(
              (serviceModel) => ServiceModel.fromJson(serviceModel))
          .toList();
      return Future.value(servicesModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ServiceModel>> getAllSubServiceInSystem(
      int page, String token, int serviceIid) async {
    final url = Uri.parse(baseUrl + EndPointCategories.getAllSubServiceInSystem)
        .replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString())));
    if (kDebugMode) {
      print('===================================');
      print(url);
      print('===================================');
    }
    final response = await client.post(url,
        body: json.encode({"service_id": serviceIid}
            .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<ServiceModel> servicesModel = dataJson
          .map<ServiceModel>(
              (serviceModel) => ServiceModel.fromJson(serviceModel))
          .toList();
      return Future.value(servicesModel);
    } catch (e) {
      rethrow;
    }
  }
}
