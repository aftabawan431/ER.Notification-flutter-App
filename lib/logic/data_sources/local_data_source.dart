import 'dart:convert';

import 'package:security_alarm_app/data/constants/secure_storage_keys.dart';
import 'package:security_alarm_app/data/modal/user_modal.dart';
import 'package:security_alarm_app/logic/services/secure_storage_servic.dart';

abstract class LocalDataSource {
  Future<List<UserModal>> getAllUsers();
}

class LocalDataSourceImg implements LocalDataSource {
  final SecureStorageService _secureStorageService = SecureStorageService();

  @override
  Future<List<UserModal>> getAllUsers() async {
    try {
      final result =
          await _secureStorageService.read(key: SecureStorageKeys.Users_Key);
      if (result != null) {
        return [];
      } else {
        final jsonResponse = jsonDecode(result!);
        return jsonResponse.map((item) => UserModal.fromJson(item)).toList();
      }
    } catch (e) {
      return [];
    }
  }
}
