import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login.dart';
import 'home.dart';

class SignUp extends StatelessWidget{
  const SignUp({super.key});

  @override
  Widget build(BuildContext context){
    //
    // ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context)
    print("an: $ScreenUtil");
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const SignUpScreen(),
        "/welcome": (context) => const WelcomeScreen()
      },
    );
  }

}

void main(){
  runApp(const SignUp());
}