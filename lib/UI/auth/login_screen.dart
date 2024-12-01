import 'package:demo_firebase/UI/auth/signUp_screen.dart';
import 'package:demo_firebase/UI/upload_image.dart';
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
          Utils.showSnackbar(context, value.user!.email.toString());
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
          UploadImageScreen()));
          setState(() {
            loading = false;
          });

    }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utils.showSnackbar(context, error.toString());
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
          ],
        ),
      ),
    );
  }
}
