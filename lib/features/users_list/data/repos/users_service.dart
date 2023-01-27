import 'package:owwn_flutter_test/core/utils/api_client.dart';
import 'package:owwn_flutter_test/features/users_list/domain/repos/users_service.dart';

class UsersServiceImpl extends IUsersService {
  UsersServiceImpl(this._client);

  final ApiClient _client;

  @override
  Future<List<Map<String, dynamic>>> getUsers([int page = 1]) async {
    //Sends request for users and stores response
    final response = await _client.get<Map>(
      'users',
      parameters: {'page': page},
    );

    return (response.data['users'] as List).cast<Map<String, dynamic>>();
  }
}
