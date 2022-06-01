
import 'package:get_it/get_it.dart';
import 'package:security_alarm_app/logic/data_sources/local_data_source.dart';
import 'package:security_alarm_app/logic/services/auth_service.dart';
import 'package:security_alarm_app/logic/services/secure_storage_servic.dart';
import 'package:security_alarm_app/logic/services/user_services.dart';

final sl = GetIt.instance;
Future<void> init() async {



  sl.registerLazySingleton(() => UserService());
  sl.registerLazySingleton(() => AuthServices());
  sl.registerLazySingleton(() => SecureStorageService());
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImg());



}