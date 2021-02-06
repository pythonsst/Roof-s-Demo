import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:roof/network/api.dart';
import 'package:roof/network/logger.dart';

class LoginRepo {
  static login(int userId) async {
    // await StorageService.write(PrefsConstants.email, data.email);
    callLoginApi(userId);
  }

  static callLoginApi(int userId) {
    try {
      final _apiCall = RestClient(DioClient.getDio());
      Map map = {"userId": userId};

      _apiCall.getUsers(userId).then((data) async {}).catchError((err) {});
    } catch (e) {}
  }
}

class DioClient {
  static getDio() {
    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.contentType = Headers.formUrlEncodedContentType;
    dio.interceptors.add(PrettyDioLogger());
    return dio;
  }
}
