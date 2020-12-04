import 'package:flutter/material.dart';
import 'package:safer_hackathon/ui/auth-components/verify-page.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // key to check the forget password form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Forgot Password?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 20),
              Text('If you need help resetting your password,'),
              Text('we can help by sending you a link to reset it.'),
              SizedBox(height: 20),
              TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: ' (5x) xxx xx xx',
                  prefixText: '+994 ',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Icon(Icons.smartphone, color: Colors.black),
                  ),
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
                            builder: (context) => VerifyPhonePage()));
                  },
                  color: Colors.black,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  elevation: 4.0,
                  child:
                      Text('Send Code', style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
