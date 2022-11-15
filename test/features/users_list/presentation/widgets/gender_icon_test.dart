import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/gender.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/widgets/gender_icon.dart';

void main() {
  group('Displays appropriate icon for respective gender', () {
    testWidgets(
      'Displays Female icon when Gender is Female',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: GenderIcon(gender: Gender.female)),
          ),
        );
        expect(find.byIcon(Icons.female), findsOneWidget);
        expect(find.byIcon(Icons.male), findsNothing);
      },
    );
    testWidgets(
      'Displays Male icon when Gender is Male',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: GenderIcon(gender: Gender.male)),
          ),
        );
        expect(find.byIcon(Icons.male), findsOneWidget);
        expect(find.byIcon(Icons.female), findsNothing);
      },
    );
  });
}
