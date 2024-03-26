import 'package:flutter/material.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';

class UserProvider extends ChangeNotifier {
  UserDataEntity _user = UserDataEntity(
    id: 0,
    name: '',
    eksponensialScore: 0,
    fungsiScore: 0,
    spltvScore: 0,
    totalScore: 0,
    aljabarStrength: '',
  );

  List<String> _bidangList = [];

  List<String> get bidangList => _bidangList;

  List<UserDataEntity> _users = [];

  List<UserDataEntity> get users => _users;

  void updateBidangList(List<String> newBidang) {
    _bidangList = newBidang;
    notifyListeners();
  }

  void updateUsers(List<UserDataEntity> newUsers) {
    _users = newUsers;
    notifyListeners();
  }

  UserDataEntity get user => _user;
  void updateUser(UserDataEntity newUser) {
    _user = newUser;
    notifyListeners();
  }

  void updateUserFundamental(String fundamental) {
    _user.aljabarStrength = fundamental;
    notifyListeners();
  }

  void updateUserName(String name) {
    _user.name = _user.name + name;
    notifyListeners();
  }

  void updateUserEksponensial(double eksponensial) {
    eksponensial = ((eksponensial / 2) / 3) * 100;
    if (eksponensial > 100) {
      eksponensial = 100;
    }
    _user.eksponensialScore = double.parse(
        (_user.eksponensialScore + eksponensial).toStringAsFixed(2));
    notifyListeners();
  }

  void updateUserSPLTV(double spltv) {
    spltv = ((spltv / 2) / 3) * 100;
    if (spltv > 100) {
      spltv = 100;
    }
    _user.spltvScore =
        double.parse((_user.spltvScore + spltv).toStringAsFixed(2));
    notifyListeners();
  }

  void updateUserFungsi(double fungsi) {
    fungsi = ((fungsi / 2) / 3) * 100;
    if (fungsi > 100.00) {
      fungsi = 100;
    }
    _user.fungsiScore =
        double.parse((_user.fungsiScore + fungsi).toStringAsFixed(2));
    notifyListeners();
  }

  // void updateUserTotalScore() {
  //   _user.totalScore =
  //       _user.eksponensialScore + _user.spltvScore + _user.fungsiScore;

  //   final total = _user.totalScore;
  //   if (total > 87) {
  //     _user.aljabarStrength = 'kuat';
  //   } else if (total > 78) {
  //     _user.aljabarStrength = 'sedang';
  //   } else {
  //     _user.aljabarStrength = 'kurang';
  //   }
  //   notifyListeners();
  // }
}
