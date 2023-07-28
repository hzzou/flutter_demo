import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget{
  const SignUpForm({super.key}); // const 定义编译时构造函数常量

  @override
  State<SignUpForm> createState() => _FormState();
}

// 状态控制(下划线开头表示是私有类)
class _FormState extends State<SignUpForm>{
  // Dart 编译器会将任何带有下划线前缀标识的视为私有
  // 可以直接定义在controler属性后面，定义在此处是为了后面更新process
  final firstNameControl = TextEditingController(text: "初始值"); // text非必须
  final lastNameControl = TextEditingController(); // 只要是input框都有controller
  final userNameControl = TextEditingController();
  final _formKey = GlobalKey<FormState>(); //唯一标识，是FormState(因为嵌套在Form之内)不是_FormState
  final _formFieldKey = GlobalKey<FormFieldState>(); // 如果是formField单独用，则是FormFieldState
  final _lastNameNode = FocusNode();
  final _userNameNode = FocusNode();
  Map formObj = {};

  double _formProgress = 0;

  // 更新进度
  void _updateProgress(){
    var progress = 0.0;
    final controls = [
      firstNameControl,
      lastNameControl,
      userNameControl
    ];

    for(final control in controls){
      if(control.value.text.isNotEmpty){
        progress += 1/controls.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  void _showWelcome(){
    // _formKey.currentState!.validate(); // 触发所有表单的验证
    // _formKey.currentState!.save(); // 触发各个表单上的onSaved

    if(_formKey.currentState!.validate()){
      // 验证通过
      _formKey.currentState!.save(); // 触发各个表单上的onSaved
      print(formObj);
      Navigator.of(context).pushNamed( "/welcome");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("准备提交数据")));
    }

  }

  @override
  Widget build(BuildContext context) {
    /*return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          key: _formFieldKey,
          controller: TextEditingController(),
          decoration: const InputDecoration(
            labelText: "姓名:",
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontStyle: FontStyle.italic
            ),
            hintText: "提示文字"
          ),
          onSaved: (value){
            debugPrint("V: $value");
          },
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.black), // 按钮上的文字的颜色
            backgroundColor: MaterialStateProperty.all(Colors.blue)
          ),
          onPressed: (){
            // 基于key 触发TextFormField的onSave

            print(_formFieldKey.currentState!.save);
            _formFieldKey.currentState!.save();
          },
          child: const Text("保存")
        )
      ],
    );*/
    return Form(
      key: _formKey,
      onChanged: _updateProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimateProgress(value: _formProgress),
          Text("登录", style: Theme.of(context).textTheme.headlineMedium),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: firstNameControl,
                  decoration: const InputDecoration(hintText: '姓氏'),
                  onSaved: (value){
                    setState(() {
                      formObj["firstName"] = value; //不能用点
                    });
                  },
              )
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction, // 用户交互的时候就触发验证
                controller: lastNameControl,
                focusNode: _lastNameNode,
                decoration: const InputDecoration(
                    labelText: "名字:",
                    hintText: "请输入你的名字"
                ),
                validator: (value){
                  // 聚焦时清除错误信息(配合FormField自身的autovalidateMode：AutovalidateMode.onUserInteraction)
                  if(_lastNameNode.hasFocus){
                    return null;
                  }

                  if(value == null || value.isEmpty){
                    return "请输入名字";
                  }
                  return null; //默认返回null
                },
                onSaved: (value){
                  // 调用currentState!.save()时候触发
                  setState(() {
                    formObj["lastName"] = value; //不能用点
                  });
                },
              )
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: userNameControl,
                focusNode: _userNameNode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(hintText: "姓名"),
                validator: (value){
                  if(_userNameNode.hasFocus){
                    return null;
                  }

                  if(value == null || value.isEmpty){
                    return "请输入姓名";
                  }
                  return null; //默认返回null
                },
                onSaved: (value){
                  setState(() {
                    formObj["userName"] = value; //不能用点
                  });
                },
              )
          ),
          TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){
                    return states.contains(MaterialState.disabled) ? null : Colors.white; // 按钮文字颜色
                  }),
                  backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){
                    return states.contains(MaterialState.disabled) ? null : Colors.blue;
                  })
              ),
              // onPressed: _formProgress == 1 ? _showWelcome : null,
              onPressed: _showWelcome,
              child: const Text("提交")
          ),
        ],
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget{
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: const Center(
            child: SizedBox(
              width: 400,
              child: Card(
                child: SignUpForm(),
              ),
            )
        )
    );
  }
}

// 进度条动画
class AnimateProgress extends StatefulWidget{
  final double value;
  const AnimateProgress({super.key, required this.value});

  @override
  State<StatefulWidget> createState() {
    return _AnimatedProgressState();
  }
}

// 动画state
class _AnimatedProgressState extends State<AnimateProgress> with SingleTickerProviderStateMixin{
  // 延迟初始化
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => LinearProgressIndicator(
          value: _curveAnimation.value,
          valueColor: _colorAnimation,
          backgroundColor: _colorAnimation.value?.withOpacity(0.4),
        )
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);

    final colorTween = TweenSequence([
      TweenSequenceItem(tween: ColorTween(begin: Colors.red, end: Colors.orange), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.orange, end: Colors.yellow), weight: 1),
      TweenSequenceItem(tween: ColorTween(begin: Colors.yellow, end: Colors.green), weight: 1)
    ]);

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(covariant AnimateProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    _controller.animateTo(widget.value);
  }


}