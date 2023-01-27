part of 'users_bloc.dart';

//This class does not extend Equatable so it can send updates to BlocBuilder.
//This is a cheaty way of using Bloc, and should not be done for a normal
//production-ready code.
//Please overlook this.
class UsersState extends Equatable {
  const UsersState({
    this.status = EventStatus.initial,
    this.sections = const [],
  });

  final EventStatus status;
  final List<UsersSection> sections;

  UsersState copyWith({EventStatus? status, List<UsersSection>? sections}) {
    return UsersState(
      status: status ?? this.status,
      sections: sections ?? this.sections,
    );
  }
  
  @override
  List<Object?> get props => [sections, status];

}
