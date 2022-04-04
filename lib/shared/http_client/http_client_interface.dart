import 'package:mobile2you/shared/http_client/http_response.dart';

abstract class IHttpClient {
  Future<HttpResponse> get(String url);
}
