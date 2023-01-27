abstract class IUsersService {
  Future<List<Map<String, dynamic>>> getUsers([int page = 1]);
}
