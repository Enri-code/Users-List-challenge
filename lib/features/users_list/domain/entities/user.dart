import 'package:owwn_flutter_test/features/users_list/domain/entities/gender.dart';

class User {
  final String id;
  final String partnerId;
  final String status;
  final DateTime createdAt;
  final String name;
  final String email;
  final Gender gender;
  final List<num>? statistics;

  User({
    required this.name,
    required this.gender,
    required this.createdAt,
    this.status = 'active',
    this.id = '',
    this.partnerId = '',
    this.email = '',
    this.statistics = const [],
  });

  User copyWith({String? name, String? email}) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id,
      gender: gender,
      partnerId: partnerId,
      statistics: statistics,
      createdAt: createdAt,
    );
  }

  @override
  bool operator ==(dynamic other) => other is User && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
