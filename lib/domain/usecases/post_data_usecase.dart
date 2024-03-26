import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/domain/repositories/user_data_repository.dart';

class PostDataUsecase {
  final UserDataRepository repository;

  PostDataUsecase(this.repository);

  Future<void> postData(UserDataEntity userData) {
    return repository.postData(userData);
  }
}
