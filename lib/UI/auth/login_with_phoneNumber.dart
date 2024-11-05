// import 'package:demo_firebase/UI/auth/verify_otp.dart';
// import 'package:demo_firebase/utlis/utils.dart';
// import 'package:demo_firebase/widgets/round_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class LoginWithPhonenumber extends StatefulWidget {
//   const LoginWithPhonenumber({super.key});
//
//
//   @override
//   State<LoginWithPhonenumber> createState() => _LoginWithPhonenumberState();
// }
//
// class _LoginWithPhonenumberState extends State<LoginWithPhonenumber> {
//   bool loading = false;
//   final phoneNumberController = TextEditingController();
//   final auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue.shade900,
//         title: Text("LogIn Page", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           children: [
//             SizedBox(height: 50,),
//             Container(
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(10)
//               ),
//               child: TextFormField(
//                 controller: phoneNumberController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   hintText: ' +91 75181913XX'
//                 ),
//               ),
//             ),
//             SizedBox(height: 30,),
//             RoundButton(title: 'Login',
//                 loading: loading,
//                 onTap: (){
//               setState(() {
//                 loading = true;
//               });
//               auth.verifyPhoneNumber(
//                 phoneNumber: phoneNumberController.text,
//                   verificationCompleted: (_){
//                     setState(() {
//                       loading = false;
//                     });
//
//                   },
//                   verificationFailed: (e){
//                     setState(() {
//                       loading = false;
//                     });
//                   Utlis().toastMessage(e.toString());
//                   },
//                   codeSent: (String verificationId, int ?token){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>
//                   VerifyOtpScreen(verificationId: verificationId,)));
//
//                   },
//                   codeAutoRetrievalTimeout: (e){
//                     setState(() {
//                       loading = false;
//                     });
//                   Utlis().toastMessage(e.toString());
//                   });
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:demo_firebase/UI/auth/verify_otp.dart';
import 'package:demo_firebase/utlis/utils.dart';
import 'package:demo_firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final phonenumberController = TextEditingController();
  var isloading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Phone"),
      ),
      body: Column(
        children: [
          SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: TextFormField(
              controller: phonenumberController,
              decoration: InputDecoration(
                hintText: "+91 0000010000",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black38),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black38),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          RoundButton(
              loading: isloading,
              title: "Verify Your Number",
              onTap: () {
                setState(() {
                  isloading = true;
                });
                auth.verifyPhoneNumber(
                    phoneNumber: phonenumberController.text,
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      Utlis().toastMessage(e.toString());
                    },
                    codeSent: ((verificationId, forceResendingToken) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhoneOtpScreen(
                            verificationId: verificationId,
                          ),
                        ),
                      );
                      setState(() {
                        isloading = false;
                      });
                    }),
                    codeAutoRetrievalTimeout: (e) {
                      Utlis().toastMessage(e.toString());
                    });
              }),
        ],
      ),
    );
  }
}