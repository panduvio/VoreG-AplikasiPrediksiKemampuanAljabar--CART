import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/constants/app_colors.dart';
import 'package:skripsi/domain/entities/admin_entity.dart';
import 'package:skripsi/presentation/screens/admin_home_screen.dart';
import 'package:skripsi/presentation/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> loginAs = ['Admin', 'User'];
  String selectedValue = 'User';
  int adminAccount = 0;
  TextEditingController adminNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences userSp;
  var formKey = GlobalKey<FormState>();
  List<AdminEntity> adminList = admin;
  int keyboardOn = 0;

  @override
  void initState() {
    initial();

    super.initState();
  }

  void initial() async {
    userSp = await SharedPreferences.getInstance();
    setState(() {
      // userSp.get('id') == null ? idDb = 0 : idDb = userSp.getInt('id')!;
      userSp.setInt('id', 0);
      userSp.setString('admin', '');
      userSp.setString('user', '');
      userSp.setString('recommendation', '');
    });
  }

  Widget userField() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onTap: () {
              setState(() {
                keyboardOn = 1;
              });
            },
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            onSaved: (newValue) {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input name',
              label: Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty == true) {
                return 'Name cannot be empty';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget adminField() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onTap: () {
              setState(() {
                keyboardOn = 2;
              });
            },
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            onSaved: (newValue) {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            controller: adminNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input admin name',
              label: Text(
                'Admin Name',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty == true) {
                return 'Name cannot be empty';
              } else {
                for (int i = 0; i < adminList.length; i++) {
                  if (adminNameController.text == adminList[i].name) {
                    setState(() {
                      adminAccount = i;
                    });
                    break;
                  } else {
                    if (i == adminList.length - 1) {
                      return 'Incorrect admin name. Please try again';
                    }
                    continue;
                  }
                }
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onTap: () {
              setState(() {
                keyboardOn = 2;
              });
            },
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            onSaved: (newValue) {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 50), () {
                setState(() {
                  keyboardOn = 0;
                });
              });
            },
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input password',
              label: Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty == true) {
                return 'Password cannot be empty';
              } else if (value.length < 8) {
                return 'Password should contain at least 8 characters';
              } else {
                if (passwordController.text ==
                    adminList[adminAccount].password) {
                  return null;
                } else {
                  return 'Incorrect admin password. Please try again';
                }
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: double.maxFinite,
          width: double.maxFinite,
          color: AppColor().iceColdStare,
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
                height: keyboardOn == 1 ? 233 : (keyboardOn == 2 ? 120 : 300),
                child: Image.asset('assets/voreg.png'),
              ),
              const Text(
                'Login as:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: RadioListTile(
                      title: Text(
                        loginAs[0],
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      value: loginAs[0],
                      groupValue: selectedValue,
                      onChanged: ((value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      }),
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      title: Text(
                        loginAs[1],
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      value: loginAs[1],
                      groupValue: selectedValue,
                      onChanged: ((value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      }),
                    ),
                  ),
                ],
              ),
              selectedValue == 'Admin' ? adminField() : userField(),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (selectedValue == 'Admin') {
                      userSp.setString('admin', adminNameController.text);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminHomeScreen(),
                          ));
                    } else {
                      userSp.setString('user', nameController.text);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                    }
                  }
                },
                height: 55,
                minWidth: double.maxFinite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: AppColor().tardisBlue,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
