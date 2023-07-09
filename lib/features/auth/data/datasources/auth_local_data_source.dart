import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/keys.dart';
import '../../../../core/errors/exception.dart';
import '../../domain/entities/response_auth.dart';
import '../models/response_auth_model.dart';

abstract class AuthLocalDataSource {
  Future<Unit> cacheResponse(ResponseAuthModel responseAuthModel);
  Future<ResponseAuth> getCachedResponse();
  Future<Unit> removeCachedResponse();
}

class AuthLocalDataSourceImplWithSharedPreferences extends AuthLocalDataSource {
  final SharedPreferences pref;

  AuthLocalDataSourceImplWithSharedPreferences({
    required this.pref,
  });

  @override
  Future<Unit> cacheResponse(ResponseAuthModel responseAuthModel) async {
    Object responseAuthJson = responseAuthModel.toJson();
    final storeAuth =
        await pref.setString(CACHED_RESPONSE, jsonEncode(responseAuthJson));
    if (kDebugMode) {
      if (storeAuth) {
        print('storeAuth');
      } else {
        print('fail');
      }
    }
    return Future.value(unit);
  }

  @override
  Future<ResponseAuth> getCachedResponse() {
    final String? response = pref.getString(CACHED_RESPONSE);
    if (response != null) {
      if (kDebugMode) {
        print(response);
      }
      return Future.value(ResponseAuthModel.fromJson(json.decode(response)));
    }
    throw EmptyCacheException();
  }

  @override
  Future<Unit> removeCachedResponse() async {
    final remove = await pref.remove(CACHED_RESPONSE);
    if (kDebugMode) {
      if (remove) {
        print('removeAuth');
      } else {
        print('fail');
      }
    }
    return Future.value(unit);
  }
}
