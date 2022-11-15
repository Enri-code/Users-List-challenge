import 'package:owwn_flutter_test/core/utils/app_error.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/section.dart';

abstract class IUsersRepo {
  AsyncErrorOr<List<UsersSection>> getUsers([String page = '1']);
}
