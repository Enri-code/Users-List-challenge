import 'package:dartz/dartz.dart';
import 'package:owwn_flutter_test/core/utils/api_client.dart';
import 'package:owwn_flutter_test/core/utils/app_error.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/section.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/status.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';
import 'package:owwn_flutter_test/features/users_list/domain/repos/users_repo.dart';

class UsersRepoImpl extends IUsersRepo {
  UsersRepoImpl(this._client, {required this.converter});

  final ApiClient _client;
  final User Function(Map<String, dynamic> map) converter;

  @override
  AsyncErrorOr<List<UsersSection>> getUsers([int page = 1]) async {
    try {
      //Sends request for users and stores response
      final response = await _client.get<Map>(
        'users',
        parameters: {'page': page},
      );

      switch (response.statusCode) {
        case 200:
          //Gets users key from map and casts to a List<Map>
          final usersMap =
              (response.data['users'] as List).cast<Map<String, dynamic>>();

          //Converts usersMap List to List of UserModel
          final Iterable<User> users = usersMap.map(converter);

          //Gets users wuth active status from the List and stores
          final activeUsers =
              users.where((e) => Status.active == e.status).toList();

          //Gets users wuth inactive status from the List and stores
          final inactiveUsers =
              users.where((e) => Status.inactive == e.status).toList();

          return Right(
            //Only returns active/inactive users if they are not empty
            [
              if (activeUsers.isNotEmpty)
                UsersSection(
                  status: Status.active,
                  users: activeUsers,
                ),
              if (inactiveUsers.isNotEmpty)
                UsersSection(
                  status: Status.inactive,
                  users: inactiveUsers,
                ),
            ],
          );

        default:
          return const Left(AppError());
      }
    } catch (_) {
      return const Left(AppError());
    }
  }
}
