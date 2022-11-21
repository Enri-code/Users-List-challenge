import 'package:owwn_flutter_test/features/users_list/domain/entities/status.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';

class UsersSection {
  final Status status;
  final List<User> users;

  const UsersSection({required this.status, required this.users});
}
