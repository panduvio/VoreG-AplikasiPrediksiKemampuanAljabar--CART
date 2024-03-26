import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/constants/app_colors.dart';
import 'package:skripsi/presentation/providers/user_provider.dart';
import 'package:skripsi/presentation/screens/home_screen.dart';

class ResultPopup extends StatefulWidget {
  const ResultPopup({super.key});

  @override
  State<ResultPopup> createState() => _ResultPopupState();
}

class _ResultPopupState extends State<ResultPopup> {
  bool isTapped = false;
  double eksponensialScore = 0;
  double spltvScore = 0;
  double fungsiScore = 0;
  String kemampuanAljabar = '';
  String recommendation = '';
  List<String> bidangList = [];
  List<double> scoreList = [];
  late SharedPreferences userSp;

  initial() async {
    userSp = await SharedPreferences.getInstance();
    setState(() {
      recommendation = userSp.getString('recommendation')!;
    });
  }

  @override
  void initState() {
    initial();
    final list = Provider.of<UserProvider>(context, listen: false).bidangList;
    for (int i = 0; i < list.length; i++) {
      bidangList.add(list[i]);
    }
    setState(() {
      eksponensialScore = Provider.of<UserProvider>(context, listen: false)
          .user
          .eksponensialScore;
      spltvScore =
          Provider.of<UserProvider>(context, listen: false).user.spltvScore;
      fungsiScore =
          Provider.of<UserProvider>(context, listen: false).user.fungsiScore;
      kemampuanAljabar = Provider.of<UserProvider>(context, listen: false)
          .user
          .aljabarStrength;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 6),
      height: 470,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor().iceColdStare,
      ),
      child: Column(
        children: [
          Text(
            'Result',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 245,
            child: Table(
              children: [
                TableRow(
                  children: [
                    Text(
                      '${bidangList[0][0].toUpperCase() + bidangList[0].substring(1)} Score',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      ': ${bidangList[0] == 'Eksponensial' ? eksponensialScore : (bidangList[0] == 'SPLTV' ? spltvScore : fungsiScore)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                bidangList.length == 1
                    ? TableRow(
                        children: [Text(''), Text('')],
                      )
                    : TableRow(
                        children: [
                          Text(
                            '${bidangList[1][0].toUpperCase() + bidangList[1].substring(1)} Score',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            ': ${bidangList[1] == 'Eksponensial' ? eksponensialScore : (bidangList[1] == 'SPLTV' ? spltvScore : fungsiScore)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                TableRow(
                  children: [
                    Text(
                      'Kemampuan Aljabar',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      ': $kemampuanAljabar',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      'Rekomendasi',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: SingleChildScrollView(
                        child: Text(
                          ': $recommendation',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Ink(
            child: InkWell(
              onTapDown: (detail) {
                setState(() {
                  isTapped = true;
                });
              },
              onTapUp: (details) {
                setState(() {
                  isTapped = false;
                });
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isTapped == false
                      ? AppColor().spaceBattleBlue
                      : AppColor().caribbeanGreen,
                ),
                child: Text(
                  'Close',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: isTapped == true
                        ? AppColor().spaceBattleBlue
                        : AppColor().iceColdStare,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
