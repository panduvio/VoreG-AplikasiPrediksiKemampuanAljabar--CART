import 'package:skripsi/domain/repositories/user_data_repository.dart';

class RemoveThisDataUsecase {
  final UserDataRepository repository;

  RemoveThisDataUsecase(this.repository);

  Future<void> removeData(int id) {
    return repository.removeThisData(id);
  }
}
