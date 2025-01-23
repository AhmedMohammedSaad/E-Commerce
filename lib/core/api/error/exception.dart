import 'package:advanced_app/core/api/error/error_model.dart';
import 'package:dio/dio.dart';

class ApiExceptions implements Exception {
  final ErrorModel apiExceptions;

  ApiExceptions({required this.apiExceptions});
}

//! Handel data Exceptions for api statos code
void handelExceptionsStatos(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ApiExceptions(apiExceptions: e.response!.data);
    case DioExceptionType.sendTimeout:
      throw ApiExceptions(apiExceptions: e.response!.data);
    case DioExceptionType.receiveTimeout:
      throw ApiExceptions(apiExceptions: e.response!.data);
    case DioExceptionType.badCertificate:
      throw ApiExceptions(apiExceptions: e.response!.data);
    case DioExceptionType.cancel:
      throw ApiExceptions(apiExceptions: e.response!.data);
    case DioExceptionType.connectionError:
      throw ApiExceptions(apiExceptions: e.response!.data);
    case DioExceptionType.unknown:
      throw ApiExceptions(apiExceptions: e.response!.data);
    //! for youser
    case DioExceptionType.badResponse:
      400;
      404;
      401;
      300;
      500;
  }
}
