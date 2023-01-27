import 'package:dartz/dartz.dart';
import 'package:owwn_flutter_test/core/utils/app_error.dart';
import 'package:owwn_flutter_test/features/auth/domain/repos/auth_repo.dart';
import 'package:owwn_flutter_test/features/auth/domain/repos/auth_service.dart';

class AuthRepoImpl extends IAuthRepo {
  const AuthRepoImpl(this.service);

  final IAuthService service;

  @override
  AsyncErrorOr<void> signIn(String email) async {
    try {
      await service.signIn(email);
      return const Right(null);
    } catch (_) {
      return const Left(AppError());
    }
  }
}
