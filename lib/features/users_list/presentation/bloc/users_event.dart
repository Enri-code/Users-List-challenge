// ignore_for_file: avoid_implementing_value_types

part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class GetUsers extends UsersEvent {}

class UpdateUserData extends UsersEvent {
  final User user;
  final String? name;
  final String? email;

  const UpdateUserData(this.user, {this.name, this.email});

  @override
  List<Object?> get props => [user, email, name];
}

/*
class ResetUpdateduser extends UsersEvent {}
 */
