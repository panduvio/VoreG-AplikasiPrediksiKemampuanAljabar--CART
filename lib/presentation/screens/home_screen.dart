import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/constants/app_colors.dart';
import 'package:skripsi/domain/entities/decision_tree_entity.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/presentation/providers/bloc/predict_bloc.dart';
import 'package:skripsi/presentation/providers/bloc/user_bloc.dart';
import 'package:skripsi/presentation/providers/user_provider.dart';
import 'package:skripsi/presentation/screens/login_screen.dart';
import 'package:skripsi/presentation/screens/predict_screen.dart';
import 'package:skripsi/presentation/screens/result_popup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DecisionTreeEntity root;
  List<DecisionTreeEntity> branches = [];
  List<UserDataEntity> userList = [];
  bool isPredictable = false;
  int buttonIndex = 0;
  String username = '';
  late SharedPreferences userSp;

  initial() async {
    userSp = await SharedPreferences.getInstance();
    setState(() {
      username = userSp.getString('user')!;
    });
  }

  @override
  void initState() {
    initial();
    context.read<UserBloc>().add(GetAllUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
        if (userState is GetAllSuccessState && userState.users.isNotEmpty) {
          userList = userState.users;
        } else {
          userList = List.from(cleanUserData);
        }
        return BlocBuilder<PredictBloc, PredictState>(
            builder: (context, predictState) {
          if (userState is GetAllSuccessState) {
            context.read<PredictBloc>().add(GenerateRoot(userList: userList));
          }

          if (predictState is SuccessGenerateRoot) {
            root = predictState.root;
            context
                .read<PredictBloc>()
                .add(GenerateBranch(userList: userList, root: root));
          }

          if (predictState is SuccessGenerateBranch) {
            branches = predictState.branches;
          }

          return Center(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: AppColor().iceColdStare,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 160,
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
                    child: Text(
                      'Hello, $username !!',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          'About This App',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 4,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                AppColor().spaceBattleBlue,
                                Colors.blue,
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                  CarouselSlider(
                    items: [
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.blue, AppColor().caribbeanGreen],
                          ),
                        ),
                        child: Image.asset('assets/slider1.png'),
                      ),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.blue, AppColor().caribbeanGreen],
                          ),
                        ),
                        child: Image.asset('assets/slider2.png'),
                      ),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.blue, AppColor().caribbeanGreen],
                          ),
                        ),
                        child: Image.asset('assets/slider3.png'),
                      ),
                    ],
                    options: CarouselOptions(
                      autoPlay: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // InkWell(
                        //   onTapDown: (details) {
                        //     setState(() {
                        //       buttonIndex = 1;
                        //     });
                        //   },
                        //   onTapUp: (details) {
                        //     setState(() {
                        //       buttonIndex = 0;
                        //     });
                        //     Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => const QuizScreen(),
                        //         ));
                        //   },
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     height: 60,
                        //     width: double.maxFinite,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(18),
                        //       color: buttonIndex == 1
                        //           ? const Color.fromARGB(255, 91, 179, 251)
                        //           : Colors.blue,
                        //     ),
                        //     child: const Row(
                        //       children: [
                        //         Padding(
                        //           padding: EdgeInsets.symmetric(horizontal: 20),
                        //           child: SizedBox(
                        //             child: HeroIcon(
                        //               HeroIcons.academicCap,
                        //               size: 40,
                        //               color: Colors.white,
                        //             ),
                        //           ),
                        //         ),
                        //         Text(
                        //           'Start Quiz',
                        //           style: TextStyle(
                        //               fontSize: 26,
                        //               fontWeight: FontWeight.w500,
                        //               color: Colors.white),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTapDown: (details) {
                            setState(() {
                              buttonIndex = 2;
                            });
                          },
                          onTapUp: (details) {
                            userSp.setString('recommendation', '');
                            Provider.of<UserProvider>(context, listen: false)
                                .updateUser(
                              UserDataEntity(
                                id: 0,
                                name: username,
                                eksponensialScore: 0,
                                spltvScore: 0,
                                fungsiScore: 0,
                                totalScore: 0,
                                aljabarStrength: '',
                              ),
                            );
                            setState(() {
                              buttonIndex = 0;
                            });

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PredictScreen(
                                    userList: userList,
                                    branches: branches,
                                  ),
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: buttonIndex == 2
                                  ? const Color.fromARGB(255, 91, 179, 251)
                                  : Colors.blue,
                            ),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: SizedBox(
                                    child: HeroIcon(
                                      HeroIcons.scale,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Predict Your Skill',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTapDown: (details) {
                            setState(() {
                              buttonIndex = 3;
                            });
                          },
                          onTapUp: (details) {
                            setState(() {
                              buttonIndex = 0;
                            });
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: ResultPopup(),
                              ),
                              useSafeArea: false,
                              barrierDismissible: false,
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: buttonIndex == 3
                                  ? const Color.fromARGB(255, 91, 179, 251)
                                  : Colors.blue,
                            ),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: SizedBox(
                                    child: HeroIcon(
                                      HeroIcons.clock,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Recent Score',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTapDown: (details) {
                            setState(() {
                              buttonIndex = 4;
                            });
                          },
                          onTapUp: (details) {
                            setState(() {
                              buttonIndex = 0;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: buttonIndex == 4
                                  ? const Color.fromARGB(255, 91, 179, 251)
                                  : Colors.blue,
                            ),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: SizedBox(
                                    child: HeroIcon(
                                      HeroIcons.power,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {
                  //           showDialog(
                  //             context: context,
                  //             builder: (context) => const AlertDialog(
                  //               content: StartQuizPopup(),
                  //               backgroundColor: Colors.transparent,
                  //             ),
                  //           );
                  //         },
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           height: 60,
                  //           width: 240,
                  //           decoration: const BoxDecoration(
                  //             borderRadius: BorderRadiusDirectional.only(
                  //               topStart: Radius.circular(50),
                  //               bottomEnd: Radius.circular(50),
                  //             ),
                  //             color: Colors.amber,
                  //           ),
                  //           child: const Text(
                  //             'Start Quiz !!',
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Container(
                  //         alignment: Alignment.center,
                  //         height: 60,
                  //         width: 240,
                  //         decoration: BoxDecoration(
                  //           borderRadius: const BorderRadiusDirectional.only(
                  //             topStart: Radius.circular(50),
                  //             bottomEnd: Radius.circular(50),
                  //           ),
                  //           color:
                  //               isPredictable == false ? Colors.grey : Colors.amber,
                  //         ),
                  //         child: const Text(
                  //           'Predict Your Score !!',
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             fontSize: 20,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //         alignment: Alignment.center,
                  //         height: 60,
                  //         width: 240,
                  //         decoration: const BoxDecoration(
                  //           borderRadius: BorderRadiusDirectional.only(
                  //             topStart: Radius.circular(50),
                  //             bottomEnd: Radius.circular(50),
                  //           ),
                  //           color: Colors.amber,
                  //         ),
                  //         child: const Text(
                  //           'History',
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             fontSize: 20,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Container(
                  //         alignment: Alignment.center,
                  //         height: 60,
                  //         width: 240,
                  //         decoration: const BoxDecoration(
                  //           borderRadius: BorderRadiusDirectional.only(
                  //             topStart: Radius.circular(50),
                  //             bottomEnd: Radius.circular(50),
                  //           ),
                  //           color: Colors.amber,
                  //         ),
                  //         child: const Text(
                  //           'About This App',
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             fontSize: 20,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const Spacer(),
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
