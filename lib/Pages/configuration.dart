import 'package:flutter/material.dart';
class Configuration extends StatefulWidget{
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}
class _ConfigurationState extends State<Configuration> {
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
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Конфигурация', style: TextStyle(fontSize: 30, color: Colors.white, fontStyle: FontStyle.italic),),
          centerTitle: true,
          leading: IconButton(
              onPressed: (){
                _openMenu();
              },
              icon: Icon(Icons.menu))
      ),
      body: Container(
        child: new Row(
          children: <Widget>[
            new Expanded (
              flex:1,
              child : Column(
                children: <Widget>[ColoredBox(color: Colors.red)],
              ),),
            new Expanded(
              flex :2,
              child: Column(
                children: <Widget>[
                  new Text(
                      "This is a long text this is a long test this is This is a long text this is a long test this is This is a long text this is a long test this is This is a long text this is a long test this is This is a long text this is a long test this is This is a long text this is a long test this is ")
                ],
              ),)
          ],
        ),
      )
    );
  }
}