import 'dart:convert';

import 'package:dio/dio.dart';
import "package:http/http.dart" as http;
import 'package:roof/constant.dart';

import 'package:roof/features/model/user_model.dart';
import 'package:roof/network/api.dart';

import 'package:roof/network/logger.dart';

import 'api.dart';

class APIRepo {
  String url = BASE_API_URL;

  Future<List<User>> getUsers(int userId) async {
    final response = await http.get(Uri.parse("$url/albums?userId=$userId"));

    List jsonData = json.decode(response.body);

    return jsonData.map((c) => User.fromJson(c)).toList();
  }
}

class UserRepository {
  Future<List<User>> getUser(int userId) async {
    try {
      final _apiCall = RestClient(DioClient.getDio());
      Map map = {"userId": userId};
      return _apiCall.getUsers(userId).then((data) async {}).catchError((err) {
        print(err.toString);
      });
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
