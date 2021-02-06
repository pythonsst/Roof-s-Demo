// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://jsonplaceholder.typicode.com';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<User> getUsers(pageSize) async {
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userId': pageSize};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/albums',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = User.fromJson(_result.data);
    return value;
  }
}
