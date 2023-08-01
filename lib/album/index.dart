import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

// 有状态widget和无状态widget
class AlbumScreen extends StatelessWidget{
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: Stack(
        children: [
          Container(
            width: 0.7.sw,
            height: 0.7.sh,
            color: Colors.red,
          ),
          Container(
            width: 0.6.sw,
            height: 0.6.sh,
            color: Colors.green,
          ),
          Container(
            width: 0.5.sw,
            height: 0.5.sh,
            color: Colors.blue,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 100, horizontal: 60),
              child: Text("HzlzH")
            ),
          )
        ],
      )*/
      body: Row( //使用Row时，子元素需要使用Expanded包裹
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                      labelText: "姓名:",
                      hintText: "请输入姓名"
                  ),
              ),
              )
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  obscureText: true, // 隐藏，密码
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                      labelText: "密码:",
                      hintText: "请输入密码"
                  ),
                ),
              )
          ),
        ]
      )
    );
  }


}