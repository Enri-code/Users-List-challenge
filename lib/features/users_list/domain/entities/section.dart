import 'package:owwn_flutter_test/features/users_list/domain/entities/section_type.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';

class UsersSection {
  final SectionType type;
  final List<User> users;

  const UsersSection({required this.type, required this.users});
}
