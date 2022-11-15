import 'package:owwn_flutter_test/core/utils/app_error.dart';

abstract class IAuthRepo {
  const IAuthRepo();

  ///Returns user's access token
  AsyncErrorOr<void> signIn(String email);
}
