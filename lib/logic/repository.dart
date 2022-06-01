// import 'package:dartz/dartz.dart';
// import 'package:security_alarm_app/logic/failure.dart';
// import 'package:security_alarm_app/logic/generic_request.dart';
// import 'package:security_alarm_app/logic/network_info.dart';
//
// import '../data/constants/app_messages.dart';
//
// class UsersRepository {
//   final Request request;
//   final NetworkInfo networkInfo;
//   UsersRepository({required this.request, required this.networkInfo});
//
//   @override
//   Future<Either<Failure, Map<String, dynamic>>> loginUser(Map<String, dynamic> data) async {
//     if (!await networkInfo.isConnected) {
//       return const Left(NetworkFailure(AppMessages.noInternet));
//     }
//     try {
//       final response = await Request.post(url, data);
//       return Right(await Request.post(url, data));
//     } on Failure catch (e) {
//       return Left(e);
//     } catch (e) {
//       return Left(ServerFailure(e));
//     }
//   }
// }
