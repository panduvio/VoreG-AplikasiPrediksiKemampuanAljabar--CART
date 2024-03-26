import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:skripsi/dependency_injection.dart';
import 'package:skripsi/presentation/providers/bloc/predict_bloc.dart';
import 'package:skripsi/presentation/providers/bloc/user_bloc.dart';
import 'package:skripsi/presentation/providers/user_provider.dart';
import 'package:skripsi/presentation/screens/login_screen.dart';

void main() {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  setUp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => PredictBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Dosis',
      ),
      home: LoginScreen(),
    );
  }
}
