import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:skripsi/constants/app_colors.dart';
import 'package:skripsi/domain/entities/decision_tree_entity.dart';
import 'package:skripsi/domain/entities/user_data_entity.dart';
import 'package:skripsi/presentation/providers/bloc/predict_bloc.dart';
import 'package:skripsi/presentation/providers/bloc/user_bloc.dart';
import 'package:skripsi/presentation/providers/user_provider.dart';

class AdminTestPage extends StatefulWidget {
  const AdminTestPage({super.key});

  @override
  State<AdminTestPage> createState() => AdminTestPageState();
}

class AdminTestPageState extends State<AdminTestPage> {
  double accuracy = 0;
  int correctPredict = 0;
  int wrongPredict = 0;
  bool isTreeTapped = false;
  bool isPredictTapped = false;
  bool isPredictAccTapped = false;
  bool isClearTapped = false;
  bool successPredictAcc = false;
  int treeState = 0;
  int predictIndex = 0;
  int dataLength = 0;
  Map<String, dynamic> result = {'index': 0, 'leaf': ''};
  List<UserDataEntity> userList = [];
  List<UserDataEntity> usercleanedList = [];
  List<UserDataEntity> trainDataset = [];
  List<UserDataEntity> testDataset = [];
  late DecisionTreeEntity root;
  List<DecisionTreeEntity> generateList = [];
  List<DecisionTreeEntity> branchList = [];

  TextEditingController eksponensialController = TextEditingController();
  TextEditingController spltvController = TextEditingController();
  TextEditingController fungsiController = TextEditingController();

  @override
  void dispose() {
    eksponensialController.dispose();
    spltvController.dispose();
    fungsiController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<UserBloc>().add(GetAllUser());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<PredictBloc, PredictState>(
            builder: (context, branchState) {
          if (branchState is SuccessGenerateRoot) {
            root = branchState.root;
            context
                .read<PredictBloc>()
                .add(GenerateBranch(userList: trainDataset, root: root));
          }

          if (branchState is SuccessGenerateBranch) {
            generateList = branchState.branches;
            branchList = generateList;
          }

          if (branchState is SuccessPredict) {
            result = branchState.result;
            if (result['index'] < 3) {
              predictIndex = result['index'];
            }
          }

          if (branchState is SuccessPredictAcc) {
            accuracy = branchState.result['accuracy'];
            correctPredict = branchState.result['true'];
            wrongPredict = branchState.result['false'];
          }

          return BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
            if (userState is GetAllSuccessState) {
              userList = List.from(userState.users);
            } else if (userState is CleanSuccessState) {
              userList = List.from(userState.userList);
              trainDataset.clear();
              testDataset.clear();
              for (int i = 0; i < userList.length; i++) {
                if (i < (userList.length) * 0.2) {
                  testDataset.add(userList[i]);
                } else {
                  trainDataset.add(userList[i]);
                }
              }
              context
                  .read<PredictBloc>()
                  .add(GenerateRoot(userList: trainDataset));
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 500,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor().iceColdStare,
                          AppColor().iceColdStare,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3),
                          height: 58,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue,
                                AppColor().caribbeanGreen,
                              ],
                            ),
                          ),
                          child: InkWell(
                            onTapDown: (details) {
                              setState(() {
                                isTreeTapped = true;
                              });
                              if (treeState == 0) {
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .updateUsers(userList);
                                context
                                    .read<UserBloc>()
                                    .add(CleanData(userList: userList));
                              }
                            },
                            onTapUp: (details) {
                              if (treeState == 2) {
                                setState(() {
                                  treeState = 0;
                                });

                                isTreeTapped = false;
                                // generateList = List.from(branchList);
                                // branchList.clear();
                                // generateList.clear();
                              } else {
                                isTreeTapped = false;

                                if (treeState == 0) {
                                  final cleanUserList =
                                      List<UserDataEntity>.from(userList);
                                  final list = Provider.of<UserProvider>(
                                          context,
                                          listen: false)
                                      .users;

                                  for (int i = 0; i < list.length; i++) {
                                    context
                                        .read<UserBloc>()
                                        .add(RemoveThisUser(id: list[i].id));
                                  }

                                  for (int i = 0;
                                      i < cleanUserList.length;
                                      i++) {
                                    context.read<UserBloc>().add(
                                        PostUser(userData: cleanUserList[i]));
                                  }
                                }

                                context
                                    .read<PredictBloc>()
                                    .add(GenerateRoot(userList: trainDataset));

                                setState(() {
                                  branchList = generateList;
                                });

                                if (treeState == 1) {}

                                treeState++;
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: double.maxFinite,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: isTreeTapped == false
                                    ? AppColor().iceColdStare
                                    : Colors.transparent,
                              ),
                              child: Text(
                                treeState == 0
                                    ? 'Clean Data'
                                    : (treeState == 1
                                        ? 'Create Tree'
                                        : 'Clear Tree'),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: isTreeTapped == true
                                        ? AppColor().iceColdStare
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        treeState != 2
                            ? const SizedBox()
                            :
                            // Tree
                            Column(
                                children: [
                                  const SizedBox(
                                    child: Text(
                                      'Root',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(3),
                                    height: 58,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
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
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: AppColor().iceColdStare),
                                      child: Text(
                                        branchList.isNotEmpty
                                            ? '${branchList[0].name} < ${branchList[0].condition.toStringAsFixed(2)}'
                                            : '',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              branchList.isNotEmpty
                                                  ? (branchList[1].trueLeaf ==
                                                          ''
                                                      ? 'Leaf'
                                                      : 'Branch')
                                                  : 'Branch',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(3),
                                            height: 58,
                                            width: 170,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              gradient: LinearGradient(
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
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  color:
                                                      AppColor().iceColdStare),
                                              child: Text(
                                                branchList.isNotEmpty
                                                    ? (branchList[1].trueLeaf ==
                                                            ''
                                                        ? branchList[1].name
                                                        : '${branchList[1].name} < ${branchList[1].condition}')
                                                    : '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              branchList.isNotEmpty
                                                  ? (branchList[2].trueLeaf ==
                                                          ''
                                                      ? 'Leaf'
                                                      : 'Branch')
                                                  : 'Branch',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(3),
                                            height: 58,
                                            width: 170,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              gradient: LinearGradient(
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
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  color:
                                                      AppColor().iceColdStare),
                                              child: Text(
                                                branchList.isNotEmpty
                                                    ? (branchList[2].trueLeaf ==
                                                            ''
                                                        ? branchList[2].name
                                                        : '${branchList[2].name} < ${branchList[2].condition}')
                                                    : '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              branchList.isNotEmpty
                                                  ? (branchList[1].trueLeaf ==
                                                          ''
                                                      ? ''
                                                      : 'Leaf')
                                                  : 'Leaf',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(3),
                                            height: 58,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              gradient: LinearGradient(
                                                colors: [
                                                  branchList.isNotEmpty
                                                      ? (branchList[1]
                                                                  .trueLeaf ==
                                                              ''
                                                          ? Colors.transparent
                                                          : Colors.blue)
                                                      : Colors.blue,
                                                  branchList.isNotEmpty
                                                      ? (branchList[1]
                                                                  .trueLeaf ==
                                                              ''
                                                          ? Colors.transparent
                                                          : AppColor()
                                                              .caribbeanGreen)
                                                      : AppColor()
                                                          .caribbeanGreen,
                                                ],
                                              ),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: double.maxFinite,
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  color:
                                                      AppColor().iceColdStare),
                                              child: Text(
                                                branchList.isNotEmpty
                                                    ? (branchList[1].trueLeaf ==
                                                            ''
                                                        ? ''
                                                        : branchList[1]
                                                            .trueLeaf)
                                                    : '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              branchList.isNotEmpty
                                                  ? (branchList[1].trueLeaf ==
                                                          ''
                                                      ? ''
                                                      : 'Leaf')
                                                  : 'Leaf',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(3),
                                            height: 58,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              gradient: LinearGradient(
                                                colors: [
                                                  branchList.isNotEmpty
                                                      ? (branchList[1]
                                                                  .trueLeaf ==
                                                              ''
                                                          ? Colors.transparent
                                                          : Colors.blue)
                                                      : Colors.blue,
                                                  branchList.isNotEmpty
                                                      ? (branchList[1]
                                                                  .trueLeaf ==
                                                              ''
                                                          ? Colors.transparent
                                                          : AppColor()
                                                              .caribbeanGreen)
                                                      : AppColor()
                                                          .caribbeanGreen,
                                                ],
                                              ),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: double.maxFinite,
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  color:
                                                      AppColor().iceColdStare),
                                              child: Text(
                                                branchList.isNotEmpty
                                                    ? (branchList[1].trueLeaf ==
                                                            ''
                                                        ? ''
                                                        : branchList[1]
                                                            .falseLeaf)
                                                    : '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              branchList.isNotEmpty
                                                  ? (branchList[2].trueLeaf ==
                                                          ''
                                                      ? ''
                                                      : 'Leaf')
                                                  : 'Leaf',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(3),
                                            height: 58,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              gradient: LinearGradient(
                                                colors: [
                                                  branchList.isNotEmpty
                                                      ? (branchList[2]
                                                                  .trueLeaf ==
                                                              ''
                                                          ? Colors.transparent
                                                          : Colors.blue)
                                                      : Colors.blue,
                                                  branchList.isNotEmpty
                                                      ? (branchList[2]
                                                                  .trueLeaf ==
                                                              ''
                                                          ? Colors.transparent
                                                          : AppColor()
                                                              .caribbeanGreen)
                                                      : AppColor()
                                                          .caribbeanGreen,
                                                ],
                                              ),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: double.maxFinite,
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  color:
                                                      AppColor().iceColdStare),
                                              child: Text(
                                                branchList.isNotEmpty
                                                    ? (branchList[2].trueLeaf ==
                                                            ''
                                                        ? ''
                                                        : branchList[2]
                                                            .trueLeaf)
                                                    : '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              branchList.isNotEmpty
                                                  ? (branchList[2].trueLeaf ==
                                                          ''
                                                      ? ''
                                                      : 'Leaf')
                                                  : 'Leaf',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(3),
                                            height: 58,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              gradient: LinearGradient(
                                                colors: [
                                                  branchList.isNotEmpty
                                                      ? (branchList[2]
                                                                  .trueLeaf ==
                                                              ''
                                                          ? Colors.transparent
                                                          : Colors.blue)
                                                      : Colors.blue,
                                                  branchList.isNotEmpty
                                                      ? (branchList[2]
                                                                  .trueLeaf ==
                                                              ''
                                                          ? Colors.transparent
                                                          : AppColor()
                                                              .caribbeanGreen)
                                                      : AppColor()
                                                          .caribbeanGreen,
                                                ],
                                              ),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: double.maxFinite,
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  color:
                                                      AppColor().iceColdStare),
                                              child: Text(
                                                branchList.isNotEmpty
                                                    ? (branchList[2].trueLeaf ==
                                                            ''
                                                        ? ''
                                                        : branchList[2]
                                                            .falseLeaf)
                                                    : '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: treeState != 2
                      ? const SizedBox()
                      : Container(
                          height: 500,
                          width: double.maxFinite,
                          color: AppColor().iceColdStare,
                          child: Column(
                            children: [
                              const Text(
                                'Try to Predict A Data!',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                height: 4,
                                width: 200,
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
                                height: 36,
                              ),
                              branchList[predictIndex].name != 'Eksponensial'
                                  ? const SizedBox()
                                  : TextField(
                                      controller: eksponensialController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
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
                              branchList[predictIndex].name != 'SPLTV'
                                  ? const SizedBox()
                                  : TextField(
                                      controller: spltvController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
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
                              branchList[predictIndex].name != 'Fungsi'
                                  ? const SizedBox()
                                  : TextField(
                                      controller: fungsiController,
                                      keyboardType: TextInputType.number,
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
                                height: 20,
                              ),
                              result['index'] != 3
                                  ? const SizedBox()
                                  : Container(
                                      height: 250,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            AppColor().spaceBattleBlue,
                                            Colors.blue,
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Predict Result:',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor().iceColdStare,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            result['leaf'],
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor().iceColdStare,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTapDown: (details) {
                                      setState(() {
                                        isPredictTapped = true;
                                        final predictScore =
                                            branchList[predictIndex].name ==
                                                    'Eksponensial'
                                                ? eksponensialController.text
                                                : (branchList[predictIndex]
                                                            .name ==
                                                        'SPLTV'
                                                    ? spltvController.text
                                                    : fungsiController.text);

                                        context.read<PredictBloc>().add(
                                            PredictTest(
                                                branchList: branchList,
                                                predictIndex: predictIndex,
                                                predictScore: double.parse(
                                                    predictScore)));
                                      });
                                    },
                                    onTapUp: (details) {
                                      setState(() {
                                        isPredictTapped = false;

                                        if (result['index'] < 3) {
                                          predictIndex = result['index'];
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      height: 55,
                                      width: 100,
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
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              isPredictTapped != true
                                                  ? AppColor().iceColdStare
                                                  : Colors.blue,
                                              isPredictTapped != true
                                                  ? AppColor().iceColdStare
                                                  : AppColor().caribbeanGreen,
                                            ],
                                          ),
                                        ),
                                        child: Text(
                                          'Predict',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: isPredictTapped == true
                                                  ? AppColor().iceColdStare
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  result['index'] != 3
                                      ? const SizedBox()
                                      : const SizedBox(
                                          width: 20,
                                        ),
                                  result['index'] != 3
                                      ? const SizedBox()
                                      : InkWell(
                                          onTapDown: (details) {
                                            setState(() {
                                              isClearTapped = true;
                                            });
                                          },
                                          onTapUp: (details) {
                                            setState(() {
                                              isClearTapped = false;
                                              predictIndex = 0;
                                              result = {'index': 0, 'leaf': ''};
                                              context
                                                  .read<PredictBloc>()
                                                  .clearState();
                                              eksponensialController.clear();
                                              spltvController.clear();
                                              fungsiController.clear();
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(3),
                                            height: 55,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                                borderRadius:
                                                    BorderRadius.circular(9),
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomLeft,
                                                  end: Alignment.topRight,
                                                  colors: [
                                                    isClearTapped != true
                                                        ? AppColor()
                                                            .iceColdStare
                                                        : Colors.blue,
                                                    isClearTapped != true
                                                        ? AppColor()
                                                            .iceColdStare
                                                        : AppColor()
                                                            .caribbeanGreen,
                                                  ],
                                                ),
                                              ),
                                              child: Text(
                                                'Clear',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: isClearTapped == true
                                                        ? AppColor()
                                                            .iceColdStare
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
                SliverToBoxAdapter(
                  child: treeState != 2
                      ? const SizedBox()
                      : Container(
                          height: 500,
                          width: double.maxFinite,
                          color: AppColor().iceColdStare,
                          child: Column(
                            children: [
                              const Text(
                                'Try to Predict Accuracy!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                height: 4,
                                width: 220,
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
                                height: 20,
                              ),
                              InkWell(
                                onTapDown: (details) {
                                  setState(() {
                                    isPredictAccTapped = true;
                                  });
                                },
                                onTapUp: (details) {
                                  setState(() {
                                    isPredictAccTapped = false;
                                  });
                                  context.read<PredictBloc>().add(
                                      AccuracyPredict(
                                          userList: testDataset,
                                          branchList: branchList));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  height: 55,
                                  width: 200,
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
                                          isPredictAccTapped != true
                                              ? AppColor().iceColdStare
                                              : Colors.blue,
                                          isPredictAccTapped != true
                                              ? AppColor().iceColdStare
                                              : AppColor().caribbeanGreen,
                                        ],
                                      ),
                                    ),
                                    child: Text(
                                      'Predict Accuracy',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: isPredictAccTapped == true
                                              ? AppColor().iceColdStare
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 240,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      AppColor().spaceBattleBlue,
                                      Colors.blue,
                                    ],
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Accuracy Predict Result',
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor().iceColdStare,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 160,
                                      child: Table(
                                        children: [
                                          TableRow(children: [
                                            Text(
                                              'Accuracy',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor().iceColdStare,
                                              ),
                                            ),
                                            Text(
                                              ': ${accuracy.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor().iceColdStare,
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Text(
                                              'Correct',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor().iceColdStare,
                                              ),
                                            ),
                                            Text(
                                              ': $correctPredict',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor().iceColdStare,
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Text(
                                              'Wrong',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor().iceColdStare,
                                              ),
                                            ),
                                            Text(
                                              ': $wrongPredict',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor().iceColdStare,
                                              ),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                ),
              ],
            );
          });
        }),
      ),
    );
  }
}
