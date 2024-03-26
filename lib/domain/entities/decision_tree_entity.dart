import 'dart:math';

class DecisionTreeEntity {
  final String name;
  double giniTotal;
  double giniT;
  double giniF;
  final double condition;
  int lemahT;
  int sedangT;
  int kuatT;
  int lemahF;
  int sedangF;
  int kuatF;
  final String trueLeaf;
  final String falseLeaf;
  final bool haveChild;

  DecisionTreeEntity({
    required this.name,
    required this.condition,
    required this.giniT,
    required this.giniF,
    required this.giniTotal,
    required this.lemahT,
    required this.sedangT,
    required this.kuatT,
    required this.lemahF,
    required this.sedangF,
    required this.kuatF,
    required this.trueLeaf,
    required this.falseLeaf,
    required this.haveChild,
  });

  num countGini() {
    final result = 1 -
        pow((lemahT / (lemahT + sedangT + kuatT)), 2) -
        pow((sedangT / (lemahT + sedangT + kuatT)), 2) -
        pow((kuatT / (lemahT + sedangT + kuatT)), 2);
    final double fResult = double.parse(result.toString());
    return fResult;
  }
}
