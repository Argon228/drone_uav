import 'package:drone_uav/Pages/failsafe.dart';
import 'package:flutter/material.dart';
import 'package:drone_uav/Pages/home.dart';
import 'package:drone_uav/Pages/ports.dart';
import 'package:drone_uav/Pages/powerbattery.dart';
import 'package:drone_uav/Pages/configuration.dart';
import 'package:drone_uav/Pages/video.dart';
void main() => runApp(MaterialApp(
  theme: ThemeData(primaryColor: Colors.black12),
  initialRoute: '/',
routes: {
    '/': (context) => Setup(),
    '/fail': (context) => FailSafe(),
    '/port': (context) => Ports(),
    '/poba': (context) => PowerBattery(),
    '/conf': (context) => Configuration(),
    '/vid': (context) => Video(),
},));