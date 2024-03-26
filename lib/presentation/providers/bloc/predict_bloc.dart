import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skripsi/dependency_injection.dart';
import 'package:skripsi/domain/entities/decision_tree_entity.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/domain/usecases/generate_branch_usecase.dart';
import 'package:skripsi/domain/usecases/generate_root_usecase.dart';
import 'package:skripsi/domain/usecases/predict_accuracy_usecase.dart';
import 'package:skripsi/domain/usecases/predict_test_usecase.dart';
import 'package:skripsi/domain/usecases/recommend_usecase.dart';

part 'predict_event.dart';
part 'predict_state.dart';

class PredictBloc extends Bloc<PredictEvent, PredictState> with ChangeNotifier {
  PredictBloc() : super(TryToGenerateBranch()) {
    on<GenerateRoot>(_generateRoot);
    on<GenerateBranch>(_generateBranch);
    on<PredictTest>(_predictTest);
    on<ClearPredict>(_clearPredict);
    on<AccuracyPredict>(_accuracyPredict);
    on<GenerateRecom>(_generateRecom);
  }

  void _generateRoot(GenerateRoot event, Emitter<PredictState> emit) async {
    emit(TryToGenerateBranch());
    try {
      final root = await sl<GenerateRootUsecase>().generateRoot(event.userList);
      notifyListeners();
      emit(SuccessGenerateRoot(root));
    } catch (e) {
      emit(TryToGenerateBranch());
      throw Exception('Failed to generate: $e');
    }
  }

  void _generateBranch(GenerateBranch event, Emitter<PredictState> emit) async {
    emit(TryToGenerateBranch());
    try {
      final branches = await sl<GenerateBranchUsecase>()
          .generateBranch(event.userList, event.root);
      notifyListeners();
      emit(SuccessGenerateBranch(branches));
    } catch (e) {
      emit(TryToGenerateBranch());
      throw Exception('Failed to generate: $e');
    }
  }

  void _predictTest(PredictTest event, Emitter<PredictState> emit) async {
    emit(TryToPredict());
    try {
      final result = sl<PredictTestUsecase>()
          .predict(event.branchList, event.predictIndex, event.predictScore);
      notifyListeners();
      emit(SuccessPredict(result));
    } catch (e) {}
  }

  void _accuracyPredict(
      AccuracyPredict event, Emitter<PredictState> emit) async {
    emit(TryToPredict());
    try {
      final result = sl<PredictAccuracyUsecase>().accPredict(
        event.userList,
        event.branchList,
      );
      notifyListeners();
      emit(SuccessPredictAcc(result));
    } catch (e) {}
  }

  void _clearPredict(ClearPredict event, Emitter<PredictState> emit) {
    emit(SuccessClearPredict());
  }

  void _generateRecom(GenerateRecom event, Emitter<PredictState> emit) async {
    emit(TryToGenerateBranch());
    try {
      final recommendation = await sl<RecomendUsecase>()
          .recommend(event.nama, event.bidang, event.label);
      emit(SuccessGenerateRecom(recommendation));
    } catch (e) {}
  }

  void clearState() {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(SuccessClearPredict());
  }
}
