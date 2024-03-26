import 'package:skripsi/domain/entities/decision_tree_entity.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';

class PredictAccuracyUsecase {
  Map<String, dynamic> accPredict(
      List<UserDataEntity> userList, List<DecisionTreeEntity> branchList) {
    Map<String, dynamic> result = {
      'accuracy': 0,
      'true': 0,
      'false': 0,
    };

    for (int i = 0; i < userList.length; i++) {
      for (int j = 0; j < branchList.length; j++) {
        if (branchList[j].name == 'Eksponensial') {
          if (userList[i].eksponensialScore < branchList[j].condition) {
            if (branchList[j].haveChild == true) {
              continue;
            } else {
              if (userList[i].aljabarStrength == branchList[j].trueLeaf) {
                result['true']++;
                break;
              } else {
                result['false']++;
                break;
              }
            }
          } else {
            if (branchList[j].haveChild == true) {
              j++;
              continue;
            } else {
              if (userList[i].aljabarStrength == branchList[j].falseLeaf) {
                result['true']++;
                break;
              } else {
                result['false']++;
                break;
              }
            }
          }
        } else if (branchList[j].name == 'SPLTV') {
          if (userList[i].spltvScore < branchList[j].condition) {
            if (branchList[j].haveChild == true) {
              continue;
            } else {
              if (userList[i].aljabarStrength == branchList[j].trueLeaf) {
                result['true']++;
                break;
              } else {
                result['false']++;
                break;
              }
            }
          } else {
            if (branchList[j].haveChild == true) {
              j++;
              continue;
            } else {
              if (userList[i].aljabarStrength == branchList[j].falseLeaf) {
                result['true']++;
                break;
              } else {
                result['false']++;
                break;
              }
            }
          }
        } else if (branchList[j].name == 'Fungsi') {
          if (userList[i].fungsiScore < branchList[j].condition) {
            if (branchList[j].haveChild == true) {
              continue;
            } else {
              if (userList[i].aljabarStrength == branchList[j].trueLeaf) {
                result['true']++;
                break;
              } else {
                result['false']++;
                break;
              }
            }
          } else {
            if (branchList[j].haveChild == true) {
              continue;
            } else {
              if (userList[i].aljabarStrength == branchList[j].falseLeaf) {
                result['true']++;
                break;
              } else {
                result['false']++;
                break;
              }
            }
          }
        } else {
          if (userList[i].aljabarStrength == branchList[j].name) {
            result['true']++;
            break;
          } else {
            result['false']++;
            break;
          }
        }
      }
    }

    result['accuracy'] = result['true'] / userList.length;

    return result;
  }
}
