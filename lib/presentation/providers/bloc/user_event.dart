part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class PostUser extends UserEvent {
  final UserDataEntity userData;

  PostUser({required this.userData});
}

class UpdateUser extends UserEvent {
  final UserDataEntity userData;

  UpdateUser({required this.userData});
}

class RemoveThisUser extends UserEvent {
  final int id;

  RemoveThisUser({required this.id});
}

class CleanData extends UserEvent {
  final List<UserDataEntity> userList;

  CleanData({required this.userList});
}

class GetAllUser extends UserEvent {}
