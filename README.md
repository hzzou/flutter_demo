
#### 记录

* 在浏览器上的启动命令flutter run -d "chrome"
* 在IOS模拟器上的运行命令flutter run -d "iPhone 14"(模拟器名称)
* 在安卓模拟器上的运行命令flutter run -d "emulator-5554"(adb devices获得的名称)
* 使用adb connect链接本地模拟器时，端口号比模拟器后缀多1，adb connect 127.0.0.1:5555
* 在pubspec.yaml的dependences下添加依赖,运行flutter pub get安装依赖
* 配置项目的flutter SDK需要安装flutter插件工具Language才会显示flutter配置，
* 若要单独配置dart SDK,同理需要安装dart插件工具Language才会显示dart配置
* 下载flutter SDK后，一是配置全局flutter环境变量，二是运行SDK里面的dart命令安装dart SDK
* 查看flutter频道命令flutter channel, 进行选择flutter channel  [<channel-name>] 