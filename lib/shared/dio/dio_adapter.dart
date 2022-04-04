import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile2you/shared/http_client/http_client_interface.dart';
import 'package:mobile2you/shared/http_client/http_response.dart';

class DioAdapter implements IHttpClient {
  final Dio dio;
  DioAdapter(this.dio);

  @override
  Future<HttpResponse> get(String url) async {
    final result = await dio.get(url);
    return HttpResponse(
      statusCode: result.statusCode ?? 0,
      body: json.encode(result.data as Map),
    );
  }
}
