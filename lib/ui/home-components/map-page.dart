import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_map_polyline/google_map_polyline.dart';

// 40.364237
// 49.821660
class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final databaseReference = FirebaseDatabase.instance.reference();

// Initial location of the Map view
  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(40.364237, 49.821660), zoom: 18.0);
// For controlling the view of the Map
  GoogleMapController mapController;

  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;
  Set<Circle> _circles = HashSet<Circle>();
  Set<Marker> _markers = HashSet<Marker>();
  // Set<Polyline> polyline = {};
  // List<LatLng> routeCoords;

  int _circleIdCounter = 1;
  int _markerIdCounter = 1;
  String googleAPIKey = "AIzaSyCmRV4g0sR4JYwjzHGg-AmISbCjAVi42P0";

  // GoogleMapPolyline googleMapPolyline =
  //     new GoogleMapPolyline(apiKey: "AIzaSyCmRV4g0sR4JYwjzHGg-AmISbCjAVi42P0");

  // getSomePoints(LatLng destination) async {
  //   setState(() async {
  //     routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
  //         origin: LatLng(_currentPosition.latitude, _currentPosition.longitude),
  //         destination: destination,
  //         mode: RouteMode.driving);
  //   });
  // }

  _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text("Danger Alert!"),
              content: new Text(
                  "You are in danger! Seek immediate shelter or leave the danger zone!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        print('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    databaseReference
        .child('safezones')
        .once()
        .then((DataSnapshot snapshot) async {
      for (var safezone in snapshot.value.values) {
        print(safezone["lat"]);
        final String markerIdVal = 'marker_id_$_markerIdCounter';
        _markerIdCounter++;
        if (_markerIdCounter == 2) {
          // getSomePoints(LatLng(safezone["lat"], safezone["lng"]));
        }
        setState(() {
          _markers.add(Marker(
              markerId: MarkerId(markerIdVal),
              position: LatLng(safezone["lat"], safezone["lng"])));
        });
      }
    });

    databaseReference
        .child('incomingMissiles')
        .onChildAdded
        .listen((event) async {
      print(event.snapshot.value);

      await _geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position currentPosition) async {
        // Calculating the distance between the start and the end positions
// with a straight path, without considering any route
        double distanceInMeters = await _geolocator.distanceBetween(
          event.snapshot.value["lat"].toDouble(),
          event.snapshot.value["lng"].toDouble(),
          currentPosition.latitude,
          currentPosition.longitude,
        );
        if (distanceInMeters <= event.snapshot.value["radius"]) {
          _showCupertinoDialog();
        }
        // if (distanceInMeters <= event.snapshot.value["radius"]) {
        setState(() {
          final String circleIdVal = 'circle_id_$_circleIdCounter';
          _circleIdCounter++;
          _circles.add(Circle(
              circleId: CircleId(circleIdVal),
              center: LatLng(event.snapshot.value["lat"].toDouble(),
                  event.snapshot.value["lng"].toDouble()),
              radius: event.snapshot.value["radius"].toDouble(),
              fillColor: Colors.redAccent.withOpacity(0.5),
              strokeWidth: 3,
              strokeColor: Colors.redAccent));
        });
        // }
      });
    });

    databaseReference.child('userDangers').onChildAdded.listen((event) async {
      print(event.snapshot.value);

      await _geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position currentPosition) async {
        // Calculating the distance between the start and the end positions
// with a straight path, without considering any route
        double distanceInMeters = await _geolocator.distanceBetween(
          event.snapshot.value["lat"].toDouble(),
          event.snapshot.value["lng"].toDouble(),
          currentPosition.latitude,
          currentPosition.longitude,
        );
        var dangerType = event.snapshot.value["type"];
        var radius = dangerType == "Landmine"
            ? 5
            : dangerType == "Fire"
                ? 10
                : dangerType == "Homicide"
                    ? 5
                    : 50;
        if (distanceInMeters <= radius.toDouble()) {
          _showCupertinoDialog();
        }

        // if (distanceInMeters <= event.snapshot.value["radius"]) {
        setState(() {
          final String circleIdVal = 'circle_idd_$_circleIdCounter';
          _circleIdCounter++;
          _circles.add(Circle(
            circleId: CircleId(circleIdVal),
            center: LatLng(event.snapshot.value["lat"].toDouble(),
                event.snapshot.value["lng"].toDouble()),
            radius: radius.toDouble(),
            fillColor: dangerType == "Landmine"
                ? Colors.purpleAccent.withOpacity(0.5)
                : dangerType == "Fire"
                    ? Colors.orangeAccent.withOpacity(0.5)
                    : dangerType == "Homicide"
                        ? Colors.amberAccent.withOpacity(0.5)
                        : Colors.limeAccent.withOpacity(0.5),
            strokeWidth: 3,
            strokeColor: dangerType == "Landmine"
                ? Colors.purpleAccent
                : dangerType == "Fire"
                    ? Colors.orangeAccent
                    : dangerType == "Homicide"
                        ? Colors.amberAccent
                        : Colors.limeAccent,
          ));
        });
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // databaseReference
    //     .child('incomingMissiles')
    //     .once()
    //     .then((DataSnapshot data) {
    //   setState(() {
    //     final String circleIdVal = 'circle_id_$_circleIdCounter';
    //     _circleIdCounter++;
    //     _circles.add(Circle(
    //         circleId: CircleId(circleIdVal),
    //         center: LatLng(
    //             data.value["lat"].toDouble(), data.value["lng"].toDouble()),
    //         radius: data.value["radius"].toDouble(),
    //         fillColor: Colors.redAccent.withOpacity(0.5),
    //         strokeWidth: 3,
    //         strokeColor: Colors.redAccent));
    //   });
    // });

    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              circles: _circles,
              markers: _markers,
              // polylines: polyline,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                // polyline.add(Polyline(
                //     polylineId: PolylineId("route1"),
                //     visible: true,
                //     points: routeCoords,
                //     width: 4,
                //     color: Colors.blue,
                //     startCap: Cap.roundCap,
                //     endCap: Cap.buttCap));
                _getCurrentLocation();
              },
            ),
            // Show zoom buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.blue[100], // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.add),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Colors.blue[100], // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.remove),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange[100], // button color
                      child: InkWell(
                        splashColor: Colors.orange, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
