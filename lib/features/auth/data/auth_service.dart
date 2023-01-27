import 'dart:convert';

import 'package:owwn_flutter_test/core/utils/api_client.dart';
import 'package:owwn_flutter_test/features/auth/domain/repos/auth_service.dart';

class AuthServiceImpl extends IAuthService {
  AuthServiceImpl(this._client);

  final ApiClient _client;

  @override
  Future<void> signIn(String email) async {
    final response = await _client.post<Map<String, dynamic>>(
      'auth',
      body: jsonEncode({'email': email}),
    );

    //Stores the access_token to be used in api requests.
    _client.token = response.data['access_token'] as String;
  }
}
