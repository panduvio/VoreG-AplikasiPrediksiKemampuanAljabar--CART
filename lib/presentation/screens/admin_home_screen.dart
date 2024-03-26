import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/constants/app_colors.dart';
import 'package:skripsi/presentation/providers/bloc/user_bloc.dart';
import 'package:skripsi/presentation/screens/admin_add_data_page.dart';
import 'package:skripsi/presentation/screens/admin_check_data_page.dart';
import 'package:skripsi/presentation/screens/admin_test_page.dart';
import 'package:skripsi/presentation/screens/login_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int bottomNavigatorIndex = 0;
  int onButtonTap = 0;
  String adminName = '';
  late SharedPreferences userSp;

  @override
  void initState() {
    initial();

    super.initState();
  }

  void initial() async {
    userSp = await SharedPreferences.getInstance();
    setState(() {
      userSp.setInt('id', 0);
      adminName = userSp.getString('admin')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));
        },
        backgroundColor: AppColor().spaceBattleBlue,
        child: HeroIcon(
          HeroIcons.power,
          color: AppColor().iceColdStare,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor().iceColdStare,
        selectedLabelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        onTap: (value) {
          setState(() {
            bottomNavigatorIndex = value;
            // initial();
            if (value == 0) {
              context.read<UserBloc>().add(GetAllUser());
            }
          });
        },
        currentIndex: bottomNavigatorIndex,
        selectedItemColor: AppColor().tardisBlue,
        items: const [
          BottomNavigationBarItem(
            icon: HeroIcon(HeroIcons.folderOpen),
            label: 'Check Data',
          ),
          BottomNavigationBarItem(
            icon: HeroIcon(HeroIcons.rocketLaunch),
            label: 'Test',
          ),
          BottomNavigationBarItem(
            icon: HeroIcon(HeroIcons.folderPlus),
            label: 'Add Data',
          ),
        ],
      ),
      body: Center(
        child: Container(
            height: double.maxFinite,
            color: AppColor().iceColdStare,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16)),
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
                  'Welcome Admin $adminName',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              bottomNavigatorIndex == 0
                  ? const Expanded(child: AdminCheckDataPage())
                  : (bottomNavigatorIndex == 1
                      ? const Expanded(child: AdminTestPage())
                      : const AdminAddDataPage()),
            ])),
      ),
    );
  }
}
