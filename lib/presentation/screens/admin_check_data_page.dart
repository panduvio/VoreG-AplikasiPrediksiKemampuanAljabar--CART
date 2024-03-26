import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/constants/app_colors.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/presentation/providers/bloc/user_bloc.dart';
import 'package:skripsi/presentation/screens/admin_update_screen.dart';

class AdminCheckDataPage extends StatefulWidget {
  const AdminCheckDataPage({super.key});

  @override
  State<AdminCheckDataPage> createState() => _AdminCheckDataPageState();
}

class _AdminCheckDataPageState extends State<AdminCheckDataPage> {
  int tapDownIndex = 0;
  int idDb = 0;
  double total = 260;
  List<UserDataEntity> users = [];
  late SharedPreferences userSp;

  @override
  void initState() {
    initial();
    context.read<UserBloc>().add(GetAllUser());

    super.initState();
  }

  void initial() async {
    userSp = await SharedPreferences.getInstance();
  }

  double eksponensialPrecentage(double precentage) {
    double length = precentage * total / 100;
    return length;
  }

  double spltvPrecentage(double precentage) {
    double length = precentage * total / 100;
    return length;
  }

  double fungsiPrecentage(double precentage) {
    double length = precentage * total / 100;
    return length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColor().iceColdStare,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          //
          if (state is GetAllSuccessState && state.users.isNotEmpty) {
            users = state.users;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = users[index];
                  return Container(
                    padding: const EdgeInsets.all(1),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          AppColor().caribbeanGreen,
                        ],
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white),
                      child: ExpansionTile(
                        childrenPadding: const EdgeInsets.all(20),
                        title: Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        shape: Border.all(style: BorderStyle.none),
                        trailing: const HeroIcon(HeroIcons.chevronDown),
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Eksponensial',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 10,
                                  width: total,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColor().caribbeanGreen,
                                    ),
                                    color: const Color.fromARGB(
                                        255, 215, 215, 215),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: eksponensialPrecentage(
                                                user.eksponensialScore) -
                                            2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor().tardisBlue,
                                              Colors.blue,
                                              Colors.cyan,
                                              const Color.fromARGB(
                                                  255, 0, 212, 159),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  '${user.eksponensialScore.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'SPLTV',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 10,
                                  width: total,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColor().caribbeanGreen,
                                    ),
                                    color: const Color.fromARGB(
                                        255, 215, 215, 215),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            spltvPrecentage(user.spltvScore) -
                                                2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor().tardisBlue,
                                              Colors.blue,
                                              Colors.cyan,
                                              const Color.fromARGB(
                                                  255, 0, 212, 159),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  '${user.spltvScore.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Fungsi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 10,
                                  width: total,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColor().caribbeanGreen,
                                    ),
                                    color: const Color.fromARGB(
                                        255, 215, 215, 215),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            fungsiPrecentage(user.fungsiScore) -
                                                2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor().tardisBlue,
                                              Colors.blue,
                                              Colors.cyan,
                                              const Color.fromARGB(
                                                  255, 0, 212, 159),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  '${user.fungsiScore.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Rata-rata nilai: ${user.totalScore.toStringAsFixed(2)} (${user.aljabarStrength})',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<UserBloc>()
                                        .add(RemoveThisUser(id: user.id));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          AppColor().moltenLava,
                                          AppColor().shojohiRed,
                                          AppColor().sunsetOrange,
                                        ],
                                      ),
                                    ),
                                    child: const HeroIcon(
                                      HeroIcons.trash,
                                      size: 34,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AdminUpdateScreen(
                                            userData: user,
                                          ),
                                        ));

                                    // Provider.of<UserProvider>(context,
                                    //         listen: false)
                                    //     .updateUsers(users);

                                    // context
                                    //     .read<BranchBloc>()
                                    //     .add(GenerateRoot(userList: users));
                                    //     if(state is SuccessGenerateRoot){
                                    //       final root = state
                                    //     }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          AppColor().caribbeanGreen,
                                          Colors.green,
                                        ],
                                      ),
                                    ),
                                    child: const HeroIcon(
                                      HeroIcons.pencilSquare,
                                      size: 34,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            // userSp.setInt('id', 0);
            return Container(
              alignment: Alignment.center,
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'There\'s no data available yet\nPlease input data first',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTapDown: (details) {
                          setState(() {
                            tapDownIndex = 1;
                          });
                        },
                        onTapUp: (details) {
                          setState(() {
                            tapDownIndex = 0;
                          });
                          final userListFromLocal =
                              List<UserDataEntity>.from(cleanUserData);
                          for (int i = 0; i < userListFromLocal.length; i++) {
                            context
                                .read<UserBloc>()
                                .add(PostUser(userData: userListFromLocal[i]));
                          }
                          context.read<UserBloc>().add(GetAllUser());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          height: 58,
                          width: 140,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.blue,
                                AppColor().caribbeanGreen,
                              ],
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: double.maxFinite,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  tapDownIndex == 1
                                      ? Colors.blue
                                      : AppColor().iceColdStare,
                                  tapDownIndex == 1
                                      ? AppColor().caribbeanGreen
                                      : AppColor().iceColdStare,
                                ],
                              ),
                            ),
                            child: Text(
                              'Import Data',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: tapDownIndex != 1
                                    ? Colors.black
                                    : AppColor().iceColdStare,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Text(
                            'or',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Text(
                            'Add some data',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
