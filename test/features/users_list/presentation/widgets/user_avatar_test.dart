import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/gender.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/widgets/user_avatar.dart';

void main() {
  Widget buildAvatar(String name) {
    return MaterialApp(
      home: Scaffold(
        body: UserNameAvatar(
          user: User(
            name: name,
            gender: Gender.female,
            createdAt: DateTime.now(),
          ),
        ),
      ),
    );
  }

  testWidgets(
    "Displays shortened form of user's name passed to widget",
    (WidgetTester tester) async {
      await tester.pumpWidget(buildAvatar('Eric Onyeulo'));
      expect(find.text('EO'), findsOneWidget);
      await tester.pumpWidget(buildAvatar('Dave Richie-Smart'));
      expect(find.text('DR'), findsOneWidget);
    },
  );
}
