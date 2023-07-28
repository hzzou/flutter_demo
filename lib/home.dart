import 'package:flutter/material.dart';


// 欢迎页面
class WelcomeScreen extends StatelessWidget{
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 与路由有关的布局结构体
    return Scaffold(
        body: Center(
            child: Text("欢迎。。。。", style: Theme.of(context).textTheme.displayMedium)
        )
    );
  }
}