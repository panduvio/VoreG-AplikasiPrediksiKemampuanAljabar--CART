import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/constants/app_colors.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/presentation/providers/bloc/user_bloc.dart';

class AdminAddDataPage extends StatefulWidget {
  const AdminAddDataPage({super.key});

  @override
  State<AdminAddDataPage> createState() => _AdminAddDataPageState();
}

class _AdminAddDataPageState extends State<AdminAddDataPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController eksponensialController = TextEditingController();
  TextEditingController spltvController = TextEditingController();
  TextEditingController fungsiController = TextEditingController();
  late SharedPreferences userSp;
  int? id;
  late int idDb;

  @override
  void initState() {
    initial();
    super.initState();
  }

  void initial() async {
    userSp = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  fontSize: 16,
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
                  fontSize: 16,
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
                  fontSize: 16,
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
                  fontSize: 16,
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
                context.read<UserBloc>().add(GetAllUser());

                final eksponensialScore =
                    double.parse(eksponensialController.text);
                final spltvScore = double.parse(spltvController.text);
                final fungsiScore = double.parse(fungsiController.text);
                final totalScore =
                    (eksponensialScore + spltvScore + fungsiScore) / 3;

                // final id = userSp.getInt('id');
                if (state is GetAllSuccessState && state.users.isNotEmpty) {
                  id = state.users[state.users.length - 1].id;
                  final userData = UserDataEntity(
                    id: id! + 1,
                    name: nameController.text,
                    eksponensialScore: eksponensialScore,
                    fungsiScore: fungsiScore,
                    spltvScore: spltvScore,
                    totalScore: totalScore,
                    aljabarStrength: totalScore < 70
                        ? 'Kurang'
                        : (totalScore < 85 ? 'Sedang' : 'Tinggi'),
                  );

                  context.read<UserBloc>().add(PostUser(userData: userData));
                  setState(() {
                    nameController.text = '';
                    eksponensialController.text = '';
                    spltvController.text = '';
                    fungsiController.text = '';
                  });
                } else {
                  final userData = UserDataEntity(
                    id: 0,
                    name: nameController.text,
                    eksponensialScore: eksponensialScore,
                    fungsiScore: fungsiScore,
                    spltvScore: spltvScore,
                    totalScore: totalScore,
                    aljabarStrength: totalScore < 70
                        ? 'Kurang'
                        : (totalScore < 85 ? 'Sedang' : 'Tinggi'),
                  );

                  context.read<UserBloc>().add(PostUser(userData: userData));
                  setState(() {
                    nameController.text = '';
                    eksponensialController.text = '';
                    spltvController.text = '';
                    fungsiController.text = '';
                  });
                }
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
                  'Add',
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
    );
  }
}
