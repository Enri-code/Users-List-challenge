import 'package:owwn_flutter_test/core/utils/app_error.dart';

/// Base interface for use cases, to ensure predictability
abstract class UseCase<T> {
  const UseCase();
  AsyncErrorOr<T> call();
}
