



import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../global_constants.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  static const LatLng pGooglePlex = const LatLng(-17.829220,31.052222);
  static const LatLng paApplePark = const LatLng(-17.785589,31.043004); //this must be the booker location
  LatLng? _currentP = null;

  Map<PolylineId,Polyline> polylines= {};

  @override
  void initState() {
    // TODO: implement initState



    //print
   // print("this is the current loca mama mmama"+" "+currentLocation.toString());
    super.initState();
    getLocationUpdates().then((_)=>{
      getPolylinePoints().then((coordinates) =>
      {
        generatePolylines(coordinates),
        print("loop the cordinates"+" "+coordinates.toString())
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_currentP==null? const Center(child: Text("Location Loading...."),):

      GoogleMap(
        onMapCreated: (GoogleMapController controller)=>_mapController.complete(controller),
          initialCameraPosition: CameraPosition(
             // target:pGooglePlex,
            target: _currentP!,
              zoom: 13
          ),
        markers: {
          Marker(
              markerId: MarkerId("_currentLocation"),
              position: _currentP!,//,
              infoWindow: InfoWindow(
                  title: "Google Plex"
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed
              )
          ),
           /* Marker(
              markerId: MarkerId("_sourceLocation"),
              position:pGooglePlex ,//,
              infoWindow: InfoWindow(
                title: "Google Plex"
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed
              )
            ),*/
          Marker(
              markerId: MarkerId("_destLocation"),
              position: paApplePark,//,
              infoWindow: InfoWindow(
                  title: "Apple Park"
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed
              )
          ),

        },
        polylines: Set<Polyline>.of(polylines.values),
    )
    );
  }
  Future<void>_cameraPosition(LatLng pos)async{
    final GoogleMapController controller = await _mapController.future;
  CameraPosition _newCameraPosition = CameraPosition(target: pos,zoom: 13);
  await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }
  Future<void>getLocationUpdates()async{
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await _locationController.serviceEnabled();
  if(_serviceEnabled){
    _serviceEnabled = await _locationController.requestService();

  }else{
    return;
  }
  _permissionGranted = await _locationController.hasPermission();
  if(_permissionGranted == PermissionStatus.denied){
    _permissionGranted = await _locationController.requestPermission();
    if(_permissionGranted != PermissionStatus.granted){
      return;
    }
  }
  _locationController.onLocationChanged.listen((LocationData currentLocation) {
    if(currentLocation.latitude != null && currentLocation.longitude != null){

      setState(() {
        _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
       // _currentP = LatLng(-17.7760866, 31.0279117);
        print("this is the current latitude"+" "+currentLocation.latitude.toString());
        print("this is the current longitude"+" "+currentLocation.longitude.toString());
        _cameraPosition(_currentP!);
      });
    }

  });
}
Future<List<LatLng>>getPolylinePoints()async{
  List<LatLng> _polylineCoordinates = [];
  PolylinePoints polylinePoints = new PolylinePoints();
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
       google_api_key,
      // PointLatLng(pGooglePlex.latitude,pGooglePlex.longitude),
    PointLatLng(_currentP!.latitude,_currentP!.longitude),
       PointLatLng(paApplePark.latitude,paApplePark.longitude),
       travelMode: TravelMode.driving,
    /*  wayPoints: [PolylineWayPoint(location: "SOME ADDRESS")],
      avoidHighways: false,
      avoidTolls: false,
      avoidFerries: false,
      optimizeWaypoints: false,*/
      );
  if(result.points.isNotEmpty){
    result.points.forEach((PointLatLng point){
      _polylineCoordinates.add(LatLng(point.latitude,point.longitude));
    });
}else{
  print(result.errorMessage);
  }
  return _polylineCoordinates;
}
void generatePolylines(List<LatLng>polylineCoordinates) async{
  PolylineId id = PolylineId("poly");
  Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 8,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
      geodesic: true
  );
 // polylines[id] = polyline;
  setState(() {
    polylines[id] = polyline;
  });

}

}
