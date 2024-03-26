import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/constants/app_colors.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/presentation/providers/bloc/user_bloc.dart';

class AdminUpdateScreen extends StatefulWidget {
  final UserDataEntity userData;
  const AdminUpdateScreen({required this.userData, super.key});

  @override
  State<AdminUpdateScreen> createState() =>
      _AdminUpdateScreenState(userData: userData);
}

class _AdminUpdateScreenState extends State<AdminUpdateScreen> {
  final UserDataEntity userData;
  TextEditingController nameController = TextEditingController();
  TextEditingController eksponensialController = TextEditingController();
  TextEditingController spltvController = TextEditingController();
  TextEditingController fungsiController = TextEditingController();
  late SharedPreferences userSp;
  int? id;
  late int idDb;

  _AdminUpdateScreenState({required this.userData});

  @override
  void initState() {
    initial();
    nameController.text = userData.name;
    eksponensialController.text = userData.eksponensialScore.toString();
    spltvController.text = userData.spltvScore.toString();
    fungsiController.text = userData.fungsiScore.toString();
    super.initState();
  }

  void initial() async {
    userSp = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: AppColor().iceColdStare,
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(30),
                height: 130,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      AppColor().spaceBattleBlue,
                      Colors.blue,
                    ],
                  ),
                ),
                child: const Text(
                  'Update User Data',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                color: AppColor().iceColdStare,
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Input name',
                        label: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: eksponensialController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Input eksponensial score',
                        label: Text(
                          'Eksponensial Score',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: spltvController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Input spltv score',
                        label: Text(
                          'SPLTV Score',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: fungsiController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Input fungsi score',
                        label: Text(
                          'Fungsi Score',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                      return InkWell(
                        onTapDown: (details) {},
                        onTapUp: (details) {
                          final eksponensialScore =
                              double.parse(eksponensialController.text);
                          final spltvScore = double.parse(spltvController.text);
                          final fungsiScore =
                              double.parse(fungsiController.text);
                          final totalScore =
                              (eksponensialScore + spltvScore + fungsiScore) /
                                  3;
                          final user = UserDataEntity(
                            id: userData.id,
                            name: nameController.text,
                            eksponensialScore: eksponensialScore,
                            fungsiScore: fungsiScore,
                            spltvScore: spltvScore,
                            totalScore: totalScore,
                            aljabarStrength: totalScore < 70
                                ? 'Kurang'
                                : (totalScore < 85 ? 'Sedang' : 'Tinggi'),
                          );

                          context
                              .read<UserBloc>()
                              .add(UpdateUser(userData: user));
                          setState(() {
                            nameController.text = '';
                            eksponensialController.text = '';
                            spltvController.text = '';
                            fungsiController.text = '';
                          });

                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.blue,
                              ],
                            ),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
