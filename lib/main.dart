import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:security_alarm_app/data/constants/colors.dart';
import 'package:security_alarm_app/logic/providers/home_provider.dart';
import 'package:security_alarm_app/logic/providers/user_provider.dart';
import 'package:security_alarm_app/ui/screens/splash_screen.dart';
import 'dependency_injections.dart' as dl;

void main() async{
  WidgetsFlutterBinding.ensureInitialized() ;
  await dl.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider()),
        ChangeNotifierProvider(create: (_)=>HomeProvider()),
      ],
      child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: kPrimaryColor,

              primarySwatch: Colors.red,
            ),
            home: const SplashScreen(),
          );
        }
      ),
    );
  }
}



