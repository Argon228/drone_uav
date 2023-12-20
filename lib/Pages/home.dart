import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';

class Setup extends StatefulWidget {
  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  final MapController mapController = MapController();
  List<LatLng> points = [];
  List<Map<String, double>> pointsData = [];

  void _handleTap(LatLng latlng) {
    setState(() {
      points.add(latlng);
      pointsData.add({
        'latitude': latlng.latitude,
        'longitude': latlng.longitude,
      });
    });
  }


  void _resetMarkers() {
    setState(() {
      points.clear();
    });
  }

  List<Polyline> _buildPolylines() {
    var polylineList = <Polyline>[];
    if (points.length > 1) {
      polylineList.add(
        Polyline(
          points: [...points, points.first],
          strokeWidth: 2.0,
          isDotted: true,
          color: Colors.deepPurple,
        ),
      );
    }
    return polylineList;
  }

  List<Marker> _buildMarkers() {
    return points.asMap().entries.map((entry) {
      int idx = entry.key;
      LatLng latlng = entry.value;
      return Marker(
        width: 80,
        height: 80,
        point: latlng,
        builder: (ctx) => Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
          Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 1, color: Colors.black)
          ),
          child: Icon(
            Icons.location_on,
            color: Colors.deepPurple,
            size: 20,
          ),
        ),
              Positioned(
                bottom: -5,
                child: Text(
                  '${idx + 1}', // Номер маркера
                  style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                      )
                  )
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
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
  Widget build(BuildContext context) {
    var polylines = _buildPolylines();
    var markers = _buildMarkers();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('OWL EYE Map', style: TextStyle(fontSize: 30, color: Colors.white, fontStyle: FontStyle.italic),),
          centerTitle: true,
          leading: IconButton(
              onPressed: (){
                _openMenu();
              },
              icon: Icon(Icons.menu))
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: LatLng(55.8, 37.43),
          zoom: 15.0,
          onTap: (_, latlng) => _handleTap(latlng),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: polylines,
          ),
          MarkerLayer(
            markers: markers,
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _resetMarkers,
            child: Icon(Icons.delete),
            tooltip: 'Reset Markers',
            backgroundColor: Colors.red,
            heroTag: 'reset',
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}