import 'package:flutter/material.dart';
import 'package:security_alarm_app/data/modal/user_modal.dart';
import 'package:security_alarm_app/dependency_injections.dart';
import 'package:security_alarm_app/logic/services/app_services.dart';
import 'package:security_alarm_app/logic/services/auth_service.dart';
import 'package:security_alarm_app/logic/services/user_services.dart';
import 'package:security_alarm_app/ui/screens/auth/login_screen/login_screen.dart';

class UserProvider extends ChangeNotifier {
  List<UserModal> _users = [];
  List<UserModal> get users => _users.reversed.toList();
  UserModal? _currentUser;
  UserModal? get currentUser => _currentUser;
  UserService _userService = sl();
  AuthServices _authServices = sl();
  String status = 'active';

  Future getAndSetAllUsers() async {
    final usersRes = await _userService.getAllUsers();
    _users = usersRes;
    notifyListeners();
  }

  Future updateUser(BuildContext context, UserModal userModal) async {
    int index = _users.indexWhere((element) => element.userId == userModal.userId);
    _users[index] = userModal;
    updateAllUsersOnDisk();
    notifyListeners();
    Navigator.of(context).pop();
    AppServices.showSnackeBar(context, 'User updated');
  }

  Future updateAllUsersOnDisk() async {
    await _userService.updateAllUsers(list: users);
  }

  //current users functions
  void setCurrentUser(UserModal? value) {
    _currentUser = value;
    notifyListeners();
  }

  // manage users
  void setUsers(List<UserModal> list) {
    _users = list;
    notifyListeners();
  }

  void addUser(BuildContext context, UserModal userModal) {
    _users.add(userModal);
    updateAllUsersOnDisk();
    Navigator.of(context).pop();
    AppServices.showSnackeBar(context, 'Users Added Successfully');
    notifyListeners();
  }

  Future logout(BuildContext context) async {
    _authServices.logoutUser(context);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
  }
}
