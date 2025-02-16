import 'dart:io';

import 'package:dio/dio.dart';

typedef TokenGetter = Future<String?> Function();
typedef UnauthorizedCallback = Future<void> Function();
typedef RequestErrorCallback = void Function(DioException error);

class ApiClient {
  ApiClient._(
    this._dioClient, {
    this.onUnauthorized,
    this.onRequestFailed,
  });

  final Dio _dioClient;
  Dio get client => _dioClient;

  UnauthorizedCallback? onUnauthorized;
  RequestErrorCallback? onRequestFailed;

  factory ApiClient({
    String baseUrl = 'http://110.168.212.24:8080',
    UnauthorizedCallback? onUnauthorized,
    RequestErrorCallback? onRequestFailed,
  }) {
    final instance = ApiClient._(
      Dio(BaseOptions(baseUrl: baseUrl)),
      onUnauthorized: onUnauthorized,
      onRequestFailed: onRequestFailed,
    );

    instance.client.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        // Attach user token (if exist)
        // Todo: Implement token getter
        String? accessToken = '';
        if (accessToken != '') {
          options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
        }
        // If content-type is not set, set it to `application/json`
        if (options.headers[HttpHeaders.acceptHeader] == null) {
          options.headers[HttpHeaders.acceptHeader] = 'application/json';
        }
        if (options.headers[HttpHeaders.contentTypeHeader] == null) {
          options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
        }
        // Make request
        return handler.next(options);
      }, onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await instance.onUnauthorized?.call();
        }
        instance.onRequestFailed?.call(error);
        handler.reject(error);
      }),
    );

    return instance;
  }
}
