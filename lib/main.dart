import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vision_ex_digital_practical/account/bloc/account_bloc.dart';
import 'package:vision_ex_digital_practical/account/models/account.dart';
import 'package:vision_ex_digital_practical/house/bloc/house_bloc.dart';
import 'package:vision_ex_digital_practical/house/screens/home_screen.dart';
import 'package:vision_ex_digital_practical/house/screens/welcome_screen.dart';
import 'package:vision_ex_digital_practical/services/network_listener.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
  NetworkListener().checkInternet();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountCubit>(
          create: (context) => AccountCubit()..loadAccount(),
        ),
        BlocProvider<HouseCubit>(create: (context) => HouseCubit()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Vision ex digital practical',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCubit, Account?>(
      listener: (context, account) {
        if (account != null) {
          context.read<HouseCubit>().getHouseData();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          );
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
