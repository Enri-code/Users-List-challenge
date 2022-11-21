import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/gender.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/section.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/status.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';
import 'package:owwn_flutter_test/features/users_list/domain/repos/users_repo.dart';
import 'package:owwn_flutter_test/features/users_list/domain/usecases/get_users_sections.dart';

import 'get_users_sections_test.mocks.dart';

@GenerateMocks([IUsersRepo])
void main() {
  late GetUsersCase usecase;
  late MockIUsersRepo mockRepo;

  setUp(() {
    mockRepo = MockIUsersRepo();
    usecase = GetUsersCase(mockRepo);
  });

  final response = [
    UsersSection(
      status: Status.active,
      users: [
        User(
          name: 'User Name',
          email: 'test@email.net',
          gender: Gender.male,
          createdAt: DateTime.now(),
        ),
      ],
    ),
  ];

  test(
    'should sign user in and return authentication token',
    () async {
      verifyZeroInteractions(mockRepo);
      //When [getUsers] is called, it should return the [Right] of the
      //Either argument.
      when(mockRepo.getUsers()).thenAnswer(
        (_) async => Right(response),
      );

      ///Call the usecase function
      final result = await usecase();

      // Usecase should return what was returned from the repo
      expect(result, Right(response));

      // Verify that the function was called on the repo
      verify(mockRepo.getUsers()).called(1);

      // Verify no other method was called on the repo.
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
