import 'package:skripsi/data/source/user_db.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/domain/repositories/user_data_repository.dart';

class UserDataRepositoryImpl implements UserDataRepository {
  final UserDb _userDb;
  UserDataRepositoryImpl(this._userDb);

  @override
  Future<void> postData(UserDataEntity userData) async {
    await _userDb.postUser(userData);
  }

  @override
  Future<void> updateData(UserDataEntity userData) async {
    await _userDb.updateUser(userData);
  }

  @override
  Future<List<UserDataEntity>> getAllData() async {
    final users = await _userDb.getAllUser();
    return users;
  }

  @override
  Future<void> removeThisData(int id) async {
    await _userDb.removeUser(id);
  }
}
