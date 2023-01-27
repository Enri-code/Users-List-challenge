import 'package:owwn_flutter_test/features/users_list/domain/entities/status.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';

class UsersSection {
  final Status status;
  final List<User> users;

  const UsersSection({
    required this.status,
    required this.users,
  });

  UsersSection copyWith({Status? status, List<User>? users}) {
    return UsersSection(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
