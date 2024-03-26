import 'package:get_it/get_it.dart';
import 'package:skripsi/data/repositories/user_data_repository_impl.dart';
import 'package:skripsi/data/source/user_db.dart';
import 'package:skripsi/domain/repositories/user_data_repository.dart';
import 'package:skripsi/domain/usecases/data_cleaning_usecase.dart';
import 'package:skripsi/domain/usecases/generate_branch_usecase.dart';
import 'package:skripsi/domain/usecases/generate_root_usecase.dart';
import 'package:skripsi/domain/usecases/get_all_data_usecase.dart';
import 'package:skripsi/domain/usecases/post_data_usecase.dart';
import 'package:skripsi/domain/usecases/predict_accuracy_usecase.dart';
import 'package:skripsi/domain/usecases/predict_test_usecase.dart';
import 'package:skripsi/domain/usecases/recommend_usecase.dart';
import 'package:skripsi/domain/usecases/remove_this_data_usecase.dart';
import 'package:skripsi/domain/usecases/update_data_usecase.dart';

final sl = GetIt.instance;

void setUp() {
  // Database Singleton
  sl.registerLazySingleton<UserDb>(() => UserDb());

  // Repository Singleton
  sl.registerLazySingleton<UserDataRepository>(
      () => UserDataRepositoryImpl(sl()));

  // Usecase Singleton
  sl.registerLazySingleton<GenerateBranchUsecase>(
      () => GenerateBranchUsecase());
  sl.registerLazySingleton<GenerateRootUsecase>(() => GenerateRootUsecase());
  sl.registerLazySingleton<PredictAccuracyUsecase>(
      () => PredictAccuracyUsecase());
  sl.registerLazySingleton<PredictTestUsecase>(() => PredictTestUsecase());
  sl.registerLazySingleton<DataCleaningUsecase>(() => DataCleaningUsecase());
  sl.registerLazySingleton<GetAllDataUsecase>(() => GetAllDataUsecase(sl()));
  sl.registerLazySingleton<PostDataUsecase>(() => PostDataUsecase(sl()));
  sl.registerLazySingleton<UpdateDataUsecase>(() => UpdateDataUsecase(sl()));
  sl.registerLazySingleton<RemoveThisDataUsecase>(
      () => RemoveThisDataUsecase(sl()));

  sl.registerLazySingleton<RecomendUsecase>(() => RecomendUsecase());
}
