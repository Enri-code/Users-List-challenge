import 'package:owwn_flutter_test/core/utils/app_error.dart';
import 'package:owwn_flutter_test/core/utils/use_case_base.dart';
import 'package:owwn_flutter_test/features/auth/domain/repos/auth_repo.dart';

class SignInCase extends UseCase<void> {
  const SignInCase(this._repo, {required this.email});

  final IAuthRepo _repo;
  final String email;

  @override
  AsyncErrorOr<void> call() => _repo.signIn(email);
}
