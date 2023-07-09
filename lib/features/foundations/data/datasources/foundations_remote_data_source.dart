import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/url.dart';
import '../../../../core/helpers/header.dart';
import '../../../../core/helpers/switch_status_code.dart';
import '../models/filtier_foundation.dart';
import '../models/foundation_model.dart';

abstract class FoundationsRemoteDataSource {
  Future<List<FoundationModel>> filterFoundations(
      FilterFoundationsModel filterFoundation, int page, String token);
  Future<List<FoundationModel>> getAllFoundationsForOwner(
      int page, String token);
}

class FoundationsRemoteDataSourceImplWithHttp
    extends FoundationsRemoteDataSource {
  final http.Client client;

  FoundationsRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<List<FoundationModel>> filterFoundations(
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
}
