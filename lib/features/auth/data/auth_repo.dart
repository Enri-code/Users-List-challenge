import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:owwn_flutter_test/core/utils/api_client.dart';
import 'package:owwn_flutter_test/core/utils/app_error.dart';
import 'package:owwn_flutter_test/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends IAuthRepo {
  const AuthRepoImpl(this._client);

  final ApiClient _client;

  @override
  AsyncErrorOr<void> signIn(String email) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        'auth',
        body: jsonEncode({'email': email}),
      );

      switch (response.statusCode) {
        case 200:
          //Stores the access_token to be used in api requests.
          _client.token = response.data['access_token'] as String;
          
          return const Right(null);

        default:
          return Left(AppError(response.data['message'] as String?));
      }
    } catch (_) {
      return const Left(AppError());
    }
  }
}
