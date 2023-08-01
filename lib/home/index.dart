import 'package:flutter/material.dart';


// 欢迎页面
class WelcomeScreen extends StatelessWidget{
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 与路由有关的布局结构体
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("欢迎。。。。", style: Theme.of(context).textTheme.displayMedium),
            TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){
                      return states.contains(MaterialState.disabled) ? null : Colors.white; // 按钮文字颜色
                    }),
                    backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){
                      return states.contains(MaterialState.disabled) ? null : Colors.blue;
                    })
                ),
                onPressed: (){Navigator.of(context).pushNamed("/");}, child: const Text("返回"))
          ],
        )
    );
  }
}