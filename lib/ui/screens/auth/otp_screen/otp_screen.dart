// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:provider/provider.dart';
// import 'package:security_alarm_app/dependency_injections.dart';
// import 'package:security_alarm_app/logic/services/auth_service.dart';
// import 'package:security_alarm_app/ui/widgets/custom_buttton.dart';
//
// class OtpScreen extends StatelessWidget {
//   final String email;
//    OtpScreen(this.email,{Key? key}) : super(key: key);
//    AuthServices _authServices=sl();
//   final TextEditingController _pinPutController = TextEditingController();
//
//   final BoxDecoration pinPutDecoration = BoxDecoration(
//     color: const Color.fromRGBO(246, 244, 244, .9),
//     borderRadius: BorderRadius.circular(10.0),
//     border: Border.all(color: Colors.blueAccent),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               PinCodeTextField(
//                 length: 4,
//                 obscureText: false,
//                 appContext: context,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 animationType: AnimationType.fade,
//
//                 pinTheme: PinTheme(
//                   shape: PinCodeFieldShape.box,
//                   borderRadius: BorderRadius.circular(5),
//                   selectedFillColor: Colors.grey.withOpacity(.5),
//                   selectedColor: Colors.black,
//                   activeColor: Colors.black,
//                   inactiveFillColor: Colors.grey.withOpacity(.5),
//                   inactiveColor: Colors.black,
//                   disabledColor: Colors.black,
//                   fieldHeight: 50,
//                   fieldWidth: 40,
//
//
//                   activeFillColor: Colors.grey.withOpacity(.5),
//                 ),
//                 animationDuration: const Duration(milliseconds: 300),
//                 backgroundColor: Colors.transparent,
//                 enableActiveFill: true,
//                 controller: _pinPutController,
//                 keyboardType: TextInputType.number,
//                 onCompleted: (v) async {
//
//                 },
//                 onChanged: (value) async {
//
//                 },
//                 beforeTextPaste: (text) {
//                   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                   //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                   return false;
//                 },
//               ),
//               const SizedBox(height: 5,),
//               ElevatedButtonWidget(title: 'Verify', onPressed: (){
//                 _authServices.verifyPin(context,email);
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
