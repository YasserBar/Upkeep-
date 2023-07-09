import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/constants/url.dart';
import '../../../../core/helpers/header.dart';
import '../../../../core/helpers/switch_status_code.dart';
import '../models/job_ad.dart';
import '../models/sliders_ads_jobs.dart';

abstract class AdsAndJobsRemoteDataSource {
  Future<List<SlidersAdsJobsModel>> getAdsSliders(int page, String token);
  Future<List<SlidersAdsJobsModel>> getJobsSliders(int page, String token);

  Future<List<JobAdModel>> showAllAdsForFoundation(
      int page, String token, int id);

  Future<Unit> addJob(String token, JobAdModel job, int foundationId);
  Future<Unit> deleteJob(String token, int id);
  Future<Unit> editJob(String token, JobAdModel job);
  Future<List<JobAdModel>> showAllJobForFoundation(
      int page, String token, int id);
}

class AdsAndJobsRemoteDataSourceImplWithHttp
    extends AdsAndJobsRemoteDataSource {
  final http.Client client;

  AdsAndJobsRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<List<SlidersAdsJobsModel>> getAdsSliders(
      int page, String token) async {
    final response = await client.get(
        Uri.parse(baseUrl + EndPointAdsJobs.getAdsSliders).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<SlidersAdsJobsModel> listSlidersAdsModel = dataJson
          .map<SlidersAdsJobsModel>((jsonSlidersAdsModel) =>
          SlidersAdsJobsModel.fromJson(jsonSlidersAdsModel))
          .toList();
      return Future.value(listSlidersAdsModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SlidersAdsJobsModel>> getJobsSliders(
      int page, String token) async {
    final response = await client.get(
        Uri.parse(baseUrl + EndPointAdsJobs.getJobsSliders).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<SlidersAdsJobsModel> listSlidersJobsModel = dataJson
          .map<SlidersAdsJobsModel>((jsonSlidersJobsModel) =>
          SlidersAdsJobsModel.fromJson(jsonSlidersJobsModel))
          .toList();
      return Future.value(listSlidersJobsModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<JobAdModel>> showAllAdsForFoundation(
      int page, String token, int id) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointAdsJobs.showAllAdsForFoundation).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        body: json.encode({"id": id}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];

      final List<JobAdModel> adsModel = dataJson
          .map<JobAdModel>((adModel) => JobAdModel.fromJson(adModel))
          .toList();
      return Future.value(adsModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> addJob(String token, JobAdModel job, int foundationId) async {
    Map<String, dynamic> json = job.toJson();
    json.addEntries({'foundation_id': foundationId}.entries);
    final response = await client.post(
        Uri.parse(baseUrl + EndPointAdsJobs.addJob),
        body: jsonEncode(json),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> deleteJob(String token, int id) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointAdsJobs.deleteJob),
        body: json.encode({"id": id}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> editJob(String token, JobAdModel job) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointAdsJobs.editJob),
        body: json.encode(job.toJson()),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<JobAdModel>> showAllJobForFoundation(
      int page, String token, int id) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointAdsJobs.showAllJobForFoundation).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        body: json.encode({"id": id}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<JobAdModel> jobsModel = dataJson
          .map<JobAdModel>((jobModel) => JobAdModel.fromJson(jobModel))
          .toList();
      return Future.value(jobsModel);
    } catch (e) {
      rethrow;
    }
  }
}
