import '../entities/user_data_entity.dart';

abstract class UserDataRepository {
  Future<List<UserDataEntity>> getAllData();
  Future<void> removeThisData(int id);
  Future<void> postData(UserDataEntity userData);
  Future<void> updateData(UserDataEntity userData);
}
