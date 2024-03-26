part of 'user_bloc.dart';

abstract class UserState {}

class TryToGetState extends UserState {}

class TryToPostState extends UserState {}

class PostSuccessState extends UserState {}

class TryToRemoveState extends UserState {}

class RemoveSuccessState extends UserState {}

class GetSuccessState extends UserState {
  final UserDataEntity userData;

  GetSuccessState(this.userData);
}

class GetAllSuccessState extends UserState {
  final List<UserDataEntity> users;

  GetAllSuccessState(this.users);
}

class CleanSuccessState extends UserState {
  final List<UserDataEntity> userList;

  CleanSuccessState(this.userList);
}
