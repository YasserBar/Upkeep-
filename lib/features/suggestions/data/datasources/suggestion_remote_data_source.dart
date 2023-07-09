import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/url.dart';
import '../../../../core/helpers/header.dart';
import '../../../../core/helpers/switch_status_code.dart';
import '../models/my_suggestions.dart';
import '../models/propose.dart';

abstract class SuggestionsRemoteDataSource {
  Future<List<MySuggestionModel>> getAllMyPropose(
      int foundationId, int page, String token);
  Future<Unit> proposeNewService(ProposeModel propose, String token);
}

class SuggestionsRemoteDataSourceImplWithHttp
    extends SuggestionsRemoteDataSource {
  final http.Client client;

  SuggestionsRemoteDataSourceImplWithHttp({required this.client});
  @override
  Future<List<MySuggestionModel>> getAllMyPropose(
      int foundationId, int page, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + endPointGetAllMyPropose).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        body: json.encode({"foundation_id": foundationId}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<MySuggestionModel> listMySuggestionModel = dataJson
          .map<MySuggestionModel>((jsonMySuggestionModel) =>
              MySuggestionModel.fromJson(jsonMySuggestionModel))
          .toList();
      return Future.value(listMySuggestionModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> proposeNewService(ProposeModel propose, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + endPointProposeNewService),
        body: json.encode(propose.toJson()),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }
}
