class UserDataEntity {
  late int id;
  late String name;
  late double eksponensialScore;
  late double spltvScore;
  late double fungsiScore;
  late double totalScore;
  late String aljabarStrength;

  UserDataEntity({
    required this.id,
    required this.name,
    required this.eksponensialScore,
    required this.spltvScore,
    required this.fungsiScore,
    required this.totalScore,
    required this.aljabarStrength,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'eksponensialScore': eksponensialScore,
      'spltvScore': spltvScore,
      'fungsiScore': fungsiScore,
      'totalScore': totalScore,
      'aljabarStrength': aljabarStrength,
    };
  }

  UserDataEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    eksponensialScore = map['eksponensialScore'];
    spltvScore = map['spltvScore'];
    fungsiScore = map['fungsiScore'];
    totalScore = map['totalScore'];
    aljabarStrength = map['aljabarStrength'];
  }
}

List<UserDataEntity> cleanUserData = [
  UserDataEntity(
    id: 0,
    name: 'Auzul',
    eksponensialScore: 66.77,
    spltvScore: 66.67,
    fungsiScore: 50,
    totalScore: 61.11,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 1,
    name: 'Arne',
    eksponensialScore: 66.67,
    spltvScore: 83.33,
    fungsiScore: 83.33,
    totalScore: 77.78,
    aljabarStrength: 'Sedang',
  ),
  UserDataEntity(
    id: 2,
    name: 'Iqbal',
    eksponensialScore: 66.67,
    spltvScore: 100,
    fungsiScore: 100,
    totalScore: 88.89,
    aljabarStrength: 'Tinggi',
  ),
  UserDataEntity(
    id: 3,
    name: 'Kheysa',
    eksponensialScore: 66.67,
    spltvScore: 66.67,
    fungsiScore: 50,
    totalScore: 61.11,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 4,
    name: 'Amelia',
    eksponensialScore: 50,
    spltvScore: 66.67,
    fungsiScore: 33.33,
    totalScore: 50,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 5,
    name: 'Marcellia',
    eksponensialScore: 66.67,
    spltvScore: 66.67,
    fungsiScore: 66.67,
    totalScore: 66.67,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 6,
    name: 'Keira',
    eksponensialScore: 100,
    spltvScore: 100,
    fungsiScore: 50,
    totalScore: 83.33,
    aljabarStrength: 'Sedang',
  ),
  UserDataEntity(
    id: 7,
    name: 'Hasna',
    eksponensialScore: 66.67,
    spltvScore: 66.67,
    fungsiScore: 66.67,
    totalScore: 66.67,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 8,
    name: 'Fadel',
    eksponensialScore: 83.33,
    spltvScore: 66.67,
    fungsiScore: 50,
    totalScore: 66.67,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 9,
    name: 'Ayyiza',
    eksponensialScore: 66.67,
    spltvScore: 66.67,
    fungsiScore: 50,
    totalScore: 61.11,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 10,
    name: 'Dashura',
    eksponensialScore: 66.77,
    spltvScore: 66.67,
    fungsiScore: 50,
    totalScore: 61.11,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 11,
    name: 'Adam',
    eksponensialScore: 66.67,
    spltvScore: 100,
    fungsiScore: 66.67,
    totalScore: 77.78,
    aljabarStrength: 'Sedang',
  ),
  UserDataEntity(
    id: 12,
    name: 'Faizin',
    eksponensialScore: 100,
    spltvScore: 100,
    fungsiScore: 50,
    totalScore: 83.33,
    aljabarStrength: 'Sedang',
  ),
  UserDataEntity(
    id: 13,
    name: 'Binnadhifah',
    eksponensialScore: 66.67,
    spltvScore: 66.67,
    fungsiScore: 33.33,
    totalScore: 55.56,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 14,
    name: 'Bunga',
    eksponensialScore: 100,
    spltvScore: 100,
    fungsiScore: 66.67,
    totalScore: 88.89,
    aljabarStrength: 'Tinggi',
  ),
  UserDataEntity(
    id: 15,
    name: 'Talitha',
    eksponensialScore: 66.67,
    spltvScore: 66.67,
    fungsiScore: 66.67,
    totalScore: 66.67,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 16,
    name: 'Arla',
    eksponensialScore: 33.33,
    spltvScore: 83.33,
    fungsiScore: 33.33,
    totalScore: 50,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 17,
    name: 'Dzikrul',
    eksponensialScore: 66.67,
    spltvScore: 66.67,
    fungsiScore: 50,
    totalScore: 61.11,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 18,
    name: 'Nabil',
    eksponensialScore: 66.67,
    spltvScore: 66.67,
    fungsiScore: 50,
    totalScore: 61.11,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 19,
    name: 'Alya',
    eksponensialScore: 66.67,
    spltvScore: 83.33,
    fungsiScore: 50,
    totalScore: 66.67,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 20,
    name: 'Keenar',
    eksponensialScore: 66.77,
    spltvScore: 83.33,
    fungsiScore: 33.33,
    totalScore: 61.11,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 21,
    name: 'Alijibril',
    eksponensialScore: 50,
    spltvScore: 83.33,
    fungsiScore: 33.33,
    totalScore: 55.56,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 22,
    name: 'Yuan',
    eksponensialScore: 33.33,
    spltvScore: 78.39,
    fungsiScore: 50,
    totalScore: 53.91,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 23,
    name: 'Noval',
    eksponensialScore: 50,
    spltvScore: 66.67,
    fungsiScore: 51.78,
    totalScore: 56.15,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 24,
    name: 'Agastya',
    eksponensialScore: 64.81,
    spltvScore: 83.33,
    fungsiScore: 33.33,
    totalScore: 60.5,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 25,
    name: 'Raisyanova',
    eksponensialScore: 64.81,
    spltvScore: 100,
    fungsiScore: 50,
    totalScore: 71.61,
    aljabarStrength: 'Sedang',
  ),
  UserDataEntity(
    id: 26,
    name: 'Najla',
    eksponensialScore: 64.81,
    spltvScore: 83.33,
    fungsiScore: 50,
    totalScore: 66.05,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 27,
    name: 'Anjalu',
    eksponensialScore: 50,
    spltvScore: 66.67,
    fungsiScore: 51.78,
    totalScore: 56.15,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 28,
    name: 'Elang',
    eksponensialScore: 50,
    spltvScore: 78.39,
    fungsiScore: 33.33,
    totalScore: 53.91,
    aljabarStrength: 'Kurang',
  ),
  UserDataEntity(
    id: 29,
    name: 'Bintang',
    eksponensialScore: 50,
    spltvScore: 78.39,
    fungsiScore: 50,
    totalScore: 59.47,
    aljabarStrength: 'Kurang',
  ),
];
