import 'package:owwn_flutter_test/core/utils/app_error.dart';
import 'package:owwn_flutter_test/core/utils/use_case_base.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/section.dart';
import 'package:owwn_flutter_test/features/users_list/domain/repos/users_repo.dart';

class GetUsersCase extends UseCase<List<UsersSection>> {
  const GetUsersCase(this._repo, [this.page = '1']);

  final String page;
  final IUsersRepo _repo;

  @override
  AsyncErrorOr<List<UsersSection>> call() => _repo.getUsers(page);
}
