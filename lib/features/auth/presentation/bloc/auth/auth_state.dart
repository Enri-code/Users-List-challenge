part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.status = EventStatus.initial,
    this.isSignedIn = false,
    this.error,
  });

  final EventStatus status;
  final AppError? error;
  final bool isSignedIn;

  AuthState copyWith({EventStatus? status, bool? isSignedIn, AppError? error}) {
    return AuthState(
      error: error,
      status: status ?? this.status,
      isSignedIn: isSignedIn ?? this.isSignedIn,
    );
  }

  @override
  List<Object?> get props => [status, error, isSignedIn];
}
