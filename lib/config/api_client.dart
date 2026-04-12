import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/config/api_response.dart';

class ApiClient {
  late Dio _dio;

  ApiClient() {
    _dio = Dio(BaseOptions(baseUrl: "https://mapi.trycatchtech.com/"));
  }

  Future<ApiResponse> get(String path, Map<String, dynamic>? query) async {
    print('get method is called');
    try {
      final response = await _dio.get(path, queryParameters: query);
      return ApiResponse(
        message: response.statusMessage ?? 'An error occured',
        statusCode: response.statusCode ?? 0,
        data: response.data,
      );
    } catch (e) {
      print('Error in GET request: $e');
      rethrow;
    }
  }

  Future<ApiResponse> post(String path, Object? data) async {
    try {
      final response = await _dio.post(path, data: data);
      return ApiResponse(
        message: response.statusMessage ?? 'An error occured',
        statusCode: response.statusCode ?? 0,
        data: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }
}
