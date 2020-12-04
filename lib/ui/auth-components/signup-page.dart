import 'package:flutter/material.dart';
import 'package:safer_hackathon/classes/phone-number-formatter.dart';
import 'package:safer_hackathon/classes/social-id-formatter.dart';
import 'package:safer_hackathon/ui/auth-components/verify-page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // key to check the sign in form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final fullname = TextEditingController();
  final socialId = TextEditingController();
  final phoneNumber = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fullname.dispose();
    socialId.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

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
                padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
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
                      autofocus: true,
                      controller: fullname,
                      textCapitalization: TextCapitalization.words,
                      cursorColor: Color(0xFF364DB9),
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Color(0xFF364DB9),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF364DB9)),
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
                      controller: socialId,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        SocialIdFormatter(
                          mask: 'xxxx xxxx',
                          separator: ' ',
                        ),
                      ],
                      cursorColor: Color(0xFF364DB9),
                      decoration: InputDecoration(
                        labelText: 'Social Identity Number',
                        prefixIcon: Icon(
                          Icons.contacts,
                          color: Color(0xFF364DB9),
                        ),
                        hintText: "xxxx xxxx",
                        prefixText: "AZE ",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF364DB9)),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      controller: phoneNumber,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        PhoneNumberFormatter(
                          mask: '5x xxx xx xx',
                          separator: ' ',
                        ),
                      ],
                      cursorColor: Color(0xFF364DB9),
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        hintText: '5x xxx xx xx',
                        prefixText: "+994 ",
                        prefixIcon: Icon(
                          Icons.smartphone,
                          color: Color(0xFF364DB9),
                        ),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF364DB9)),
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
                    if (_formKey.currentState.validate()) {
                      var finalPhoneNumber =
                          '+994' + phoneNumber.text.replaceAll(" ", "");

                      var userSignUpInfo = {
                        'fullname': fullname.text,
                        'socialId': socialId.text,
                        'phoneNumber': finalPhoneNumber
                      };

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VerifyPhonePage(object: userSignUpInfo),
                        ),
                      );
                    }
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
