import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:upkeep_plus/features/services/data/models/service_foundation.dart';

import '../../../../core/constants/url.dart';
import '../../../../core/helpers/header.dart';
import '../../../../core/helpers/switch_status_code.dart';
import '../models/filtier_foundation.dart';
import '../models/foundation_model.dart';

abstract class FoundationsRemoteDataSource {
  Future<List<ServiceFoundationModel>> filterFoundations(
      FilterFoundationsModel filterFoundation, int page, String token);
  Future<List<FoundationModel>> filterFoundationsInSystem(
      FilterFoundationsModel filterFoundation, int page, String token);
  Future<List<FoundationModel>> getAllFoundationsForOwner(
      int page, String token);
  Future<Unit> stopFoundation(int id, String token);
}

class FoundationsRemoteDataSourceImplWithHttp
    extends FoundationsRemoteDataSource {
  final http.Client client;

  FoundationsRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<List<ServiceFoundationModel>> filterFoundations(
      FilterFoundationsModel filterFoundation, int page, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointFoundations.filterFoundations).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        body: json.encode(filterFoundation.toJson()),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<ServiceFoundationModel> listFoundationModel = dataJson
          .map<ServiceFoundationModel>((jsonFoundationModel) =>
              ServiceFoundationModel.fromJson(jsonFoundationModel))
          .toList();
      return Future.value(listFoundationModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FoundationModel>> getAllFoundationsForOwner(
      int page, String token) async {
    final response = await client.get(
        Uri.parse(baseUrl + EndPointFoundations.getAllFoundationsForOwner)
            .replace(
                queryParameters: {"page": page}
                    .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<FoundationModel> listFoundationModel = dataJson
          .map<FoundationModel>((jsonFoundationModel) =>
              FoundationModel.fromJson(jsonFoundationModel))
          .toList();
      return Future.value(listFoundationModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> stopFoundation(int id, String token) async {
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

  @override
  Future<List<FoundationModel>> filterFoundationsInSystem(
      FilterFoundationsModel filterFoundation, int page, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointFoundations.foundationFilter).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        body: json.encode(filterFoundation.toJson()),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<FoundationModel> listFoundationModel = dataJson
          .map<FoundationModel>((jsonFoundationModel) =>
              FoundationModel.fromJson(jsonFoundationModel))
          .toList();
      return Future.value(listFoundationModel);
    } catch (e) {
      rethrow;
    }
  }
}
