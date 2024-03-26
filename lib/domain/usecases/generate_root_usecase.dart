import 'dart:async';
import 'dart:math';

import 'package:skripsi/domain/entities/decision_tree_entity.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';

class GenerateRootUsecase {
  Future<DecisionTreeEntity> generateRoot(List<UserDataEntity> userList) async {
    // General Variable

    DecisionTreeEntity eksponensialBranch = DecisionTreeEntity(
        name: '',
        condition: 0,
        giniT: 0,
        giniF: 0,
        giniTotal: 0,
        lemahT: 0,
        sedangT: 0,
        kuatT: 0,
        lemahF: 0,
        sedangF: 0,
        kuatF: 0,
        trueLeaf: '',
        falseLeaf: '',
        haveChild: false);
    DecisionTreeEntity spltvBranch = DecisionTreeEntity(
        name: '',
        condition: 0,
        giniT: 0,
        giniF: 0,
        giniTotal: 0,
        lemahT: 0,
        sedangT: 0,
        kuatT: 0,
        lemahF: 0,
        sedangF: 0,
        kuatF: 0,
        trueLeaf: '',
        falseLeaf: '',
        haveChild: false);
    DecisionTreeEntity fungsiBranch = DecisionTreeEntity(
        name: '',
        condition: 0,
        giniT: 0,
        giniF: 0,
        giniTotal: 0,
        lemahT: 0,
        sedangT: 0,
        kuatT: 0,
        lemahF: 0,
        sedangF: 0,
        kuatF: 0,
        trueLeaf: '',
        falseLeaf: '',
        haveChild: false);

    DecisionTreeEntity countEksponensialGini() {
      // Count Eksponensial Usecase
      List<double> eksponensialAvr = [];
      List<DecisionTreeEntity> branchList = [];
      DecisionTreeEntity branch;
      final List<UserDataEntity> userOnEksponensial = List.from(userList);

      // Step 1: Sort Eksponensial Score
      userOnEksponensial
          .sort((a, b) => a.eksponensialScore.compareTo(b.eksponensialScore));
      final scoreOnEksponensial =
          userOnEksponensial.map((user) => user.eksponensialScore).toList();

      // Step 2: Count Average for Eksponensial
      for (int i = 0; i < scoreOnEksponensial.length - 1; i++) {
        eksponensialAvr
            .add((scoreOnEksponensial[i] + scoreOnEksponensial[i + 1]) / 2);
      }

      // Step 3: Classificate Fundamental Based on Eksponensial
      for (int i = 0; i < eksponensialAvr.length; i++) {
        branch = DecisionTreeEntity(
          name: '',
          condition: 0,
          giniT: 0,
          giniF: 0,
          giniTotal: 0,
          lemahT: 0,
          sedangT: 0,
          kuatT: 0,
          trueLeaf: '0',
          falseLeaf: '0',
          haveChild: true,
          lemahF: 0,
          sedangF: 0,
          kuatF: 0,
        );

        for (int j = 0; j < userOnEksponensial.length; j++) {
          if (userOnEksponensial[j].eksponensialScore < eksponensialAvr[i]) {
            switch (userOnEksponensial[j].aljabarStrength) {
              case 'Kurang':
                branch.lemahT++;
                break;
              case 'Sedang':
                branch.sedangT++;
                break;
              case 'Tinggi':
                branch.kuatT++;
                break;
            }
          } else {
            switch (userOnEksponensial[j].aljabarStrength) {
              case 'Kurang':
                branch.lemahF++;
                break;
              case 'Sedang':
                branch.sedangF++;
                break;
              case 'Tinggi':
                branch.kuatF++;
                break;
            }
          }
        }

        branchList.add(branch);
      }

      // Step 4: Count Gini for Each Average
      for (int i = 0; i < branchList.length; i++) {
        final trueLemah = branchList[i].lemahT;
        final trueSedang = branchList[i].sedangT;
        final trueKuat = branchList[i].kuatT;
        final total = trueLemah + trueSedang + trueKuat;
        final trueGini = 1 -
            pow((trueLemah / total), 2) -
            pow((trueSedang / total), 2) -
            pow((trueKuat / total), 2);

        final falseLemah = branchList[i].lemahF;
        final falseSedang = branchList[i].sedangF;
        final falseKuat = branchList[i].kuatF;
        final falseTotal = falseLemah + falseSedang + falseKuat;
        final falseGini = 1 -
            pow((falseLemah / falseTotal), 2) -
            pow((falseSedang / falseTotal), 2) -
            pow((falseKuat / falseTotal), 2);

        branchList[i].giniT = trueGini.toDouble();
        branchList[i].giniF = falseGini.toDouble();
      }

      // Step 5: Count Total Gini from each average
      for (int i = 0; i < eksponensialAvr.length; i++) {
        final trueTotal =
            branchList[i].lemahT + branchList[i].sedangT + branchList[i].kuatT;
        final falseTotal =
            branchList[i].lemahF + branchList[i].sedangF + branchList[i].kuatF;

        final total = trueTotal + falseTotal;
        final totalGini = ((trueTotal / total) * branchList[i].giniT) +
            ((falseTotal / total) * branchList[i].giniF);
        branchList[i].giniTotal = totalGini;
      }

      // Step 6: Eksponensial Branch Deciding
      for (int i = 0; i < branchList.length; i++) {
        final sortedGini = List<DecisionTreeEntity>.from(branchList);
        sortedGini.sort((a, b) => a.giniTotal.compareTo(b.giniTotal));
        if (branchList[i].giniTotal == sortedGini[0].giniTotal) {
          eksponensialBranch = DecisionTreeEntity(
            name: 'Eksponensial',
            condition: eksponensialAvr[i],
            giniT: branchList[i].giniT,
            giniF: branchList[i].giniF,
            giniTotal: branchList[i].giniTotal,
            lemahT: branchList[i].lemahT,
            sedangT: branchList[i].sedangT,
            kuatT: branchList[i].kuatT,
            trueLeaf: '0',
            falseLeaf: '0',
            haveChild: true,
            lemahF: branchList[i].lemahF,
            sedangF: branchList[i].sedangF,
            kuatF: branchList[i].kuatF,
          );
          break;
        }
      }
      return eksponensialBranch;
    }

    eksponensialBranch = countEksponensialGini();

    DecisionTreeEntity countSPLTVGini() {
      // Count SPLTV Usecase
      List<double> spltvAvr = [];
      List<DecisionTreeEntity> branchList = [];
      DecisionTreeEntity branch;
      final List<UserDataEntity> userOnSPLTV = List.from(userList);

      // Step 1: Sort SPLTV Score
      userOnSPLTV.sort((a, b) => a.spltvScore.compareTo(b.spltvScore));
      final scoreOnSPLTV = userOnSPLTV.map((user) => user.spltvScore).toList();

      // Step 2: Count Average for SPLTV
      for (int i = 0; i < scoreOnSPLTV.length - 1; i++) {
        spltvAvr.add((scoreOnSPLTV[i] + scoreOnSPLTV[i + 1]) / 2);
      }

      // Step 3: Classificate Fundamental Based on SPLTV
      for (int i = 0; i < spltvAvr.length; i++) {
        branch = DecisionTreeEntity(
          name: '',
          condition: 0,
          giniT: 0,
          giniF: 0,
          giniTotal: 0,
          lemahT: 0,
          sedangT: 0,
          kuatT: 0,
          trueLeaf: '0',
          falseLeaf: '0',
          haveChild: false,
          lemahF: 0,
          sedangF: 0,
          kuatF: 0,
        );

        for (int j = 0; j < userOnSPLTV.length; j++) {
          if (userOnSPLTV[j].spltvScore < spltvAvr[i]) {
            switch (userOnSPLTV[j].aljabarStrength) {
              case 'Kurang':
                branch.lemahT++;
                break;
              case 'Sedang':
                branch.sedangT++;
                break;
              case 'Tinggi':
                branch.kuatT++;
                break;
            }
          } else {
            switch (userOnSPLTV[j].aljabarStrength) {
              case 'Kurang':
                branch.lemahF++;
                break;
              case 'Sedang':
                branch.sedangF++;
                break;
              case 'Tinggi':
                branch.kuatF++;
                break;
            }
          }
        }

        branchList.add(branch);
      }

      // Step 4: Count Gini for Each Average
      for (int i = 0; i < branchList.length; i++) {
        final trueLemah = branchList[i].lemahT;
        final trueSedang = branchList[i].sedangT;
        final trueKuat = branchList[i].kuatT;
        final total = trueLemah + trueSedang + trueKuat;
        final trueGini = 1 -
            pow((trueLemah / total), 2) -
            pow((trueSedang / total), 2) -
            pow((trueKuat / total), 2);

        final falseLemah = branchList[i].lemahF;
        final falseSedang = branchList[i].sedangF;
        final falseKuat = branchList[i].kuatF;
        final falseTotal = falseLemah + falseSedang + falseKuat;
        final falseGini = 1 -
            pow((falseLemah / falseTotal), 2) -
            pow((falseSedang / falseTotal), 2) -
            pow((falseKuat / falseTotal), 2);

        branchList[i].giniT = trueGini.toDouble();
        branchList[i].giniF = falseGini.toDouble();
      }

      // Step 5: Count Total Gini from each average
      for (int i = 0; i < spltvAvr.length; i++) {
        final trueTotal =
            branchList[i].lemahT + branchList[i].sedangT + branchList[i].kuatT;
        final falseTotal =
            branchList[i].lemahF + branchList[i].sedangF + branchList[i].kuatF;

        final total = trueTotal + falseTotal;
        final totalGini = ((trueTotal / total) * branchList[i].giniT) +
            ((falseTotal / total) * branchList[i].giniF);
        branchList[i].giniTotal = totalGini;
      }

      // Step 6: SPLTV Branch Deciding
      for (int i = 0; i < branchList.length; i++) {
        final sortedGini = List<DecisionTreeEntity>.from(branchList);
        sortedGini.sort((a, b) => a.giniTotal.compareTo(b.giniTotal));
        if (branchList[i].giniTotal == sortedGini[0].giniTotal) {
          spltvBranch = DecisionTreeEntity(
            name: 'SPLTV',
            condition: spltvAvr[i],
            giniT: branchList[i].giniT,
            giniF: branchList[i].giniF,
            giniTotal: branchList[i].giniTotal,
            lemahT: branchList[i].lemahT,
            sedangT: branchList[i].sedangT,
            kuatT: branchList[i].kuatT,
            trueLeaf: '0',
            falseLeaf: '0',
            haveChild: true,
            lemahF: branchList[i].lemahF,
            sedangF: branchList[i].sedangF,
            kuatF: branchList[i].kuatF,
          );
          break;
        }
      }
      return spltvBranch;
    }

    spltvBranch = countSPLTVGini();

    DecisionTreeEntity countFungsiGini() {
      // Count Fungsi Usecase
      List<double> fungsiAvr = [];
      List<DecisionTreeEntity> branchList = [];
      DecisionTreeEntity branch;
      final List<UserDataEntity> userOnFungsi = List.from(userList);

      // Step 1: Sort Fungsi Score
      userOnFungsi.sort((a, b) => a.fungsiScore.compareTo(b.fungsiScore));
      final scoreOnFungsi =
          userOnFungsi.map((user) => user.fungsiScore).toList();

      // Step 2: Count Average for Fungsi
      for (int i = 0; i < scoreOnFungsi.length - 1; i++) {
        fungsiAvr.add((scoreOnFungsi[i] + scoreOnFungsi[i + 1]) / 2);
      }

      // Step 3: Classificate Fundamental Based on Fungsi
      for (int i = 0; i < fungsiAvr.length; i++) {
        branch = DecisionTreeEntity(
          name: '',
          condition: 0,
          giniT: 0,
          giniF: 0,
          giniTotal: 0,
          lemahT: 0,
          sedangT: 0,
          kuatT: 0,
          trueLeaf: '0',
          falseLeaf: '0',
          haveChild: true,
          lemahF: 0,
          sedangF: 0,
          kuatF: 0,
        );

        for (int j = 0; j < userOnFungsi.length; j++) {
          if (userOnFungsi[j].fungsiScore < fungsiAvr[i]) {
            switch (userOnFungsi[j].aljabarStrength) {
              case 'Kurang':
                branch.lemahT++;
                break;
              case 'Sedang':
                branch.sedangT++;
                break;
              case 'Tinggi':
                branch.kuatT++;
                break;
            }
          } else {
            switch (userOnFungsi[j].aljabarStrength) {
              case 'Kurang':
                branch.lemahF++;
                break;
              case 'Sedang':
                branch.sedangF++;
                break;
              case 'Tinggi':
                branch.kuatF++;
                break;
            }
          }
        }

        branchList.add(branch);
      }

      // Step 4: Count Gini for Each Average
      for (int i = 0; i < branchList.length; i++) {
        final trueLemah = branchList[i].lemahT;
        final trueSedang = branchList[i].sedangT;
        final trueKuat = branchList[i].kuatT;
        final total = trueLemah + trueSedang + trueKuat;
        final trueGini = 1 -
            pow((trueLemah / total), 2) -
            pow((trueSedang / total), 2) -
            pow((trueKuat / total), 2);

        final falseLemah = branchList[i].lemahF;
        final falseSedang = branchList[i].sedangF;
        final falseKuat = branchList[i].kuatF;
        final falseTotal = falseLemah + falseSedang + falseKuat;
        final falseGini = 1 -
            pow((falseLemah / falseTotal), 2) -
            pow((falseSedang / falseTotal), 2) -
            pow((falseKuat / falseTotal), 2);

        branchList[i].giniT = trueGini.toDouble();
        branchList[i].giniF = falseGini.toDouble();
      }

      // Step 5: Count Total Gini from each average
      for (int i = 0; i < fungsiAvr.length; i++) {
        final trueTotal =
            branchList[i].lemahT + branchList[i].sedangT + branchList[i].kuatT;
        final falseTotal =
            branchList[i].lemahF + branchList[i].sedangF + branchList[i].kuatF;

        final total = trueTotal + falseTotal;
        final totalGini = ((trueTotal / total) * branchList[i].giniT) +
            ((falseTotal / total) * branchList[i].giniF);
        branchList[i].giniTotal = totalGini;
      }

      // Step 6: Fungsi Branch Deciding
      for (int i = 0; i < branchList.length; i++) {
        final sortedGini = List<DecisionTreeEntity>.from(branchList);
        sortedGini.sort((a, b) => a.giniTotal.compareTo(b.giniTotal));
        if (branchList[i].giniTotal == sortedGini[0].giniTotal) {
          fungsiBranch = DecisionTreeEntity(
            name: 'Fungsi',
            condition: fungsiAvr[i],
            giniT: branchList[i].giniT,
            giniF: branchList[i].giniF,
            giniTotal: branchList[i].giniTotal,
            lemahT: branchList[i].lemahT,
            sedangT: branchList[i].sedangT,
            kuatT: branchList[i].kuatT,
            trueLeaf: '0',
            falseLeaf: '0',
            haveChild: true,
            lemahF: branchList[i].lemahF,
            sedangF: branchList[i].sedangF,
            kuatF: branchList[i].kuatF,
          );
          break;
        }
      }
      return fungsiBranch;
    }

    fungsiBranch = countFungsiGini();

    // Final Step: Root Deciding
    final List<DecisionTreeEntity> preRoot = [
      eksponensialBranch,
      spltvBranch,
      fungsiBranch
    ];
    preRoot.sort((a, b) => a.giniTotal.compareTo(b.giniTotal));
    final root = preRoot[0];
    return root;
  }
}
