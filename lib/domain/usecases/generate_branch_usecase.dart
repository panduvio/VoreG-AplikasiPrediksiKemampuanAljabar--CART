import 'dart:math';

import 'package:skripsi/domain/entities/decision_tree_entity.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';

class GenerateBranchUsecase {
  Future<List<DecisionTreeEntity>> generateBranch(
      List<UserDataEntity> userList, DecisionTreeEntity root) async {
    // General Variable

    int counterI = 1;
    int counterII = 1;
    bool isPureI = false;
    bool isPureII = false;
    List<UserDataEntity> filteredListI = [];
    List<UserDataEntity> filteredListII = [];
    DecisionTreeEntity resultI;
    DecisionTreeEntity resultII;
    List<DecisionTreeEntity> branches = [];

    // Step 0: Filter Branch

    for (int i = 0; i < userList.length; i++) {
      switch (root.name) {
        case 'Eksponensial':
          if (userList[i].eksponensialScore < root.condition) {
            filteredListI.add(userList[i]);
          } else {
            filteredListII.add(userList[i]);
          }
          break;
        case 'SPLTV':
          if (userList[i].spltvScore < root.condition) {
            filteredListI.add(userList[i]);
          } else {
            filteredListII.add(userList[i]);
          }
          break;
        case 'Fungsi':
          if (userList[i].fungsiScore < root.condition) {
            filteredListI.add(userList[i]);
          } else {
            filteredListII.add(userList[i]);
          }
          break;
      }
    }

    // Identify The Result will be Leaf or Branch

    // List I
    if (filteredListI.length == 1) {
      isPureI = true;
    } else {
      for (int i = 0; i < filteredListI.length - 1; i++) {
        if (filteredListI[i].aljabarStrength ==
            filteredListI[i + 1].aljabarStrength) {
          counterI++;
        }
        if (counterI == filteredListI.length) {
          isPureI = true;
        } else {
          isPureI = false;
        }
      }
    }

    // List II
    if (filteredListII.length == 1) {
      isPureII = true;
    } else {
      for (int i = 0; i < filteredListII.length - 1; i++) {
        if (filteredListII[i].aljabarStrength ==
            filteredListII[i + 1].aljabarStrength) {
          counterII++;
          if (counterII == filteredListII.length) {
            isPureII = true;
          } else {
            isPureII = false;
          }
        }
      }
    }

    // Generate Branch I

    // Leaf Result
    DecisionTreeEntity leafResultI(String leaf) {
      final result = DecisionTreeEntity(
        name: leaf,
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
        haveChild: false,
      );

      return result;
    }

    // Branch Result
    DecisionTreeEntity branchResultI() {
      if (filteredListI.length == 2) {
        String name = '';
        double condition = 0;
        switch (root.name) {
          case 'Eksponensial':
            name = 'Fungsi';
            condition =
                (filteredListI[0].fungsiScore + filteredListI[1].fungsiScore) /
                    2;
            break;
          case 'SPLTV':
            name = 'Eksponensial';
            condition = (filteredListI[0].eksponensialScore +
                    filteredListI[1].eksponensialScore) /
                2;
            break;
          case 'Fungsi':
            name = 'SPLTV';
            condition =
                (filteredListI[0].spltvScore + filteredListI[1].spltvScore) / 2;
            break;
        }

        String trueLeaf = '';
        String falseLeaf = '';
        if (filteredListI[0].totalScore > filteredListI[1].totalScore) {
          trueLeaf = filteredListI[1].aljabarStrength;
          falseLeaf = filteredListI[0].aljabarStrength;
        } else {
          falseLeaf = filteredListI[1].aljabarStrength;
          trueLeaf = filteredListI[0].aljabarStrength;
        }

        return DecisionTreeEntity(
            name: name,
            condition: condition,
            giniT: 0,
            giniF: 0,
            giniTotal: 0,
            lemahT: 0,
            sedangT: 0,
            kuatT: 0,
            lemahF: 0,
            sedangF: 0,
            kuatF: 0,
            trueLeaf: trueLeaf,
            falseLeaf: falseLeaf,
            haveChild: false);
      } else {
        List<double> branchIAvrA = [];
        List<double> branchIAvrB = [];
        List<double> scoreOnA = [];
        List<double> scoreOnB = [];
        DecisionTreeEntity branchA;
        DecisionTreeEntity branchB;
        String nameA = '';
        String nameB = '';
        List<DecisionTreeEntity> branchListA = [];
        List<DecisionTreeEntity> branchListB = [];
        final preBranchA = List<UserDataEntity>.from(filteredListI);
        final preBranchB = List<UserDataEntity>.from(filteredListI);

        // Step 1: Identify Candidate Branch
        switch (root.name) {
          case 'Eksponensial':
            preBranchA.sort((a, b) => a.spltvScore.compareTo(b.spltvScore));
            preBranchB.sort((a, b) => a.fungsiScore.compareTo(b.fungsiScore));
            for (int i = 0; i < preBranchB.length; i++) {
              scoreOnA.add(preBranchA[i].spltvScore);
              scoreOnB.add(preBranchB[i].fungsiScore);
            }
            nameA = 'SPLTV';
            nameB = 'Fungsi';
            break;
          case 'SPLTV':
            preBranchA.sort(
                (a, b) => a.eksponensialScore.compareTo(b.eksponensialScore));
            preBranchB.sort((a, b) => a.fungsiScore.compareTo(b.fungsiScore));
            for (int i = 0; i < preBranchB.length; i++) {
              scoreOnA.add(preBranchA[i].eksponensialScore);
              scoreOnB.add(preBranchB[i].fungsiScore);
            }
            nameA = 'Eksponensial';
            nameB = 'Fungsi';
            break;
          case 'Fungsi':
            preBranchA.sort(
                (a, b) => a.eksponensialScore.compareTo(b.eksponensialScore));
            preBranchB.sort((a, b) => a.spltvScore.compareTo(b.spltvScore));
            for (int i = 0; i < preBranchB.length; i++) {
              scoreOnA.add(preBranchA[i].eksponensialScore);
              scoreOnB.add(preBranchB[i].spltvScore);
            }
            nameA = 'Eksponensial';
            nameB = 'SPLTV';
            break;
        }

        // Step 2: Count The Average of Each Candidate Branch
        for (int i = 0; i < preBranchA.length - 1; i++) {
          branchIAvrA.add((scoreOnA[i] + scoreOnA[i + 1]) / 2);
        }

        for (int i = 0; i < preBranchB.length - 1; i++) {
          branchIAvrB.add((scoreOnB[i] + scoreOnB[i + 1]) / 2);
        }

        // Step 3: Classificate Fundamental Based on Branches Candidate

        // A
        for (int i = 0; i < branchIAvrA.length; i++) {
          branchA = DecisionTreeEntity(
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

          for (int j = 0; j < scoreOnA.length; j++) {
            if (scoreOnA[j] <= branchIAvrA[i]) {
              switch (preBranchA[j].aljabarStrength) {
                case 'Kurang':
                  branchA.lemahT++;
                  break;
                case 'Sedang':
                  branchA.sedangT++;
                  break;
                case 'Tinggi':
                  branchA.kuatT++;
                  break;
              }
            } else {
              switch (preBranchA[j].aljabarStrength) {
                case 'Kurang':
                  branchA.lemahF++;
                  break;
                case 'Sedang':
                  branchA.sedangF++;
                  break;
                case 'Tinggi':
                  branchA.kuatF++;
                  break;
              }
            }
          }

          branchListA.add(branchA);
        }

        // B
        for (int i = 0; i < branchIAvrA.length; i++) {
          branchB = DecisionTreeEntity(
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

          for (int j = 0; j < scoreOnB.length; j++) {
            if (scoreOnB[j] <= branchIAvrB[i]) {
              switch (preBranchB[j].aljabarStrength) {
                case 'Kurang':
                  branchB.lemahT++;
                  break;
                case 'Sedang':
                  branchB.sedangT++;
                  break;
                case 'Tinggi':
                  branchB.kuatT++;
                  break;
              }
            } else {
              switch (preBranchB[j].aljabarStrength) {
                case 'Kurang':
                  branchB.lemahF++;
                  break;
                case 'Sedang':
                  branchB.sedangF++;
                  break;
                case 'Tinggi':
                  branchB.kuatF++;
                  break;
              }
            }
          }

          branchListB.add(branchB);
        }

        // Step 4: Count Gini for Each Average

        // A
        for (int i = 0; i < branchListA.length; i++) {
          final trueLemah = branchListA[i].lemahT;
          final trueSedang = branchListA[i].sedangT;
          final trueKuat = branchListA[i].kuatT;
          final total = trueLemah + trueSedang + trueKuat;
          final trueGini = 1 -
              pow((trueLemah / total), 2) -
              pow((trueSedang / total), 2) -
              pow((trueKuat / total), 2);

          final falseLemah = branchListA[i].lemahF;
          final falseSedang = branchListA[i].sedangF;
          final falseKuat = branchListA[i].kuatF;
          final falseTotal = falseLemah + falseSedang + falseKuat;
          final falseGini = 1 -
              pow((falseLemah / falseTotal), 2) -
              pow((falseSedang / falseTotal), 2) -
              pow((falseKuat / falseTotal), 2);

          branchListA[i].giniT = trueGini.toDouble();
          branchListA[i].giniF = falseGini.toDouble();
        }

        // B
        for (int i = 0; i < branchListB.length; i++) {
          final trueLemah = branchListB[i].lemahT;
          final trueSedang = branchListB[i].sedangT;
          final trueKuat = branchListB[i].kuatT;
          final total = trueLemah + trueSedang + trueKuat;
          final trueGini = 1 -
              pow((trueLemah / total), 2) -
              pow((trueSedang / total), 2) -
              pow((trueKuat / total), 2);

          final falseLemah = branchListB[i].lemahF;
          final falseSedang = branchListB[i].sedangF;
          final falseKuat = branchListB[i].kuatF;
          final falseTotal = falseLemah + falseSedang + falseKuat;
          final falseGini = 1 -
              pow((falseLemah / falseTotal), 2) -
              pow((falseSedang / falseTotal), 2) -
              pow((falseKuat / falseTotal), 2);

          branchListB[i].giniT = trueGini.toDouble();
          branchListB[i].giniF = falseGini.toDouble();
        }

        // Step 5: Count Total Gini from each average

        // A
        for (int i = 0; i < branchIAvrA.length; i++) {
          final trueTotal = branchListA[i].lemahT +
              branchListA[i].sedangT +
              branchListA[i].kuatT;
          final falseTotal = branchListA[i].lemahF +
              branchListA[i].sedangF +
              branchListA[i].kuatF;

          final total = trueTotal + falseTotal;
          final totalGini = ((trueTotal / total) * branchListA[i].giniT) +
              ((falseTotal / total) * branchListA[i].giniF);
          branchListA[i].giniTotal = totalGini;
        }

        // B
        for (int i = 0; i < branchIAvrB.length; i++) {
          final trueTotal = branchListB[i].lemahT +
              branchListB[i].sedangT +
              branchListB[i].kuatT;
          final falseTotal = branchListB[i].lemahF +
              branchListB[i].sedangF +
              branchListB[i].kuatF;

          final total = trueTotal + falseTotal;
          final totalGini = ((trueTotal / total) * branchListB[i].giniT) +
              ((falseTotal / total) * branchListB[i].giniF);
          branchListB[i].giniTotal = totalGini;
        }

        // Step 6: Branch I Deciding
        DecisionTreeEntity resultA = DecisionTreeEntity(
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
        DecisionTreeEntity resultB = DecisionTreeEntity(
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

        // A
        for (int i = 0; i < branchListA.length; i++) {
          final sortedGini = List<DecisionTreeEntity>.from(branchListA);
          sortedGini.sort((a, b) => a.giniTotal.compareTo(b.giniTotal));

          if (branchListA[i].giniTotal == sortedGini[0].giniTotal) {
            String leafF = '';
            String leafT = '';

            final lemahF = branchListA[i].lemahF;
            final sedangF = branchListA[i].sedangF;
            final kuatF = branchListA[i].kuatF;

            final lemahT = branchListA[i].lemahT;
            final sedangT = branchListA[i].sedangT;
            final kuatT = branchListA[i].kuatT;

            if (lemahF > sedangF && lemahF > kuatF) {
              leafF = 'Kurang';
            } else if (sedangF > lemahF && sedangF > kuatF) {
              leafF = 'Sedang';
            } else if (kuatF > lemahF && kuatF > sedangF) {
              leafF = 'Tinggi';
            } else {
              if (lemahF == sedangF) {
                leafF = 'Sedang';
              } else if (lemahF == kuatF) {
                leafF = 'Tinggi';
              } else {
                leafF = 'Tinggi';
              }
            }

            if (lemahT > sedangT && lemahT > kuatT) {
              leafT = 'Kurang';
            } else if (sedangT > lemahT && sedangT > kuatT) {
              leafT = 'Sedang';
            } else if (kuatT > lemahT && kuatT > sedangT) {
              leafT = 'Tinggi';
            } else {
              if (lemahT == sedangT) {
                leafT = 'Kurang';
              } else if (lemahT == kuatT) {
                leafT = 'Kurang';
              } else {
                leafT = 'Sedang';
              }
            }

            if (leafF == 'Kurang') {
              if (lemahF == sedangF) {
                leafF = 'Sedang';
              } else if (lemahF == kuatF) {
                leafF = 'Tinggi';
              }
            } else if (leafF == 'Sedang') {
              if (sedangF == kuatF) {
                leafF = 'Tinggi';
              }
            }

            resultA = DecisionTreeEntity(
              name: nameA,
              condition: branchIAvrA[i],
              giniT: branchListA[i].giniT,
              giniF: branchListA[i].giniF,
              giniTotal: branchListA[i].giniTotal,
              lemahT: branchListA[i].lemahT,
              sedangT: branchListA[i].sedangT,
              kuatT: branchListA[i].kuatT,
              trueLeaf: leafT,
              falseLeaf: leafF,
              haveChild: false,
              lemahF: branchListA[i].lemahF,
              sedangF: branchListA[i].sedangF,
              kuatF: branchListA[i].kuatF,
            );
            break;
          }
        }

        // B
        for (int i = 0; i < branchListA.length; i++) {
          final sortedGini = List<DecisionTreeEntity>.from(branchListB);
          sortedGini.sort((a, b) => a.giniTotal.compareTo(b.giniTotal));
          if (branchListB[i].giniTotal == sortedGini[0].giniTotal) {
            String leafF = '';
            String leafT = '';

            final lemahF = branchListB[i].lemahF;
            final sedangF = branchListB[i].sedangF;
            final kuatF = branchListB[i].kuatF;

            final lemahT = branchListB[i].lemahT;
            final sedangT = branchListB[i].sedangT;
            final kuatT = branchListB[i].kuatT;

            if (lemahF > sedangF && lemahF > kuatF) {
              leafF = 'Kurang';
            } else if (sedangF > lemahF && sedangF > kuatF) {
              leafF = 'Sedang';
            } else if (kuatF > lemahF && kuatF > sedangF) {
              leafF = 'Tinggi';
            } else {
              if (lemahF == sedangF) {
                leafF = 'Sedang';
              } else if (lemahF == kuatF) {
                leafF = 'Tinggi';
              } else {
                leafF = 'Tinggi';
              }
            }

            if (lemahT > sedangT && lemahT > kuatT) {
              leafT = 'Kurang';
            } else if (sedangT > lemahT && sedangT > kuatT) {
              leafT = 'Sedang';
            } else if (kuatT > lemahT && kuatT > sedangT) {
              leafT = 'Tinggi';
            } else {
              if (lemahT == sedangT) {
                leafT = 'Kurang';
              } else if (lemahT == kuatT) {
                leafT = 'Kurang';
              } else {
                leafT = 'Sedang';
              }
            }

            resultB = DecisionTreeEntity(
              name: nameB,
              condition: branchIAvrB[i],
              giniT: branchListB[i].giniT,
              giniF: branchListB[i].giniF,
              giniTotal: branchListB[i].giniTotal,
              lemahT: branchListB[i].lemahT,
              sedangT: branchListB[i].sedangT,
              kuatT: branchListB[i].kuatT,
              trueLeaf: leafT,
              falseLeaf: leafF,
              haveChild: false,
              lemahF: branchListB[i].lemahF,
              sedangF: branchListB[i].sedangF,
              kuatF: branchListB[i].kuatF,
            );
            break;
          }
        }

        if (resultA.giniTotal < resultB.giniTotal) {
          return resultA;
        } else {
          return resultB;
        }
      }
    }

    // Generate Branch II

    // Leaf Result
    DecisionTreeEntity leafResultII(String leaf) {
      final result = DecisionTreeEntity(
        name: leaf,
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
        haveChild: false,
      );

      return result;
    }

    // Branch Result
    DecisionTreeEntity branchResultII() {
      if (filteredListII.length == 2) {
        String name = '';
        double condition = 0;
        switch (root.name) {
          case 'Eksponensial':
            name = 'Fungsi';
            condition = (filteredListII[0].fungsiScore +
                    filteredListII[1].fungsiScore) /
                2;
            break;
          case 'SPLTV':
            name = 'Eksponensial';
            condition = (filteredListII[0].eksponensialScore +
                    filteredListII[1].eksponensialScore) /
                2;
            break;
          case 'Fungsi':
            name = 'SPLTV';
            condition =
                (filteredListII[0].spltvScore + filteredListII[1].spltvScore) /
                    2;
            break;
        }

        String trueLeaf = '';
        String falseLeaf = '';
        if (filteredListII[0].totalScore > filteredListII[1].totalScore) {
          trueLeaf = filteredListII[1].aljabarStrength;
          falseLeaf = filteredListII[0].aljabarStrength;
        } else {
          falseLeaf = filteredListII[1].aljabarStrength;
          trueLeaf = filteredListII[0].aljabarStrength;
        }

        return DecisionTreeEntity(
            name: name,
            condition: condition,
            giniT: 0,
            giniF: 0,
            giniTotal: 0,
            lemahT: 0,
            sedangT: 0,
            kuatT: 0,
            lemahF: 0,
            sedangF: 0,
            kuatF: 0,
            trueLeaf: trueLeaf,
            falseLeaf: falseLeaf,
            haveChild: false);
      } else {
        List<double> branchIIAvrA = [];
        List<double> branchIIAvrB = [];
        List<double> scoreOnA = [];
        List<double> scoreOnB = [];
        DecisionTreeEntity branchA;
        DecisionTreeEntity branchB;
        String nameA = '';
        String nameB = '';
        List<DecisionTreeEntity> branchListA = [];
        List<DecisionTreeEntity> branchListB = [];
        final preBranchA = List<UserDataEntity>.from(filteredListII);
        final preBranchB = List<UserDataEntity>.from(filteredListII);

        // Step 1: Identify Candidate Branch
        switch (root.name) {
          case 'Eksponensial':
            preBranchA.sort((a, b) => a.spltvScore.compareTo(b.spltvScore));
            preBranchB.sort((a, b) => a.fungsiScore.compareTo(b.fungsiScore));
            for (int i = 0; i < preBranchB.length; i++) {
              scoreOnA.add(preBranchA[i].spltvScore);
              scoreOnB.add(preBranchB[i].fungsiScore);
            }
            nameA = 'SPLTV';
            nameB = 'Fungsi';
            break;
          case 'SPLTV':
            preBranchA.sort(
                (a, b) => a.eksponensialScore.compareTo(b.eksponensialScore));
            preBranchB.sort((a, b) => a.fungsiScore.compareTo(b.fungsiScore));
            for (int i = 0; i < preBranchB.length; i++) {
              scoreOnA.add(preBranchA[i].eksponensialScore);
              scoreOnB.add(preBranchB[i].fungsiScore);
            }
            nameA = 'Eksponensial';
            nameB = 'Fungsi';
            break;
          case 'Fungsi':
            preBranchA.sort(
                (a, b) => a.eksponensialScore.compareTo(b.eksponensialScore));
            preBranchB.sort((a, b) => a.spltvScore.compareTo(b.spltvScore));
            for (int i = 0; i < preBranchB.length; i++) {
              scoreOnA.add(preBranchA[i].eksponensialScore);
              scoreOnB.add(preBranchB[i].spltvScore);
            }
            nameA = 'Eksponensial';
            nameB = 'SPLTV';
            break;
        }

        // Step 2: Count The Average of Each Candidate Branch
        for (int i = 0; i < preBranchA.length - 1; i++) {
          branchIIAvrA.add((scoreOnA[i] + scoreOnA[i + 1]) / 2);
        }

        for (int i = 0; i < preBranchB.length - 1; i++) {
          branchIIAvrB.add((scoreOnB[i] + scoreOnB[i + 1]) / 2);
        }

        // Step 3: Classificate Fundamental Based on Candidate Branches

        // A
        for (int i = 0; i < branchIIAvrA.length; i++) {
          branchA = DecisionTreeEntity(
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

          for (int j = 0; j < scoreOnA.length; j++) {
            if (scoreOnA[j] <= branchIIAvrA[i]) {
              switch (preBranchA[j].aljabarStrength) {
                case 'Kurang':
                  branchA.lemahT++;
                  break;
                case 'Sedang':
                  branchA.sedangT++;
                  break;
                case 'Tinggi':
                  branchA.kuatT++;
                  break;
              }
            } else {
              switch (preBranchA[j].aljabarStrength) {
                case 'Kurang':
                  branchA.lemahF++;
                  break;
                case 'Sedang':
                  branchA.sedangF++;
                  break;
                case 'Tinggi':
                  branchA.kuatF++;
                  break;
              }
            }
          }

          branchListA.add(branchA);
        }

        // B
        for (int i = 0; i < branchIIAvrA.length; i++) {
          branchB = DecisionTreeEntity(
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

          for (int j = 0; j < scoreOnB.length; j++) {
            if (scoreOnB[j] <= branchIIAvrB[i]) {
              switch (preBranchB[j].aljabarStrength) {
                case 'Kurang':
                  branchB.lemahT++;
                  break;
                case 'Sedang':
                  branchB.sedangT++;
                  break;
                case 'Tinggi':
                  branchB.kuatT++;
                  break;
              }
            } else {
              switch (preBranchB[j].aljabarStrength) {
                case 'Kurang':
                  branchB.lemahF++;
                  break;
                case 'Sedang':
                  branchB.sedangF++;
                  break;
                case 'Tinggi':
                  branchB.kuatF++;
                  break;
              }
            }
          }

          branchListB.add(branchB);
        }

        // Step 4: Count Gini for Each Average

        // A
        for (int i = 0; i < branchListA.length; i++) {
          final trueLemah = branchListA[i].lemahT;
          final trueSedang = branchListA[i].sedangT;
          final trueKuat = branchListA[i].kuatT;
          final total = trueLemah + trueSedang + trueKuat;
          final trueGini = 1 -
              pow((trueLemah / total), 2) -
              pow((trueSedang / total), 2) -
              pow((trueKuat / total), 2);

          final falseLemah = branchListA[i].lemahF;
          final falseSedang = branchListA[i].sedangF;
          final falseKuat = branchListA[i].kuatF;
          final falseTotal = falseLemah + falseSedang + falseKuat;
          final falseGini = 1 -
              pow((falseLemah / falseTotal), 2) -
              pow((falseSedang / falseTotal), 2) -
              pow((falseKuat / falseTotal), 2);

          branchListA[i].giniT = trueGini.toDouble();
          branchListA[i].giniF = falseGini.toDouble();
        }

        // B
        for (int i = 0; i < branchListB.length; i++) {
          final trueLemah = branchListB[i].lemahT;
          final trueSedang = branchListB[i].sedangT;
          final trueKuat = branchListB[i].kuatT;
          final total = trueLemah + trueSedang + trueKuat;
          final trueGini = 1 -
              pow((trueLemah / total), 2) -
              pow((trueSedang / total), 2) -
              pow((trueKuat / total), 2);

          final falseLemah = branchListB[i].lemahF;
          final falseSedang = branchListB[i].sedangF;
          final falseKuat = branchListB[i].kuatF;
          final falseTotal = falseLemah + falseSedang + falseKuat;
          final falseGini = 1 -
              pow((falseLemah / falseTotal), 2) -
              pow((falseSedang / falseTotal), 2) -
              pow((falseKuat / falseTotal), 2);

          branchListB[i].giniT = trueGini.toDouble();
          branchListB[i].giniF = falseGini.toDouble();
        }

        // Step 5: Count Total Gini from each average

        // A
        for (int i = 0; i < branchIIAvrA.length; i++) {
          final trueTotal = branchListA[i].lemahT +
              branchListA[i].sedangT +
              branchListA[i].kuatT;
          final falseTotal = branchListA[i].lemahF +
              branchListA[i].sedangF +
              branchListA[i].kuatF;

          final total = trueTotal + falseTotal;
          final totalGini = ((trueTotal / total) * branchListA[i].giniT) +
              ((falseTotal / total) * branchListA[i].giniF);
          branchListA[i].giniTotal = totalGini;
        }

        // B
        for (int i = 0; i < branchIIAvrB.length; i++) {
          final trueTotal = branchListB[i].lemahT +
              branchListB[i].sedangT +
              branchListB[i].kuatT;
          final falseTotal = branchListB[i].lemahF +
              branchListB[i].sedangF +
              branchListB[i].kuatF;

          final total = trueTotal + falseTotal;
          final totalGini = ((trueTotal / total) * branchListB[i].giniT) +
              ((falseTotal / total) * branchListB[i].giniF);
          branchListB[i].giniTotal = totalGini;
        }

        // Step 6: Branch I Deciding
        DecisionTreeEntity resultA = DecisionTreeEntity(
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
        DecisionTreeEntity resultB = DecisionTreeEntity(
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

        // A
        for (int i = 0; i < branchListA.length; i++) {
          final sortedGini = List<DecisionTreeEntity>.from(branchListA);
          sortedGini.sort((a, b) => a.giniTotal.compareTo(b.giniTotal));
          if (branchListA[i].giniTotal == sortedGini[0].giniTotal) {
            String leafF = '';
            String leafT = '';

            final lemahF = branchListA[i].lemahF;
            final sedangF = branchListA[i].sedangF;
            final kuatF = branchListA[i].kuatF;

            final lemahT = branchListA[i].lemahT;
            final sedangT = branchListA[i].sedangT;
            final kuatT = branchListA[i].kuatT;

            if (lemahF > sedangF && lemahF > kuatF) {
              leafF = 'Kurang';
            } else if (sedangF > lemahF && sedangF > kuatF) {
              leafF = 'Sedang';
            } else if (kuatF > lemahF && kuatF > sedangF) {
              leafF = 'Tinggi';
            } else {
              if (lemahF == sedangF) {
                leafF = 'Sedang';
              } else if (lemahF == kuatF) {
                leafF = 'Tinggi';
              } else {
                leafF = 'Tinggi';
              }
            }

            if (lemahT > sedangT && lemahT > kuatT) {
              leafT = 'Kurang';
            } else if (sedangT > lemahT && sedangT > kuatT) {
              leafT = 'Sedang';
            } else if (kuatT > lemahT && kuatT > sedangT) {
              leafT = 'Tinggi';
            } else {
              if (lemahT == sedangT) {
                leafT = 'Kurang';
              } else if (lemahT == kuatT) {
                leafT = 'Kurang';
              } else {
                leafT = 'Sedang';
              }
            }

            resultA = DecisionTreeEntity(
              name: nameA,
              condition: branchIIAvrA[i],
              giniT: branchListA[i].giniT,
              giniF: branchListA[i].giniF,
              giniTotal: branchListA[i].giniTotal,
              lemahT: branchListA[i].lemahT,
              sedangT: branchListA[i].sedangT,
              kuatT: branchListA[i].kuatT,
              trueLeaf: leafT,
              falseLeaf: leafF,
              haveChild: false,
              lemahF: branchListA[i].lemahF,
              sedangF: branchListA[i].sedangF,
              kuatF: branchListA[i].kuatF,
            );
            break;
          }
        }

        // B
        for (int i = 0; i < branchListA.length; i++) {
          final sortedGini = List<DecisionTreeEntity>.from(branchListB);
          sortedGini.sort((a, b) => a.giniTotal.compareTo(b.giniTotal));
          if (branchListB[i].giniTotal == sortedGini[0].giniTotal) {
            String leafF = '';
            String leafT = '';

            final lemahF = branchListB[i].lemahF;
            final sedangF = branchListB[i].sedangF;
            final kuatF = branchListB[i].kuatF;

            final lemahT = branchListB[i].lemahT;
            final sedangT = branchListB[i].sedangT;
            final kuatT = branchListB[i].kuatT;

            if (lemahF > sedangF && lemahF > kuatF) {
              leafF = 'Kurang';
            } else if (sedangF > lemahF && sedangF > kuatF) {
              leafF = 'Sedang';
            } else if (kuatF > lemahF && kuatF > sedangF) {
              leafF = 'Tinggi';
            } else {
              if (lemahF == sedangF) {
                leafF = 'Sedang';
              } else if (lemahF == kuatF) {
                leafF = 'Tinggi';
              } else {
                leafF = 'Tinggi';
              }
            }

            if (lemahT > sedangT && lemahT > kuatT) {
              leafT = 'Kurang';
            } else if (sedangT > lemahT && sedangT > kuatT) {
              leafT = 'Sedang';
            } else if (kuatT > lemahT && kuatT > sedangT) {
              leafT = 'Tinggi';
            } else {
              if (lemahT == sedangT) {
                leafT = 'Kurang';
              } else if (lemahT == kuatT) {
                leafT = 'Kurang';
              } else {
                leafT = 'Sedang';
              }
            }

            print(filteredListII.length);
            print('Score: $scoreOnB');
            print('avr: $branchIIAvrB');

            resultB = DecisionTreeEntity(
              name: nameB,
              condition: branchIIAvrB[i],
              giniT: branchListB[i].giniT,
              giniF: branchListB[i].giniF,
              giniTotal: branchListB[i].giniTotal,
              lemahT: branchListB[i].lemahT,
              sedangT: branchListB[i].sedangT,
              kuatT: branchListB[i].kuatT,
              trueLeaf: leafT,
              falseLeaf: leafF,
              haveChild: false,
              lemahF: branchListB[i].lemahF,
              sedangF: branchListB[i].sedangF,
              kuatF: branchListB[i].kuatF,
            );
            break;
          }
        }

        if (resultA.giniTotal < resultB.giniTotal) {
          return resultA;
        } else {
          return resultB;
        }
      }
    }

    // Final Step: Decide The Result is Leaf or Branch

    // Result I
    if (isPureI == true) {
      resultI = leafResultI(filteredListI[0].aljabarStrength);
    } else {
      resultI = branchResultI();
    }

    // Result II
    if (isPureII == true) {
      resultII = leafResultII(filteredListII[0].aljabarStrength);
    } else {
      resultII = branchResultII();
    }

    branches.add(root);
    branches.add(resultI);
    branches.add(resultII);

    return branches;
  }
}
