import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:security_alarm_app/data/constants/images_path.dart';
import 'package:security_alarm_app/logic/globel_variables.dart' as Data;
import 'package:security_alarm_app/logic/providers/home_provider.dart';
import 'package:security_alarm_app/logic/providers/user_provider.dart';
import 'package:security_alarm_app/logic/services/validators.dart';
import 'package:security_alarm_app/ui/screens/home_screen/ui/drawer.dart';
import 'package:security_alarm_app/ui/widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoadingCheck = false;
  bool isSafeLoadingCheck = false;

  Future<void> helpCall() async {
    setState(() {
      isLoadingCheck = true;
    });
    var helpJsonBody = jsonEncode(<String, dynamic>{
      'userID': Data.id,
    });
    var url = 'https://qa-er-notificationapi.appinsnap.com/api/Emergency/Help';
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'No Internet', gravity: ToastGravity.SNACKBAR, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
      setState(() {
        isLoadingCheck = false;
      });
    } else {
      try {
        http.Response response = await http.post(
          Uri.parse(url),
          body: helpJsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        print('this is the response ${response.statusCode}');
        print('this is the req $helpJsonBody');
        print('this is the url $url');
        if (response.statusCode == 200) {
          var getDataFromJsonResponse = jsonDecode(response.body);
          setState(() {
            Data.emergencyID = getDataFromJsonResponse['emergencyID'];
            Data.managerName = getDataFromJsonResponse['managerName'];
            Data.bankName = getDataFromJsonResponse['bankName'];
            Data.branchName = getDataFromJsonResponse['branchName'];
            Data.address = getDataFromJsonResponse['address'];
          });

          print('this is the id ${Data.emergencyID}');
          print('this is the id ${Data.managerName}');
          print('this is the bankName ${Data.bankName}');
          print('this is the bankName ${Data.branchName}');
          print('this is the bankName ${Data.address}');
          print('help called successful');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => const HomeScreen(),
          //   ),
          // );

          setState(() {
            isLoadingCheck = false;
          });
        } else {
          setState(() {
            isLoadingCheck = false;
          });
          print('help failed');
        }
      } catch (e) {
        setState(() {
          isLoadingCheck = false;
        });
        print(e.toString());
      }
    }
  }

  Future<void> safeCall() async {
    setState(() {
      isSafeLoadingCheck = true;
    });
    var safeJsonBody = jsonEncode(<String, dynamic>{
      'userID': Data.id,
      'emergencyID': Data.emergencyID,
      'remarks': Data.remarks.toString(),
      'verificationCode': 0,
    });
    var url = 'https://qa-er-notificationapi.appinsnap.com/api/Emergency/Safe';
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'No Internet', gravity: ToastGravity.SNACKBAR, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
      setState(() {
        isSafeLoadingCheck = false;
      });
    } else {
      try {
        http.Response response = await http.post(
          Uri.parse(url),
          body: safeJsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        print('this is the response ${response.statusCode}');
        print('this is the req $safeJsonBody');
        print('this is the url $url');
        if (response.statusCode == 200) {
          var getDataFromJsonResponse = jsonDecode(response.body);
          setState(() {
            Data.remarks = getDataFromJsonResponse['remarks'];
            Data.verificationCode = getDataFromJsonResponse['verificationCode'];
            controller.text = '';
          });
          print('this is the id ${Data.emergencyID}');
          print('this is the id ${Data.managerName}');

          print('safe called successfully');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => const HomeScreen(),
          //   ),
          // );

          setState(() {
            isSafeLoadingCheck = false;
          });
        } else {
          setState(() {
            isSafeLoadingCheck = false;
          });
          print('safe failed');
        }
      } catch (e) {
        setState(() {
          isSafeLoadingCheck = false;
        });
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                await context.read<UserProvider>().logout(context);
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      drawer: const HomeDrawerWidget(),
      body: SafeArea(child: Center(
        child: LayoutBuilder(builder: (context, contraints) {
          return Consumer<HomeProvider>(builder: (context, provider, ch) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: provider.isAlarmPressed
                      ? IconButton(
                          splashRadius: 110.sp,
                          onPressed: () async {
                            await showAlramStatus(context);

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Help arrived'),
                              duration: Duration(seconds: 1),
                            ));
                          },
                          icon: Image.asset(ImagesPath.GreenCirclePath),
                          iconSize: 200.sp,
                        )
                      : IconButton(
                          splashRadius: 110.sp,
                          onPressed: () {
                            helpCall();
                            provider.setIsAlarmPressed();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Help on the way'),
                              duration: Duration(seconds: 1),
                            ));
                          },
                          icon: Image.asset(ImagesPath.HELPREDCIRCULE),
                          iconSize: 200.sp,
                        ),
                ),
                if (provider.isAlarmPressed == !provider.isAlarmPressed) const Text('press again to stop')
              ],
            );
          });
        }),
      )),
    );
  }

  TextEditingController controller = TextEditingController();
  showAlramStatus(BuildContext context) {
    String reason = '';
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Was this false alarm?",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFieldWidget(
                      controller: controller,
                      hint: 'Reason',
                      onChanged: (value) {
                        Data.remarks = value!;
                        return null;
                      },
                      validator: Validators().validateField),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.withOpacity(.8),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            sameFunction(context, null);
                          },
                          child: const Text('No')),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey.withOpacity(.8),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            sameFunction(context, controller.text);
                            safeCall();
                          },
                          child: const Text('Yes')),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  sameFunction(BuildContext context, String? reason) {
    if (reason == null) {
      Navigator.of(context).pop();
      context.read<HomeProvider>().setIsAlarmPressed();
      return;
    }
    if (reason.isEmpty) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(reason),
      duration: const Duration(milliseconds: 500),
    ));
    context.read<HomeProvider>().setIsAlarmPressed();
  }
}
