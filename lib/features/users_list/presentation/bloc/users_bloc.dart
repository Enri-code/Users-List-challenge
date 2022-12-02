import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owwn_flutter_test/core/helpers/event_status.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/section.dart';
import 'package:owwn_flutter_test/features/users_list/domain/entities/user.dart';
import 'package:owwn_flutter_test/features/users_list/domain/repos/users_repo.dart';
import 'package:owwn_flutter_test/features/users_list/domain/usecases/get_users_sections.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this._repo) : super(const UsersState()) {
    on<GetUsers>(_getUsers);
    on<UpdateUserData>(_updateUser);
  }

  final IUsersRepo _repo;

  int page = 1;

  void _updateUser(UpdateUserData event, Emitter<UsersState> emit) {
    int userIndex = -1;

    //Attempts to find the user's location in the Sections' Users' Lists
    final sectionId = state.sections.indexWhere(
      (e) => (userIndex = e.users.indexOf(event.user)) > -1,
    );

    if (userIndex < 0 || sectionId < 0) return;

    //Returns new user with data updated
    final user = event.user.copyWith(name: event.name, email: event.email);

    final newSections = [...state.sections];

    //Replaces the old user instance with the updated one
    newSections[sectionId].users[userIndex] = user;

    //Emits a new state with the updated user for the bloc to rebuild
    emit(state.copyWith(sections: newSections));
  }

  Future _getUsers(GetUsers event, Emitter<UsersState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));

    final result = await GetUsersCase(_repo, page.toString()).call();

    result.fold(
      //Callback when error is returned, [Left] side of Either
      (l) => emit(state.copyWith(status: EventStatus.error)),

      //Callback when success is returned, [Right] side of Either
      (r) {
        page++;
        emit(state.copyWith(
          status: EventStatus.success,
          sections: [...state.sections, ...r],
        ));
      },
    );
  }
}
