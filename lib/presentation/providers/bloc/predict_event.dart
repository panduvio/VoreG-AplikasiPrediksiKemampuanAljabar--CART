part of 'predict_bloc.dart';

@immutable
abstract class PredictEvent {}

class GenerateRoot extends PredictEvent {
  final List<UserDataEntity> userList;

  GenerateRoot({required this.userList});
}

class GenerateBranch extends PredictEvent {
  final List<UserDataEntity> userList;
  final DecisionTreeEntity root;

  GenerateBranch({
    required this.userList,
    required this.root,
  });
}

class GenerateRecom extends PredictEvent {
  final String nama;
  final String bidang;
  final String label;

  GenerateRecom({
    required this.nama,
    required this.bidang,
    required this.label,
  });
}

class PredictTest extends PredictEvent {
  final List<DecisionTreeEntity> branchList;
  final int predictIndex;
  final double predictScore;

  PredictTest({
    required this.branchList,
    required this.predictIndex,
    required this.predictScore,
  });
}

class AccuracyPredict extends PredictEvent {
  final List<UserDataEntity> userList;
  final List<DecisionTreeEntity> branchList;

  AccuracyPredict({
    required this.userList,
    required this.branchList,
  });
}

class ClearPredict extends PredictEvent {}
