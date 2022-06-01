import 'dart:convert';

import 'package:security_alarm_app/data/modal/user_modal.dart';
import 'package:security_alarm_app/dependency_injections.dart';
import 'package:security_alarm_app/logic/services/secure_storage_servic.dart';

class UserService {
  SecureStorageService _storageService = sl();

  Future<List<UserModal>> getAllUsers() async {
    final result = await _storageService.read(key: 'users');
    if (result == null) {
      return [];
    } else {
      final decodedUsers = jsonDecode(result);
      return decodedUsers.map<UserModal>((item) => UserModal.fromJson(item)).toList();
    }
  }

  Future<void> updateAllUsers({required List<UserModal> list}) async {
    await _storageService.write(
        key: 'users', value: jsonEncode(list.map((e) => e.toJson()).toList()));
  }
}
