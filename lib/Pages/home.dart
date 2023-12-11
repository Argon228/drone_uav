import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup>{
  final List<String> users = ["1v", "2v", "3v", "4v", "5v"];
  int selectedIndex = -1;
  void road()async{
    await mapController.drawRoad(
      GeoPoint(latitude: 	55.81838, longitude: 37.41224),
      GeoPoint(latitude: 55.751999, longitude: 37.617734),
      roadType: RoadType.foot,
      intersectPoint : [GeoPoint(latitude: 66, longitude: 28)],
      roadOption: RoadOption(
      roadWidth: 5,
      roadColor: Colors.blue,
      zoomInto: true,
    ),
    );
  }
  MapController mapController = MapController.customLayer(
    initMapWithUserPosition: UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
      areaLimit: BoundingBox(
        east: 10.4922941,
        north: 47.8084648,
        south: 45.817995,
        west:  5.9559113,
      ),
    customTile: CustomTile(
      sourceName: "opentopomap",
      tileExtension: ".png",
      minZoomLevel: 2,
      maxZoomLevel: 19,
      urlsServers: [
        TileURLs(
          url: "https://tile.opentopomap.org/",
          subdomains: [],
        )
      ],
      tileSize: 256,
    ),
  );

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.green,
        title: Text('OWL EYE Навигация', style: TextStyle(fontSize: 30, color: Colors.white, fontStyle: FontStyle.italic),),
        centerTitle: true,
        actions: [IconButton(
            onPressed: (){
              road();
            },
            icon: Icon(Icons.add_chart)),],
        leading:
          IconButton(
              onPressed: (){
                _openMenu();
              },
              icon: Icon(Icons.menu))),
      body: SafeArea(
        child:
        OSMFlutter(
            controller:mapController,
            osmOption: OSMOption(
              userTrackingOption: UserTrackingOption(
                enableTracking: true,
                unFollowUser: false,
              ),
              zoomOption: ZoomOption(
                initZoom: 16,
                minZoomLevel: 3,
                maxZoomLevel: 19,
                stepZoom: 1.0,
              ),
              userLocationMarker: UserLocationMaker(
                personMarker: MarkerIcon(
                  icon: Icon(
                    Icons.location_history_rounded,
                    color: Colors.red,
                    size: 48,
                  ),
                ),
                directionArrowMarker: MarkerIcon(
                  icon: Icon(
                    Icons.double_arrow,
                    size: 48,
                  ),
                ),
              ),
              roadConfiguration: RoadOption(
                roadColor: Colors.yellowAccent,
              ),
              markerOption: MarkerOption(
                  defaultMarker: MarkerIcon(
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 56,
                    ),
                  )
              ),
            )
        ),
      ),
    );

  }
}
