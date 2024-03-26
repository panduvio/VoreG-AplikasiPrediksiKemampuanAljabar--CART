import 'package:skripsi/domain/entities/decision_tree_entity.dart';

class PredictTestUsecase {
  Map<String, dynamic> predict(List<DecisionTreeEntity> branchList,
      int predictIndex, double predictScore) {
    Map<String, dynamic> result = {
      'index': predictIndex,
      'leaf': '',
    };
    if (predictIndex == 0) {
      if (predictScore < branchList[predictIndex].condition) {
        if (branchList[1].name == 'Eksponensial' ||
            branchList[1].name == 'SPLTV' ||
            branchList[1].name == 'Fungsi') {
          result['index'] = 1;
        } else {
          result['index'] = 3;
          result['leaf'] = branchList[1].name;
        }
      } else {
        if (branchList[2].name == 'Eksponensial' ||
            branchList[2].name == 'SPLTV' ||
            branchList[2].name == 'Fungsi') {
          result['index'] = 2;
        } else {
          result['index'] = 3;
          result['leaf'] = branchList[2].name;
        }
      }
    } else {
      if (predictScore < branchList[predictIndex].condition) {
        result['index'] = 3;
        result['leaf'] = branchList[predictIndex].trueLeaf;
      } else {
        result['index'] = 3;
        result['leaf'] = branchList[predictIndex].falseLeaf;
      }
    }

    return result;
  }
}
