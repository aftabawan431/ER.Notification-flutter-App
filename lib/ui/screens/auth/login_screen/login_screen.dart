import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:security_alarm_app/logic/globel_variables.dart' as Data;
import 'package:security_alarm_app/logic/services/auth_service.dart';
import 'package:security_alarm_app/logic/services/validators.dart';
import 'package:security_alarm_app/ui/widgets/custom_buttton.dart';
import 'package:security_alarm_app/ui/widgets/custom_textfield.dart';

import '../../home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String mobile = '';
  String pin = '';
  Validators validators = Validators();

  final AuthServices _authServices = AuthServices();

  bool isLoadingCheck = false;

  Future<void> loginUser() async {
    setState(() {
      isLoadingCheck = true;
    });
    var loginJsonBody = jsonEncode(<String, String>{
      'mobile': mobile.toString(),
      'pin': pin.toString(),
    });
    var url = 'https://qa-er-notificationapi.appinsnap.com/api/Account/Login';
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'No Internet', gravity: ToastGravity.SNACKBAR, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
      setState(() {
        isLoadingCheck = false;
      });
    } else {
      try {
        http.Response response = await http.post(
          Uri.parse(url),
          body: loginJsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        print('this is the response ${response.body}');
        print('this is the req $loginJsonBody');
        print('this is the url $url');
        if (response.statusCode == 200) {
          var getDataFromJsonResponse = jsonDecode(response.body);
          setState(() {
            Data.id = getDataFromJsonResponse['id'];
            Data.name = getDataFromJsonResponse['name'];
            Data.role = getDataFromJsonResponse['role'];
            Data.loginStatusCode = response.statusCode;
          });
          print('this is the id2 ${Data.id}');
          print('login successful');
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeScreen(),
            ),
          );

          setState(() {
            isLoadingCheck = false;
          });
        } else {
          setState(() {
            isLoadingCheck = false;
          });
          print('Login failed');
        }
      } catch (e) {
        setState(() {
          isLoadingCheck = false;
        });
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldWidget(
                      hint: 'Mobile',
                      onChanged: (value) {
                        mobile = value!;
                      },
                      validator: validators.validateEmail),
                  TextFieldWidget(
                      hint: 'PIN',
                      isNumber: true,
                      maxLength: 4,
                      onChanged: (value) {
                        pin = value!;
                      },
                      validator: validators.validePin),
                  isLoadingCheck
                      ? const CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.red,
                        )
                      : ElevatedButtonWidget(
                          title: 'Login',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              loginUser();
                            }
                          })
                ],
              ),
            )),
      ),
    );
  }
}
