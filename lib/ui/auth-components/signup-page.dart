import 'package:flutter/material.dart';
import 'package:safer_hackathon/ui/home-page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // key to check the sign in form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5b70d9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Create your account",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        helperText: "ex. Name Surname",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Color(0xFF364DB9),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your social indentity number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Social Identity Number',
                        prefixIcon: Icon(
                          Icons.contacts,
                          color: Color(0xFF364DB9),
                        ),
                        helperText: "ex. AZE xxxx xxxx",
                        prefixText: "AZE ",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54),
                      ),
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        helperText: 'ex. +994 (5x) xxx xx xx',
                        prefixText: "+994 ",
                        prefixIcon: Icon(
                          Icons.smartphone,
                          color: Color(0xFF364DB9),
                        ),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54),
                      ),
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        helperText: "ex. 1 uppercase, 1 digit, length > 8",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFF364DB9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 15, color: Color(0xFF364DB9)),
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
