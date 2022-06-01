import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_alarm_app/dependency_injections.dart';
import 'package:security_alarm_app/logic/data_sources/local_data_source.dart';
import 'package:security_alarm_app/logic/providers/user_provider.dart';
import 'package:security_alarm_app/logic/services/auth_service.dart';
import 'package:security_alarm_app/logic/services/user_services.dart';

import '../../data/modal/user_modal.dart';
import 'auth/login_screen/login_screen.dart';
import 'home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToScreen();
  }

  final LocalDataSource localDataSource = sl();
  final AuthServices _authServices = sl();
  final UserService _userServices = sl();
  goToScreen() async {
    UserModal? user = await _authServices.checkIfUserLoggedIn();

    if (user != null) {
      context.read<UserProvider>().setCurrentUser(user);
      if (user.isAdmin) {
        final users = await _userServices.getAllUsers();
        context.read<UserProvider>().setUsers(users);
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
