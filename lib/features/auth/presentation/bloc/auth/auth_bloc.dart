import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_flutter_test/core/helpers/event_status.dart';
import 'package:owwn_flutter_test/core/utils/app_error.dart';
import 'package:owwn_flutter_test/features/auth/domain/repos/auth_repo.dart';
import 'package:owwn_flutter_test/features/auth/domain/usecases/sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repo) : super(const AuthState()) {
    on<SignIn>(_signIn);
  }

  final IAuthRepo _repo;

  Future _signIn(SignIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));
    final result = await SignInCase(_repo, email: event.email).call();
    result.fold(
      //Callback when error is returned, [Left] side of Either
      (l) {
        emit(state.copyWith(
          isSignedIn: false,
          status: EventStatus.error,
          error: l,
        ));
      },
      //Callback when success is returned, [Right] side of Either
      (r) {
        emit(state.copyWith(isSignedIn: true, status: EventStatus.success));
      },
    );
  }
}
