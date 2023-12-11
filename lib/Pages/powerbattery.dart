import 'package:flutter/material.dart';
import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
class PowerBattery extends StatefulWidget{
  const PowerBattery({super.key});

  @override
  State<PowerBattery> createState() => _PowerBatteryState();
}
class _PowerBatteryState extends State<PowerBattery> {
  void _openMenu(){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context){
          return Drawer(
              child: new ListView(
                children: <Widget>[
                  ListTile(
                    title: const Text('Навигация',style: TextStyle(fontSize: 26),),
                    onTap: () {Navigator.pushReplacementNamed(context, '/');},
                  ),
                  ListTile(title: const Text('Конфигурация',style: TextStyle(fontSize: 26),),onTap: () {Navigator.pushReplacementNamed(context, '/conf');}),
                  ListTile(title: const Text('Отказобезопасность',style: TextStyle(fontSize: 26),),onTap: () {Navigator.pushNamed(context, '/fail');}),
                  ListTile(title: const Text('Питание и Батарея',style: TextStyle(fontSize: 26),),onTap: () {Navigator.pushReplacementNamed(context, '/poba');}),
                  ListTile(title: const Text('Порты',style: TextStyle(fontSize: 26),),onTap: () {Navigator.pushReplacementNamed(context, '/port');}),
                  ListTile(title: const Text('Видео',style: TextStyle(fontSize: 26),),onTap: () {Navigator.pushReplacementNamed(context, '/vid');}),
                  Divider(color: Colors.black87),
                  ListTile(title: const Text('Сообщить об ошибке',style: TextStyle(fontSize: 26),),onTap: () {}),
                ],));
        })
    );
  }

  var battery = Battery();
  int percentage = 0;
  late Timer timer;

  BatteryState batteryState = BatteryState.full;
  late StreamSubscription streamSubscription;


  @override
  void initState() {
    super.initState();
    getBatteryState();
    getBatteryPerentage();
    Timer.periodic(const Duration(seconds: 15), (timer) {
      getBatteryPerentage();

    });
  }

  void getBatteryPerentage() async {
    final level = await battery.batteryLevel;
    percentage = level;

    setState(() {});
  }


  void getBatteryState() {
    streamSubscription = battery.onBatteryStateChanged.listen((state) {
      batteryState = state;

      setState(() {});
    });
  }

  Widget BatteryBuild(BatteryState state) {
    switch (state) {

      case BatteryState.full:

        return Container(
          width: 200,
          height: 200,

          child: (Icon(
            Icons.battery_full,
            size: 200,
            color: Colors.green,
          )),
        );

      case BatteryState.charging:

        return Container(
          width: 200,
          height: 200,

          child: (Icon(
            Icons.battery_charging_full,
            size: 200,
            color: Colors.blue,
          )),
        );

      case BatteryState.discharging:
      default:

        return Container(
          width: 200,
          height: 200,

          child: (Icon(
            Icons.battery_alert,
            size: 200,
            color: Colors.red,
          )),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
          title: Text('Питание и батарея', style: TextStyle(fontSize: 30, color: Colors.white, fontStyle: FontStyle.italic),),
        centerTitle: true,
          leading: IconButton(
              onPressed: (){
                _openMenu();
              },
              icon: Icon(Icons.menu))
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children:[

            BatteryBuild(batteryState),

            Text('Заряд батареи: $percentage',
              style: const TextStyle(fontSize: 24),)
          ],
        ),
      ),
    );
  }
}