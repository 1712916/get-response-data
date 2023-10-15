import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_response_data/api_client/api_client.dart';
import 'package:get_response_data/data_response.dart';

abstract class DioClient extends ApiClient {
  DioClient(String apiGateWay) {
    _dio = Dio(BaseOptions(
      baseUrl: apiGateWay,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    ));
  }

  late final Dio _dio;

  Dio get dio => _dio;

  void setting(Map settingData) {}

  @override
  Future<ApiResponse> get(String path, Map<String, dynamic> queryParameters) =>
      _request('GET', path, queryParameters: queryParameters);

  Future<ApiResponse> _request(
    String method,
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );

      return SuccessApiResponse(
        statusCode: response.statusCode!,
        message: response.statusMessage!,
        data: response.data,
      );
    } on TimeoutException {
      return TimeOutApiResponse();
    } on DioException catch (e) {
      if (e.response != null) {
        return ErrorApiResponse(
          statusCode: e.response?.statusCode ?? 404,
          message: e.message ?? e.toString(),
        );
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return UnknownResponse();
      }
    } catch (e) {
      return UnknownResponse();
    }
  }
}
