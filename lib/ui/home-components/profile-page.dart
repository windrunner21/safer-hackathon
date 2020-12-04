import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:safer_hackathon/classes/phone-number-formatter.dart';

final databaseReference = FirebaseDatabase.instance.reference();

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            Container(
              color: Color(0xFF5b70d9),
              width: double.infinity,
            ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.black26,
                child: Text(
                  'IH',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 150),
                child: Text(
                  'Imran Hajiyev',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3.3,
              right: 30,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: ListTile(
                            onTap: () {
                              _setEmergencyContacts(context);
                            },
                            leading: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.contact_phone,
                                color: Color(0xFF364DB9),
                              ),
                            ),
                            title: Text(
                              'Emergency Contacts',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                size: 25,
                                color: Color(0xFF364DB9),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                          color: Colors.black38,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            onTap: () {},
                            leading: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.account_circle,
                                color: Color(0xFF364DB9),
                              ),
                            ),
                            title: Text('Account',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            trailing: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                size: 25,
                                color: Color(0xFF364DB9),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: ListTile(
                            onTap: () {},
                            leading: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.lock,
                                color: Color(0xFF364DB9),
                              ),
                            ),
                            title: Text(
                              'Password',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                size: 25,
                                color: Color(0xFF364DB9),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                          color: Colors.black38,
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.language,
                              color: Color(0xFF364DB9),
                            ),
                          ),
                          title: Text(
                            'Language',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: 25,
                              color: Color(0xFF364DB9),
                            ),
                          ),
                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                          color: Colors.black38,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            onTap: () {},
                            leading: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.import_contacts,
                                color: Color(0xFF364DB9),
                              ),
                            ),
                            title: Text(
                              'User Agreement',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                size: 25,
                                color: Color(0xFF364DB9),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _setEmergencyContacts(context) async {
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
            final emergencyName = TextEditingController();
            final emergencySurname = TextEditingController();
            final emergencyPhoneNumber = TextEditingController();

            List<Widget> widgetList = [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Contact #1",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF364DB9),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextField(
                          controller: emergencyName,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF364DB9),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            hintText: 'Name',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextField(
                          controller: emergencySurname,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF364DB9),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            hintText: 'Surname',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    child: TextField(
                      controller: emergencyPhoneNumber,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        PhoneNumberFormatter(
                          mask: '5x xxx xx xx',
                          separator: ' ',
                        ),
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF364DB9),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          prefixText: '+994 ',
                          prefixIcon: Icon(
                            Icons.smartphone,
                            color: Color(0xFF364DB9),
                          ),
                          hintText: '(5x) xxx xx xx'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ];

            return StatefulBuilder(
                builder: (BuildContext context, setState) => ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 80, 30, 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "Add emergency contacts",
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
                                      // await FirebaseAuth.instance.signOut();
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              Divider(
                                color: Colors.grey[400],
                              ),
                              // start
                              for (var list in widgetList) list,
                              // end
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  RaisedButton(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    onPressed: () {
                                      setState(() {
                                        widgetList.add(
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Contact #" +
                                                        (widgetList.length + 1)
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xFF364DB9),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    child: RaisedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          widgetList
                                                              .removeLast();
                                                        });
                                                      },
                                                      child: Text(
                                                        'Remove',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      color: Colors.white,
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        side: BorderSide(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                    child: TextField(
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFF364DB9),
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black12),
                                                        ),
                                                        hintText: 'Name',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                    child: TextField(
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFF364DB9),
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black12),
                                                        ),
                                                        hintText: 'Surname',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 15),
                                              SizedBox(
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  inputFormatters: [
                                                    PhoneNumberFormatter(
                                                      mask: '5x xxx xx xx',
                                                      separator: ' ',
                                                    ),
                                                  ],
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF364DB9),
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black12),
                                                      ),
                                                      prefixText: '+994 ',
                                                      prefixIcon: Icon(
                                                        Icons.smartphone,
                                                        color:
                                                            Color(0xFF364DB9),
                                                      ),
                                                      hintText:
                                                          '(xx) xxx xx xx'),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Divider(
                                                color: Colors.grey[400],
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xFF364DB9),
                                    ),
                                    color: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side:
                                          BorderSide(color: Color(0xFF364DB9)),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: RaisedButton(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      onPressed: () async {
                                        final FirebaseAuth auth =
                                            FirebaseAuth.instance;
                                        final User user = auth.currentUser;
                                        var finalPhoneNumber = '+994' +
                                            emergencyPhoneNumber.text
                                                .replaceAll(" ", "");

                                        databaseReference
                                            .child('citizens')
                                            .child(user.uid)
                                            .child('emergencyContacts')
                                            .set({
                                          'fullName': emergencyName.text +
                                              ' ' +
                                              emergencySurname.text,
                                          'phoneNumber': finalPhoneNumber,
                                        });
                                        // await FirebaseAuth.instance.signOut();
                                        Navigator.pop(context);
                                      },
                                      color: Color(0xFF364DB9),
                                      elevation: 0,
                                      child: Text(
                                        'Done',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ));
          },
        );
      },
    );
  }
}
