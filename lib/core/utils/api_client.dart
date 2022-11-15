import 'package:dio/dio.dart';
import 'package:owwn_flutter_test/core/constants/server_config.dart';

///A class that exposes only status code and data returned from the Client's
/// requests
class ApiData<T> {
  final int? statusCode;
  final T data;

  const ApiData(this.data, this.statusCode);
}

///A wrapper class for the [Client] class
class ApiClient {
  ApiClient(String baseUrl)
      : _client = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: {'X-API-KEY': ServerConfig.apiKey},
          ),
        );

  final Dio _client;

  ///Bearer token for the class
  String? _token;

  // ignore: avoid_setters_without_getters
  set token(String token) => _token = token;

  //Returns token as a parameter in header if token variable is not null
  Options? get _tokenHeaderOption {
    if (_token == null) return null;
    return Options(
      headers: {..._client.options.headers, 'Authorization': 'Bearer $_token'},
    );
  }

  Future<ApiData<T>> get<T>(
    String subPath, {
    Map<String, dynamic>? parameters,
  }) {
    return _client
        .get(subPath, queryParameters: parameters, options: _tokenHeaderOption)
        .then((result) => ApiData<T>(result.data as T, result.statusCode));
  }

  Future<ApiData<T>> post<T>(String subPath, {dynamic body}) {
    return _client
        .post(subPath, data: body, options: _tokenHeaderOption)
        .then((result) => ApiData<T>(result.data as T, result.statusCode));
  }
}
