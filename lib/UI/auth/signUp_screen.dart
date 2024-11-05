import 'package:demo_firebase/UI/auth/login_screen.dart';
import 'package:demo_firebase/utlis/utils.dart';
import 'package:demo_firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  void signUp(){
    setState(() {
      loading = true ;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passController.text.toString()).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      setState(() {
        loading = false ;
      });

    }).onError((error, stackTrace){
      Utlis().toastMessage(error.toString());
      setState(() {
        loading = false ;
      });


    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          automaticallyImplyLeading: false,
          title: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),) ),
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
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Enter Your Email',
                            // helperText: 'email e.g daya@gmail.com',
                            prefix: Icon(Icons.person_2_outlined)
                        ),
                        // validator: (value){
                        //   if(value!.isEmpty){
                        //     return 'Enter Email';
                        //   }return null;
                        // },
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextFormField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: '  Enter Your Password',
                            prefix: Icon(Icons.lock_outline)
                          // helperText: 'email e.g daya@gmail.'
                        ),
                        // validator: (value){
                        //   if(value!.isEmpty){
                        //     return 'Enter Password';
                        //   }return null;
                        // },
                      ),
                    ),
                    SizedBox(height: 20,)

                  ],
                )),

            RoundButton(title: 'Sign Up',
              loading: loading,
              onTap: (){
              if(_formKey.currentState!.validate()){
                signUp();
              }
            },),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Don't have an account?",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));

                }, child: Text('Login ',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
