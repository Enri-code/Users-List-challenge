import 'package:owwn_flutter_test/features/users_list/domain/entities/gender.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/status.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';

class UserModel extends User {
  UserModel.fromMap(Map<String, dynamic> map)
      : super(
          id: map['id']! as String,
          name: map['name']! as String,
          email: map['email'] as String? ?? '',
          partnerId: map['partner_id']! as String,
          status: Status.fromValue(map['status']! as String),
          gender: Gender.fromValue(map['gender']! as String),
          statistics: (map['statistics'] as List?)?.cast<num>(),
          createdAt: DateTime.parse(map['created_at']! as String),
        );
}
