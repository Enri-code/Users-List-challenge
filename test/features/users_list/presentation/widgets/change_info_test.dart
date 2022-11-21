import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:owwn_flutter_test/core/constants/config.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/gender.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';
import 'package:owwn_flutter_test/features/users_list/presentation/widgets/change_info.dart';

class OnSaveMock extends Mock {
  void call(String value);
}

void main() {
  late OnSaveMock onSave;

  late User user;

  setUp(() {
    onSave = OnSaveMock();
    user = User(
      name: 'Eric Onyeulo',
      email: 'test@gmail.com',
      gender: Gender.male,
      createdAt: DateTime.now(),
    );
  });

  Widget buildWidget(Widget widget) {
    return MaterialApp(
      routes: AppConfig.appRoutes,
      home: Scaffold(body: widget),
    );
  }

  group('Tests behaviour for the edit info dialog.', () {
    testWidgets(
      "Displays dialog for editing user's info",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          buildWidget(ChangeUserInfoDialog(initialValue: user.name)),
        );
        expect(find.text(user.name), findsOneWidget);
        expect(find.byKey(const ValueKey('save')), findsOneWidget);
      },
    );
    testWidgets(
      "Changes text in textfield and saves",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          buildWidget(
            ChangeUserInfoDialog(initialValue: user.name, onSave: onSave),
          ),
        );
        const newText = 'David Onyeulo';

        verifyZeroInteractions(onSave);

        final text = find.text(user.name);
        expect(text, findsOneWidget);

        await tester.enterText(text, newText);
        await tester.pumpAndSettle();

        expect(find.text(user.name), findsNothing);
        expect(find.text(newText), findsOneWidget);

        await tester.tap(find.byKey(const ValueKey('save')));
        await tester.pumpAndSettle();

        expect(find.byType(ChangeUserInfoDialog), findsNothing);
        verify(onSave(newText)).called(1);
        verifyNoMoreInteractions(onSave);
      },
    );
  });
}
