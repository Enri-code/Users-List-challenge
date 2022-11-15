import 'package:dartz/dartz.dart';

typedef AsyncErrorOr<T> = Future<Either<AppError, T>>;

class AppError {
  final String? errMessage;

  const AppError([this.errMessage]);
}
