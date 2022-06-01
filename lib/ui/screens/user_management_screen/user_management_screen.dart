import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_alarm_app/logic/providers/user_provider.dart';
import 'package:security_alarm_app/ui/screens/AddEditUserScreen/add_edit_user_screen.dart';
import 'package:security_alarm_app/ui/screens/user_management_screen/ui/user_widget.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Management"),
        actions: [
          TextButton(
              onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddEditUserScreen()));
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Consumer<UserProvider>(

        builder: (context,provider,ch) {
          if(provider.users.isEmpty){
            return const Center(child: Text('No users found'),);
          }
          return ListView.builder(
              itemCount: provider.users.length ,
              itemBuilder: (BuildContext context,int i){

                return UserWiget(userModal: provider.users[i]);

          });
        }
      ),
    );
  }
}


