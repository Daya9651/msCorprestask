import 'package:flutter/material.dart';
import 'package:demo_firebase/firebase_services/splash_services.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Welcome to', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            Text('MsCorpres Automation Pvt. Ltd.', style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
