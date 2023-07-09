import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/url.dart';
import '../../../../core/helpers/header.dart';
import '../../../../core/helpers/switch_status_code.dart';
import '../models/order.dart';

abstract class OrderRemoteDataSource {
  Future<List<MyOrderModel>> getAllOrder(int page, String token);
  Future<Unit> cancelOrder(int orderId, String token);
  Future<Unit> setAssessment(int orderId, int assessment, String token);
  Future<Unit> blockUserService(
      int userId, int foundationServiceId, String token);
  Future<Unit> blockUserFoundation(int userId, int foundationId, String token);
  Future<Unit> acceptOrder(int orderId, String token);
  Future<Unit> rejectedOrder(int orderId, String token);
  Future<List<MyOrderModel>> getAllOrderForService(
      int page, int id, String token);
  Future<List<MyOrderModel>> getAllOrderForAllService(
      int page, int foundationId, String token);
}

class OrderRemoteDataSourceImplWithHttp extends OrderRemoteDataSource {
  final http.Client client;

  OrderRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<Unit> acceptOrder(int orderId, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointOrders.acceptOrder),
        body: json.encode({"order_id": orderId}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> blockUserFoundation(
      int userId, int foundationId, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointOrders.blockUserFoundation),
        body: json.encode({"user_id": userId, "foundation_id": foundationId}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> blockUserService(
      int userId, int foundationServiceId, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointOrders.blockUserService),
        body: json.encode({"user_id": userId, "foundation_service_id": foundationServiceId}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> cancelOrder(int orderId, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointOrders.cancelOrder),
        body: json.encode({"order_id": orderId}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MyOrderModel>> getAllOrder(int page, String token) async {
    final response = await client.get(
        Uri.parse(baseUrl + EndPointOrders.getAllOrder).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<MyOrderModel> listMyOrderModel = dataJson
          .map<MyOrderModel>(
              (jsonMyOrderModel) => MyOrderModel.fromJson(jsonMyOrderModel))
          .toList();
      return Future.value(listMyOrderModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MyOrderModel>> getAllOrderForAllService(
      int page, int foundationId, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointOrders.getAllOrderForAllService).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        body: json.encode({"foundation_id": foundationId}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<MyOrderModel> listMyOrderModel = dataJson
          .map<MyOrderModel>(
              (jsonMyOrderModel) => MyOrderModel.fromJson(jsonMyOrderModel))
          .toList();
      return Future.value(listMyOrderModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MyOrderModel>> getAllOrderForService(
      int page, int id, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointOrders.getAllOrderForService).replace(
            queryParameters: {"page": page}
                .map((key, value) => MapEntry(key, value.toString()))),
        body: json.encode({"id": id}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      final responseJson = json.decode(response.body);
      final dataJson = responseJson["Data"]["data"];
      final List<MyOrderModel> listMyOrderModel = dataJson
          .map<MyOrderModel>(
              (jsonMyOrderModel) => MyOrderModel.fromJson(jsonMyOrderModel))
          .toList();
      return Future.value(listMyOrderModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> rejectedOrder(int orderId, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointOrders.rejectedOrder),
        body: json.encode({"order_id": orderId}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> setAssessment(int orderId, int assessment, String token) async {
    final response = await client.post(
        Uri.parse(baseUrl + EndPointOrders.setAssessment),
        body: json.encode({"order_id": orderId, "assessment": assessment}.map((key, value) => MapEntry(key, value.toString()))),
        headers: setHeadersWithToken(token));
    try {
      switchStatusCode(response);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }
}
