part of 'predict_bloc.dart';

abstract class PredictState {}

class TryToGenerateBranch extends PredictState {}

class TryToPredict extends PredictState {}

class SuccessGenerateRoot extends PredictState {
  final DecisionTreeEntity root;

  SuccessGenerateRoot(this.root);
}

class SuccessPredict extends PredictState {
  final Map<String, dynamic> result;

  SuccessPredict(this.result);
}

class SuccessPredictAcc extends PredictState {
  final Map<String, dynamic> result;

  SuccessPredictAcc(this.result);
}

class SuccessGenerateBranch extends PredictState {
  final List<DecisionTreeEntity> branches;

  SuccessGenerateBranch(this.branches);
}

class SuccessGenerateRecom extends PredictState {
  final String recommendation;

  SuccessGenerateRecom(this.recommendation);
}

class SuccessClearPredict extends PredictState {}

class FailedGenerateRoot extends PredictState {}

class FailedGenerateBranch extends PredictState {}
