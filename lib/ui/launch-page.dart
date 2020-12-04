import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safer_hackathon/ui/auth-components/login-page.dart';
import 'package:safer_hackathon/ui/auth-components/signup-page.dart';

class LaunchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.contact_support, color: Color(0xFF364DB9)),
                  iconSize: 40,
                  onPressed: () {
                    _settingModalBottomSheet(context);
                  },
                ),
              ),
              Column(
                children: [
                  Text(
                    "SAFEr",
                    style: GoogleFonts.audiowide(
                      textStyle:
                          TextStyle(color: Color(0xFF364DB9), fontSize: 50),
                    ),
                  ),
                  Text(
                    "Semi Automated Flexible Emergency Response",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Login',
                        style:
                            TextStyle(color: Color(0xFF364DB9), fontSize: 16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: Color(0xFF364DB9),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      color: Color(0xFF364DB9),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _settingModalBottomSheet(context) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 40, 25, 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Text(
                      'Have Questions?',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF364DB9),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton.icon(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: Text(
                        'Contact Us',
                        style:
                            TextStyle(color: Color(0xFF364DB9), fontSize: 16),
                      ),
                      icon: Icon(Icons.support_agent, color: Color(0xFF364DB9)),
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: Color(0xFF364DB9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
