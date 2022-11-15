import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:owwn_flutter_test/features/auth/domain/repos/auth_repo.dart';
import 'package:owwn_flutter_test/features/auth/domain/usecases/sign_in.dart';

import 'sign_in_test.mocks.dart';

@GenerateMocks([IAuthRepo])
void main() {
  const email = 'test@gmail.com';

  late SignInCase usecase;
  late MockIAuthRepo mockRepo;

  setUp(() {
    mockRepo = MockIAuthRepo();
    usecase = SignInCase(mockRepo, email: email);
  });

  const response = 'API-KEY';

  test(
    'should sign user in and return authentication token',
    () async {
      verifyZeroInteractions(mockRepo);
      //When [signIn] is called, it should return the [Right] of the
      //Either argument.
      when(mockRepo.signIn(email)).thenAnswer(
        (_) async => const Right(response),
      );

      ///Call the usecase function
      final result = await usecase();

      // Usecase should return what was returned from the repo
      expect(result, const Right(response));

      // Verify that the function was called on the repo
      verify(mockRepo.signIn(email)).called(1);

      // Verify no other method was called on the repo.
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
