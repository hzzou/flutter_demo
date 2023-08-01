
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login/index.dart';
import 'home/index.dart';
import 'album/index.dart';

class SignUp extends StatelessWidget{
  const SignUp({super.key});

  @override
  Widget build(BuildContext context){
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){ //必须填写child，不然标红
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'HeiTi'), // 全局默认字体
          routes: {
            "/" : (context) => const AlbumScreen(),
            // "/": (context) => const SignUpScreen(),
            "/welcome": (context) => const WelcomeScreen()
          }
        );
      }
    );
  }

}

void main() async{
  // ScreenUtil.init(context, designSize: const Size(750, 1334), minTextAdapt: true, splitScreenMode: true);
  runApp(const SignUp());
}