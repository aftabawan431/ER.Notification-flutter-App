import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:security_alarm_app/data/modal/user_modal.dart';
import 'package:security_alarm_app/logic/globel_variables.dart' as Data;

import '../../AddEditUserScreen/add_edit_user_screen.dart';

class UserWiget extends StatefulWidget {
  UserWiget({required this.userModal, Key? key}) : super(key: key);
  UserModal userModal;

  @override
  State<UserWiget> createState() => _UserWigetState();
}

class _UserWigetState extends State<UserWiget> {
  bool isLoadingCheck = false;

  Future<void> getAllUsers() async {
    setState(() {
      isLoadingCheck = true;
    });
    var getUsersJsonBody = jsonEncode(<String, String>{
      'managerID': Data.id.toString(),
    });
    var url = 'https://qa-er-notificationapi.appinsnap.com/api/Users/GetAllUsers';
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'No Internet', gravity: ToastGravity.SNACKBAR, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
      setState(() {
        isLoadingCheck = false;
      });
    } else {
      try {
        http.Response response = await http.post(
          Uri.parse(url),
          body: getUsersJsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        print('this is the response ${response.body}');
        print('this is the req $getUsersJsonBody');
        print('this is the url $url');
        if (response.statusCode == 200) {
          var getDataFromJsonResponse = jsonDecode(response.body);
          setState(() {
            Data.id = getDataFromJsonResponse['id'];
            Data.name = getDataFromJsonResponse['name'];
            Data.role = getDataFromJsonResponse['role'];
          });
          print('this is the id2 ${Data.id}');
          print('got users successful');
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
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEditUserScreen(
                  isEdit: true,
                  userModal: widget.userModal,
                )));
      },
      leading: Icon(Icons.person),
      title: Text(widget.userModal.name + '  [${widget.userModal.mobile}]'),
      // trailing: Icon(Icons.circle, color: widget.userModal.isActive ? Colors.green : Colors.red),
      isThreeLine: true,
      subtitle: Text(widget.userModal.userId),
    );
  }
}
