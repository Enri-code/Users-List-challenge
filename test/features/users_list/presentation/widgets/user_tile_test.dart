import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:owwn_flutter_test/core/constants/config.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/gender.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/screens/user_profile.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/widgets/user_avatar.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/widgets/user_tile.dart';

void main() {
  final user = User(
    name: 'Eric Onyeulo',
    email: 'test@gmail.com',
    gender: Gender.male,
    createdAt: DateTime.now(),
  );

  Widget buildWidget() {
    return MaterialApp(
      routes: AppConfig.appRoutes,
      home: Scaffold(body: UserTile(user: user)),
    );
  }

  group('Displays user tile widget and verifies tap behaviour', () {
    testWidgets(
      "Displays user info in UserTile",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildWidget());

        expect(find.text('EO'), findsOneWidget);
        expect(find.text(user.name), findsOneWidget);
        expect(find.text(user.email), findsOneWidget);
        expect(find.byType(UserNameAvatar), findsOneWidget);
      },
    );

    testWidgets(
      "Verifies UserTile tap opens User Profile Screen",
      (WidgetTester tester) async {
        await tester.pumpWidget(buildWidget());

        expect(find.byType(UserProfileScreen), findsNothing);

        await tester.tap(find.byType(UserTile));
        await tester.pumpAndSettle();

        expect(find.byType(UserProfileScreen), findsOneWidget);
      },
    );
  });
}
