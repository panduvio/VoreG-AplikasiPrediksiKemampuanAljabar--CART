import 'package:skripsi/domain/entities/user_data_entity.dart';

class DataCleaningUsecase {
  Future<List<UserDataEntity>> cleanData(List<UserDataEntity> userList) async {
    final list = List<UserDataEntity>.from(userList);
    List<UserDataEntity> result = [];

    for (int i = 0; i < list.length; i++) {
      if (list[i].eksponensialScore == 0 ||
          list[i].spltvScore == 0 ||
          list[i].fungsiScore == 0) {
        continue;
      } else {
        result.add(list[i]);
      }
    }

    return result;
  }
}
