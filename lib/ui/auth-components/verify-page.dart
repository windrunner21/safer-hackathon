import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safer_hackathon/ui/home-page.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.reference();

class VerifyPhonePage extends StatefulWidget {
  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();

  final object;
  VerifyPhonePage({Key key, this.object}) : super(key: key);
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  // focus nodes for text fields - sms validation
  final FocusNode _focus1 = FocusNode();
  final FocusNode _focus2 = FocusNode();
  final FocusNode _focus3 = FocusNode();
  final FocusNode _focus4 = FocusNode();
  final FocusNode _focus5 = FocusNode();
  final FocusNode _focus6 = FocusNode();

  final _pin1 = TextEditingController();
  final _pin2 = TextEditingController();
  final _pin3 = TextEditingController();
  final _pin4 = TextEditingController();
  final _pin5 = TextEditingController();
  final _pin6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _phoneNumber =
        widget.object['phoneNumber'].toString().substring(0, 4) +
            ' (' +
            widget.object['phoneNumber'].toString().substring(4, 6) +
            ') ' +
            widget.object['phoneNumber'].toString().substring(6, 9) +
            ' ' +
            widget.object['phoneNumber'].toString().substring(9, 11) +
            ' ' +
            widget.object['phoneNumber']
                .toString()
                .substring(11, widget.object['phoneNumber'].toString().length);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF364DB9),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Enter the Code',
              style: TextStyle(
                  color: Color(0xFF364DB9),
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            Text(
              'to Verify Your Phone',
              style: TextStyle(
                  color: Color(0xFF364DB9),
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'We have sent you an SMS with a code to',
              style: TextStyle(color: Colors.grey[700]),
            ),
            Text(
              'the number ' + _phoneNumber,
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            // custom sms code entering
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // sms pin 1
                SizedBox(
                  width: MediaQuery.of(context).size.width / 12,
                  child: TextField(
                      controller: _pin1,
                      focusNode: _focus1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF364DB9),
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      onChanged: (str) {
                        if (str.length == 1) {
                          FocusScope.of(context).requestFocus(_focus2);
                        }
                      }),
                ),
                // sms pin 2
                SizedBox(
                  width: MediaQuery.of(context).size.width / 12,
                  child: TextField(
                      controller: _pin2,
                      focusNode: _focus2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF364DB9),
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      onChanged: (str) {
                        if (str.length == 0) {
                          FocusScope.of(context).requestFocus(_focus1);
                        }
                        if (str.length == 1) {
                          FocusScope.of(context).requestFocus(_focus3);
                        }
                      }),
                ),
                // sms pin 3
                SizedBox(
                  width: MediaQuery.of(context).size.width / 12,
                  child: TextField(
                      controller: _pin3,
                      focusNode: _focus3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF364DB9),
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      onChanged: (str) {
                        if (str.length == 0) {
                          FocusScope.of(context).requestFocus(_focus2);
                        }
                        if (str.length == 1) {
                          FocusScope.of(context).requestFocus(_focus4);
                        }
                      }),
                ),
                // sms pin 4
                SizedBox(
                  width: MediaQuery.of(context).size.width / 12,
                  child: TextField(
                      controller: _pin4,
                      focusNode: _focus4,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF364DB9),
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      onChanged: (str) {
                        if (str.length == 0) {
                          FocusScope.of(context).requestFocus(_focus3);
                        }
                        if (str.length == 1) {
                          FocusScope.of(context).requestFocus(_focus5);
                        }
                      }),
                ),
                // sms pin 5
                SizedBox(
                  width: MediaQuery.of(context).size.width / 12,
                  child: TextField(
                      controller: _pin5,
                      focusNode: _focus5,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF364DB9),
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      onChanged: (str) {
                        if (str.length == 0) {
                          FocusScope.of(context).requestFocus(_focus4);
                        }
                        if (str.length == 1) {
                          FocusScope.of(context).requestFocus(_focus6);
                        }
                      }),
                ),
                // sms pin 6
                SizedBox(
                  width: MediaQuery.of(context).size.width / 12,
                  child: TextField(
                    controller: _pin6,
                    focusNode: _focus6,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF364DB9),
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    onChanged: (str) async {
                      if (str.length == 0) {
                        FocusScope.of(context).requestFocus(_focus5);
                      }
                      if (str.length == 1) {
                        final _smsCode = _pin1.text +
                            _pin2.text +
                            _pin3.text +
                            _pin4.text +
                            _pin5.text +
                            _pin6.text;

                        FirebaseAuth auth = FirebaseAuth.instance;

                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: widget.object['phoneNumber'],
                          timeout: const Duration(seconds: 60),
                          verificationCompleted:
                              (PhoneAuthCredential credential) async {
                            User user =
                                (await auth.signInWithCredential(credential))
                                    .user;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(user: user.uid),
                              ),
                            );
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            if (e.code == 'invalid-phone-number') {
                              print('The provided phone number is not valid.');
                            } else {
                              print(e.code);
                            }
                          },
                          codeSent:
                              (String verificationId, int resendToken) async {
                            // Update the UI - wait for the user to enter the SMS code
                            String smsCode = _smsCode;

                            // Create a PhoneAuthCredential with the code
                            PhoneAuthCredential phoneAuthCredential =
                                PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: smsCode,
                            );

                            // Sign the user in (or link) with the credential
                            User user = (await auth
                                    .signInWithCredential(phoneAuthCredential))
                                .user;

                            databaseReference
                                .child('citizens')
                                .child(user.uid)
                                .set({
                              'fullName': widget.object['fullname'],
                              'socialNumber': widget.object['socialId'],
                              'phoneNumber': _phoneNumber,
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(user: user.uid),
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  'Send a new code',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
