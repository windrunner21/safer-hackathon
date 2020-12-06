import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slider_button/slider_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;

  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Text(
            "SAFEr",
            style: GoogleFonts.audiowide(
              textStyle: TextStyle(color: Color(0xFF364DB9), fontSize: 50),
            ),
          ),
          Text(
            "Semi Automated Flexible Emergency Response",
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 40),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF364DB9),
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Noticed any danger? Let everybody know fast.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      icon: Icon(Icons.error),
                      color: Colors.white,
                      iconSize: 300,
                      onPressed: () {
                        _sendDangerType(context);
                      },
                    ),
                    Text(
                      'click the above button',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _sendDangerType(context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            var dangers = [
              {'id': 0, 'type': 'Landmine'},
              {'id': 1, 'type': 'Fire'},
              {'id': 2, 'type': 'Homicide'},
              {'id': 3, 'type': 'Earthquake'},
            ];

            return StatefulBuilder(
                builder: (BuildContext context, setState) =>
                    ListView(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 80, 30, 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    'Choose danger classification',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF364DB9),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.exit_to_app),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Divider(
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 20),
                            ExpansionPanelList.radio(
                              initialOpenPanelValue: dangers[0]['id'],
                              children: dangers.map<ExpansionPanelRadio>(
                                (danger) {
                                  return ExpansionPanelRadio(
                                    value: danger['id'],
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return ListTile(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                        title: Text(
                                          danger['type'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Color(0xFF364DB9),
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            'Near my Location',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                        ),
                                      );
                                    },
                                    body: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 20),
                                      child: Center(
                                        child: SliderButton(
                                          highlightedColor: Colors.red,
                                          vibrationFlag: true,
                                          action: () {
                                            _geolocator
                                                .getCurrentPosition(
                                                    desiredAccuracy:
                                                        LocationAccuracy.best)
                                                .then(
                                                    (Position position) async {
                                              databaseReference
                                                  .child("userDangers")
                                                  .push()
                                                  .set({
                                                "lat": position.latitude,
                                                "lng": position.longitude,
                                                "type": danger["type"]
                                              });
                                              print(danger["type"]);
                                              print(position.latitude);
                                            });

                                            Navigator.pop(context);
                                            final snackBar = SnackBar(
                                              content: Text(
                                                  'Thank you for your contribution in making world a safer place to live'),
                                              action: SnackBarAction(
                                                label: '',
                                                onPressed: () {},
                                              ),
                                            );

                                            _scaffoldKey.currentState
                                                .showSnackBar(snackBar);
                                          },
                                          label: Text(
                                            "Send SOS Signal",
                                            style: TextStyle(
                                                color: Color(0xff4a4a4a),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17),
                                          ),
                                          icon: Center(
                                            child: Icon(
                                              Icons.priority_high,
                                              color: Colors.red,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                      )
                    ]));
          },
        );
      },
    );
  }
}
