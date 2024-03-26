import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/domain/repositories/user_data_repository.dart';

class GetAllDataUsecase {
  final UserDataRepository repository;

  GetAllDataUsecase(this.repository);

  Future<List<UserDataEntity>> getAllData() {
    return repository.getAllData();
  }
}
