import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_alarm_app/data/modal/user_modal.dart';
import 'package:security_alarm_app/logic/providers/user_provider.dart';
import 'package:security_alarm_app/ui/screens/user_management_screen/user_management_screen.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: const Center(
                child: Text(
              'Emergency Response System',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Selector<UserProvider, UserModal?>(
            selector: (_, provider) => provider.currentUser,
            builder: (_, user, ch) {
              if (user == null || user == false) {
                return const SizedBox.shrink();
              } else {
                return ListTile(
                  title: const Text('User Management'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserManagementScreen()));
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
