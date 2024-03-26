import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/constants/app_colors.dart';
import 'package:skripsi/dependency_injection.dart';
import 'package:skripsi/domain/entities/bank_soal_entity.dart';
import 'package:skripsi/domain/entities/decision_tree_entity.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/domain/usecases/recommend_usecase.dart';
import 'package:skripsi/presentation/providers/bloc/predict_bloc.dart';
import 'package:skripsi/presentation/providers/user_provider.dart';
import 'package:skripsi/presentation/screens/result_popup.dart';

class PredictScreen extends StatefulWidget {
  final List<UserDataEntity> userList;
  final List<DecisionTreeEntity> branches;
  const PredictScreen({
    required this.userList,
    required this.branches,
    super.key,
  });

  @override
  State<PredictScreen> createState() =>
      _PredictScreenState(userList: userList, branches: branches);
}

class _PredictScreenState extends State<PredictScreen> {
  final List<UserDataEntity> userList;
  final List<DecisionTreeEntity> branches;
  List<BankSoalEntity> bankSoal = listSoalEksponensial;
  List<String> bidangList = [];
  Map<String, dynamic> result = {'index': 0, 'leaf': ''};
  int tahap = 1;
  int pilihanI = 5;
  int indexSoal = 0;
  int predictIndex = 0;
  CarouselController carouselController = CarouselController();

  String bidang = 'Eksponensial';
  String recommendation = '';
  String username = '';
  late String label;
  late SharedPreferences userSp;

  _PredictScreenState({
    required this.userList,
    required this.branches,
  });

  initial() async {
    userSp = await SharedPreferences.getInstance();
    setState(() {
      recommendation = userSp.getString('recommendation')!;
      username = userSp.getString('user')!;
    });
  }

  @override
  void initState() {
    initial();
    updateBankSoal();
    super.initState();
  }

  void updateBankSoal() {
    setState(() {
      bidang = branches[predictIndex].name;
      if (bidang == 'Eksponensial') {
        bankSoal = listSoalEksponensial;
      } else if (bidang == 'SPLTV') {
        bankSoal = listSoalSPLTV;
      } else {
        bankSoal = listSoalFungsi;
      }
    });
  }

  void updateScore(int pilihanI) {
    setState(() {
      final soal = bankSoal[indexSoal];
      late double nilai;

      if (pilihanI == 0) {
        if (tahap == 1) {
          nilai = soal.nilaiIA;
        } else {
          nilai = soal.nilaiIIA;
        }
      } else if (pilihanI == 1) {
        if (tahap == 1) {
          nilai = soal.nilaiIB;
        } else {
          nilai = soal.nilaiIIB;
        }
      } else if (pilihanI == 2) {
        if (tahap == 1) {
          nilai = soal.nilaiIC;
        } else {
          nilai = soal.nilaiIIC;
        }
      } else if (pilihanI == 3) {
        if (tahap == 1) {
          nilai = soal.nilaiID;
        } else {
          nilai = soal.nilaiIID;
        }
      } else {
        if (tahap == 1) {
          nilai = soal.nilaiIE;
        } else {
          nilai = soal.nilaiIIE;
        }
      }

      if (bidang == 'Eksponensial') {
        Provider.of<UserProvider>(context, listen: false)
            .updateUserEksponensial(nilai);
      } else if (bidang == 'SPLTV') {
        Provider.of<UserProvider>(context, listen: false)
            .updateUserSPLTV(nilai);
      } else {
        Provider.of<UserProvider>(context, listen: false)
            .updateUserFungsi(nilai);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bidang,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor().spaceBattleBlue,
      ),
      body: BlocBuilder<PredictBloc, PredictState>(
          builder: (context, predictState) {
        if (predictState is SuccessPredict) {
          result = predictState.result;
        }

        if (predictState is SuccessGenerateRecom) {
          recommendation = recommendation + predictState.recommendation;
          userSp.setString('recommendation', recommendation);
        }
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          color: AppColor().iceColdStare,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${indexSoal + 1}/3',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: tahap == 1
                            ? AppColor().caribbeanGreen
                            : Colors.grey,
                      ),
                      Container(
                        height: 1,
                        width: 24,
                        color: Colors.black,
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: tahap != 1
                            ? AppColor().caribbeanGreen
                            : Colors.grey,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CarouselSlider(
                items: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          AppColor().spaceBattleBlue,
                          Colors.blue,
                        ],
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      height: 200,
                      width: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor().iceColdStare,
                      ),
                      child: SingleChildScrollView(
                        child: TeXView(
                          renderingEngine:
                              const TeXViewRenderingEngine.mathjax(),
                          style: const TeXViewStyle(
                              textAlign: TeXViewTextAlign.justify),
                          child: TeXViewDocument(bankSoal[indexSoal].soalI,
                              style: TeXViewStyle(
                                  fontStyle: TeXViewFontStyle(fontSize: 20))),
                        ),
                      ),
                    ),
                  ),
                  tahap == 2
                      ? Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                AppColor().spaceBattleBlue,
                                Colors.blue,
                              ],
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            height: 200,
                            width: 380,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor().iceColdStare,
                            ),
                            child: SingleChildScrollView(
                              child: TeXView(
                                renderingEngine:
                                    const TeXViewRenderingEngine.mathjax(),
                                style: const TeXViewStyle(
                                    textAlign: TeXViewTextAlign.justify),
                                child: TeXViewDocument(
                                    bankSoal[indexSoal].soalII,
                                    style: TeXViewStyle(
                                        fontStyle:
                                            TeXViewFontStyle(fontSize: 20))),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
                carouselController: carouselController,
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 310,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                    itemBuilder: (context, index) {
                      final soal = bankSoal[indexSoal];
                      return InkWell(
                        onTapDown: (details) {
                          setState(() {
                            pilihanI = index;
                          });
                        },
                        // onTapUp: (details) {
                        //   setState(() {
                        //     pilihanI = 5;
                        //   });
                        // },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          // height: 45,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColor().caribbeanGreen,
                              width: 3,
                            ),
                            color: pilihanI == index
                                ? Colors.white
                                : AppColor().caribbeanGreen,
                          ),
                          child: TeXView(
                            renderingEngine:
                                const TeXViewRenderingEngine.mathjax(),
                            style: const TeXViewStyle(
                                textAlign: TeXViewTextAlign.center),
                            child: TeXViewDocument(
                              index == 0
                                  ? (tahap == 1
                                      ? soal.pilihanIA
                                      : soal.pilihanIIA)
                                  : index == 1
                                      ? (tahap == 1
                                          ? soal.pilihanIB
                                          : soal.pilihanIIB)
                                      : index == 2
                                          ? (tahap == 1
                                              ? soal.pilihanIC
                                              : soal.pilihanIIC)
                                          : index == 3
                                              ? (tahap == 1
                                                  ? soal.pilihanID
                                                  : soal.pilihanIID)
                                              : (tahap == 1
                                                  ? soal.pilihanIE
                                                  : soal.pilihanIIE),
                              style: TeXViewStyle(
                                fontStyle: TeXViewFontStyle(
                                  fontSize: 20,
                                  fontWeight: TeXViewFontWeight.bolder,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: 5),
              ),
              const Spacer(),
              InkWell(
                onTapDown: (details) {
                  if (pilihanI != 5) {
                    updateScore(pilihanI);

                    if (indexSoal == 2 && tahap == 2) {
                      late double score;
                      if (bidang == 'Eksponensial') {
                        score =
                            Provider.of<UserProvider>(context, listen: false)
                                .user
                                .eksponensialScore;
                      } else if (bidang == 'SPLTV') {
                        score =
                            Provider.of<UserProvider>(context, listen: false)
                                .user
                                .spltvScore;
                      } else {
                        score =
                            Provider.of<UserProvider>(context, listen: false)
                                .user
                                .fungsiScore;
                      }

                      if (score > 85) {
                        label = 'kuat';
                      } else if (score > 70) {
                        label = 'sedang';
                      } else {
                        label = 'kurang';
                      }

                      // context.read<PredictBloc>().add(GenerateRecom(
                      //     nama: username, bidang: bidang, label: label));
                      final rec = sl<RecomendUsecase>()
                          .recommend(username, bidang.toLowerCase(), label);
                      setState(() {
                        recommendation = recommendation + rec;
                      });
                      userSp.setString('recommendation', recommendation);
                      bidangList.add(bidang);

                      context.read<PredictBloc>().add(PredictTest(
                          branchList: branches,
                          predictIndex: predictIndex,
                          predictScore: score));
                    }
                  }
                },
                onTapUp: (detail) {
                  setState(
                    () {
                      if (pilihanI != 5) {
                        pilihanI = 5;

                        if (indexSoal < 2 || tahap == 1) {
                          if (tahap == 1) {
                            tahap = 2;
                          } else {
                            tahap = 1;
                            indexSoal++;
                          }
                          carouselController.jumpToPage(tahap - 1);
                        } else {
                          indexSoal = 0;
                          tahap = 1;
                          carouselController.jumpToPage(tahap - 1);

                          if (result['index'] < 3) {
                            predictIndex = result['index'];
                            updateBankSoal();
                          } else {
                            // Update Bidang List untuk Result Card
                            Provider.of<UserProvider>(context, listen: false)
                                .updateBidangList(bidangList);

                            // Menambahkan rekomendasi pada kemampuan aljabar
                            final rec = sl<RecomendUsecase>().recommend(
                                username,
                                'aljabar',
                                result['leaf'].toString().toLowerCase());
                            setState(() {
                              recommendation = recommendation + rec;
                            });
                            userSp.setString('recommendation', recommendation);

                            // Update Kemampuan Aljabar untuk Result Card
                            Provider.of<UserProvider>(context, listen: false)
                                .updateUserFundamental(result['leaf']);

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: ResultPopup(),
                              ),
                              useSafeArea: false,
                              barrierDismissible: false,
                            );
                          }
                        }
                      }
                    },
                  );
                },
                child: Container(
                  height: 45,
                  width: 115,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color:
                          pilihanI == 5 ? Colors.grey : AppColor().tardisBlue,
                      width: 4,
                    ),
                  ),
                  child: Text(
                    'Next!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color:
                          pilihanI == 5 ? Colors.grey : AppColor().tardisBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      }),
    );
  }
}
