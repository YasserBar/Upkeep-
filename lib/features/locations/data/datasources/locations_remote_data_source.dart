import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/url.dart';
import '../../../../core/helpers/header.dart';
import '../../../../core/helpers/switch_status_code.dart';
import '../models/country.dart';

abstract class LocationsRemoteDataSource {
  Future<List<CountryModel>> getLocations();
}

class LocationsRemoteDataSourceImplWithHttp extends LocationsRemoteDataSource {
  final http.Client client;

  LocationsRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<List<CountryModel>> getLocations() async {
    final response = await client.get(Uri.parse(baseUrl + endPointCities),
        headers: setHeaders());
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"];
      final List<CountryModel> listLocationModel = dataJson
          .map<CountryModel>((jsonFoundationModel) =>
              CountryModel.fromJson(jsonFoundationModel))
          .toList();
      return Future.value(listLocationModel);
    } catch (e) {
      rethrow;
    }
  }
}
