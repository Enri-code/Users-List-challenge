import 'package:dartz/dartz.dart';
import 'package:owwn_flutter_test/core/utils/app_error.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/section.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/status.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';
import 'package:owwn_flutter_test/features/users_list/domain/repos/users_repo.dart';
import 'package:owwn_flutter_test/features/users_list/domain/repos/users_service.dart';

class UsersRepoImpl extends IUsersRepo {
  UsersRepoImpl({required this.converter, required this.service});

  final IUsersService service;
  final User Function(Map<String, dynamic> map) converter;

  @override
  AsyncErrorOr<List<UsersSection>> getUsers([int page = 1]) async {
    try {
      //Sends request for users and stores response
      final response = await service.getUsers(page);

      //Converts usersMap List to List of UserModel
      final Iterable<User> users = response.map(converter);

      //Gets users wuth active status from the List and stores
      final activeUsers = users.where((e) => Status.active == e.status);

      //Gets users wuth inactive status from the List and stores
      final inactiveUsers = users.where((e) => Status.inactive == e.status);

      return Right(
        //Only returns active/inactive users if they are not empty
        [
          if (activeUsers.isNotEmpty)
            UsersSection(
              status: Status.active,
              users: activeUsers.toList(),
            ),
          if (inactiveUsers.isNotEmpty)
            UsersSection(
              status: Status.inactive,
              users: inactiveUsers.toList(),
            ),
        ],
      );
    } catch (_) {
      return const Left(AppError());
    }
  }
}
