

class Space with Piloted{
  String name;
  DateTime? launchDate;

  int? get launchYear => launchDate?.year;

  Space(this.name, this.launchDate){ // 初始化直接在形式变量里面

  }

  Space.unlaunched(): this("hzlzh", DateTime(2021));

  void describe(){
    print('Space: $name');
    var launchDate = this.launchDate;

    if(launchDate != null){
      int years = DateTime.now().difference(launchDate).inDays ~/ 365; // 除365取整
      print('Launched $launchYear ($years years ago)');
    }else{
      print("Unlaunched");
    }
  }

}

enum PlanetType{
  gas,
  ice
}

class Orbiter extends Space{
  double altitude;

  Orbiter(super.name, DateTime super.launchDate, this.altitude);
}

// 实例自动拥有其方法和属性
mixin Piloted{
  int astr = 1;

  void deCrew(){
    print("number of astr: $astr");
  }
}


// main是全局入口
// 需要在main里声明变量，
void main(){
  var sp = Space("hzzou", DateTime(2023));
  sp.describe();

  var sp1 = Space.unlaunched();
  sp1.describe();

  sp1.deCrew();
  print(sp1.astr);
  print(PlanetType.gas);
}