import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:roof/constant.dart';
import 'package:roof/features/model/user_model.dart';
part 'api.g.dart';

@RestApi(baseUrl: BASE_API_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/albums')
  Future<User> getUsers(
    @Query("userId") int pageSize,
  );
}
