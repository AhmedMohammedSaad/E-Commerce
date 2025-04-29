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
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 400:
            throw ApiExceptions(
                apiExceptions: ErrorModel(
                    code: '400',
                    message: 'Bad Request',
                    details: 'The request was invalid.',
                    hint: 'Check the request parameters.'));
          case 401:
            throw ApiExceptions(
                apiExceptions: ErrorModel(
                    code: '401',
                    message: 'Unauthorized',
                    details: 'Authentication is required.',
                    hint: 'Ensure valid authentication credentials.'));
          case 404:
            throw ApiExceptions(
                apiExceptions: ErrorModel(
                    code: '404',
                    message: 'Not Found',
                    details: 'The requested resource was not found.',
                    hint: 'Verify the resource URL.'));
          case 500:
            throw ApiExceptions(
                apiExceptions: ErrorModel(
                    code: '500',
                    message: 'Internal Server Error',
                    details: 'An error occurred on the server.',
                    hint: 'Try again later.'));
          default:
            throw ApiExceptions(
                apiExceptions: ErrorModel(
                    code: 'unknown',
                    message: 'Unknown Error',
                    details: 'An unknown error occurred.',
                    hint: 'Contact support.'));
        }
      } else {
        throw ApiExceptions(
            apiExceptions: ErrorModel(
                code: 'no_response',
                message: 'No Response',
                details: 'No response received from the server.',
                hint: 'Check network connection.'));
      }
  }
}
