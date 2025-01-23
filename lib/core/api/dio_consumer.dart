import 'package:advanced_app/core/api/api_consumer.dart';
import 'package:advanced_app/core/api/error/exception.dart';
import 'package:advanced_app/core/api/stringes_for_api.dart';
import 'package:advanced_app/core/apikey.dart';
import 'package:dio/dio.dart';

class DioConsumer extends ApiConsumer {
  Dio dio = Dio(
    BaseOptions(baseUrl: StringesForApi().baseUrl, headers: {
      StringesForApi().apiKey: apiKey,
    }),
  );

  //! delete
  @override
  delete(String path, {data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await dio.delete(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handelExceptionsStatos(e);
    }
  }

  //!patch
  @override
  patch(String path, {data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await dio.patch(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handelExceptionsStatos(e);
    }
  }

  //!post
  @override
  post(String path, {data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await dio.post(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handelExceptionsStatos(e);
    }
  }

  //!get
  @override
  get(String path, {data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handelExceptionsStatos(e);
    }
  }
}
