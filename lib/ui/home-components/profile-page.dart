import 'package:flutter/material.dart';
import 'package:safer_hackathon/ui/auth-components/forgot-password-page.dart';

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
}

Future<void> _setEmergencyContacts(context) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 40, 30, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Text(
                    "Add emergency contacts",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5b70d9),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Divider(
                  color: Colors.grey[400],
                ),
                SizedBox(height: 10),
                Text(
                  "Description",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Divider(
                  color: Colors.grey[400],
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Color(0xFF5b70d9),
                    elevation: 4.0,
                    child: Text(
                      'Go Back',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                  ),
                )
              ],
            ),
          )
        ],
      );
    },
  );
}
