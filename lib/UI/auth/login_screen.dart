import 'package:demo_firebase/UI/auth/login_with_phoneNumber.dart';
import 'package:demo_firebase/UI/auth/signUp_screen.dart';
import 'package:demo_firebase/UI/posts/post_screen.dart';
import 'package:demo_firebase/utlis/utils.dart';
import 'package:demo_firebase/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }
   void logIn(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passController.text.toString()).then((value){
          Utlis().toastMessage(value.user!.email.toString());
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
          PostScreen()));
          setState(() {
            loading = false;
          });

    }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utlis().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        title: Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),) ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),

                        ),
                          hintText: 'Enter Your Email',
                          // helperText: 'email e.g daya@gmail.com',
                        // prefix: Icon(Icons.person_2_outlined)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Email';
                        }return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Password',
                          // prefix: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),

                          // helperText: 'email e.g daya@gmail.'
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Password';
                        } return null;
                      },
                    ),
                    SizedBox(height: 20,)

                  ],
                )),

            RoundButton(title: 'Login',
              loading: loading,
              onTap: (){
              if(_formKey.currentState!.validate());
              logIn();
            },),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Don't have an account?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                  }, child: Text('Sign Up', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),))
                ],
              ),
            ),
            SizedBox(height: 40,),

            InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>PhoneVerificationScreen()) );
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)
                ),
                child: Center(
                  child: Text("Login with Phone", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
