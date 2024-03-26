import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/domain/repositories/user_data_repository.dart';

class UpdateDataUsecase {
  final UserDataRepository repository;

  UpdateDataUsecase(this.repository);

  Future<void> updateData(UserDataEntity userData) {
    return repository.updateData(userData);
  }
}
