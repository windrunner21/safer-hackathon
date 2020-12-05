import 'package:bubble/bubble.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final databaseReference = FirebaseDatabase.instance.reference();
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;

class DetailedChat extends StatefulWidget {
  @override
  _DetailedChatState createState() => _DetailedChatState();
  final receiver;
  final messages;
  final messageId;
  DetailedChat({Key key, this.receiver, this.messages, this.messageId})
      : super(key: key);
}

class _DetailedChatState extends State<DetailedChat>
    with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  var messagesList = [];

  @override
  void initState() {
    super.initState();
    databaseReference
        .child('messages')
        .child(widget.messageId)
        .child('messageList')
        .onChildAdded
        .listen((event) {
      setState(() {
        messagesList.add(event.snapshot.value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF364DB9), //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 5, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.receiver,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF364DB9)),
                ),
                Transform.rotate(
                  angle: 260 * 3.14 / 180,
                  child: IconButton(
                    icon: Icon(
                      Icons.phone,
                      color: Color(0xFF364DB9),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messagesList.length,
              itemBuilder: (context, index) {
                var reversedList = new List.from(messagesList.reversed);
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: reversedList[index]['sender'] == 0
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      reversedList[index]['sender'] == 0
                          ? Container(
                              margin: const EdgeInsets.only(left: 5, right: 10),
                              child: CircleAvatar(
                                child: Text(
                                  widget.receiver[0],
                                  style: TextStyle(fontSize: 20),
                                ),
                                backgroundColor: Colors.grey[700],
                              ),
                            )
                          : Container(),
                      Expanded(
                        child: Bubble(
                          child: Column(
                            crossAxisAlignment:
                                reversedList[index]['sender'] == 0
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                reversedList[index]['sender'] == 0
                                    ? widget.receiver
                                    : "Me",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.white),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  aesEncryptionDecrypt(
                                    encrypt.Encrypted.from64(
                                      decryptMessageAfterAES(
                                          reversedList[index]['message']),
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          color: reversedList[index]['sender'] == 0
                              ? Colors.grey[700]
                              : Color(0xFF364DB9),
                          elevation: 4,
                          padding: BubbleEdges.fromLTRB(12, 8, 12, 8),
                          alignment: reversedList[index]['sender'] == 0
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          nip: reversedList[index]['sender'] == 0
                              ? BubbleNip.leftTop
                              : BubbleNip.rightTop,
                          radius: Radius.circular(15.0),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              padding: EdgeInsets.only(bottom: 50, top: 30),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                        icon: Transform.rotate(
                            angle: 120,
                            child: Icon(Icons.attach_file, color: Colors.grey)),
                        onPressed: () {}),
                  ),
                  Flexible(
                    child: TextField(
                      onChanged: (String text) {
                        setState(() {
                          _isComposing = text.length > 0;
                        });
                      },
                      controller: _textController,
                      onSubmitted: _handleSubmitted,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Send a message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                        icon: Icon(Icons.send,
                            color:
                                _isComposing ? Color(0xFF364DB9) : Colors.grey),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text)
                            : null),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(now);
    final DateFormat formatter2 = DateFormat('HH:mm');
    final String formatted2 = formatter2.format(now);
    bool restrict = false;

    if (_textController.text.contains('Qarabag') ||
        _textController.text.contains('Karabakh') ||
        _textController.text.contains('Lacin') ||
        _textController.text.contains('Shusha') ||
        _textController.text.contains('Kalbacar') ||
        _textController.text.contains('Agdam') ||
        _textController.text.contains('Tartar') ||
        _textController.text.contains('war') ||
        _textController.text.contains('esger') ||
        _textController.text.contains('muharibe') ||
        _textController.text.contains('doyushur') ||
        _textController.text.contains('soldier') ||
        _textController.text.contains('occupation') ||
        _textController.text.contains('ermeni') ||
        _textController.text.contains('battleing') ||
        _textController.text.contains('coordinates')) {
      restrict = true;
    }

    if (!restrict) {
      var orderRef = databaseReference
          .child('messages')
          .child(widget.messageId)
          .child('messageList')
          .push();

      orderRef.set({
        'sender': 1,
        'date': formatted,
        'time': formatted2,
        'message': encryptMessageAfterAES(
            aesEncryptionEncrypt(_textController.text).base64)
      });
    }

    _textController.clear();
    setState(() {
      _isComposing = false;
    });
  }

  encrypt.Encrypted aesEncryptionEncrypt(plain) {
    final plainText = plain;
    final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows2');
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    return encrypted;
  }

  String encryptMessageAfterAES(message) {
    var e1 = message.toString().substring(0, message.toString().length ~/ 4);
    var e2 = message.toString().substring(
        message.toString().length ~/ 4, message.toString().length ~/ 2);
    var e3 = message
        .toString()
        .substring(message.toString().length ~/ 2, message.toString().length);

    var encoded = e2 + e1 + e3;

    return (encoded);
  }

  String decryptMessageAfterAES(encoded) {
    var d1 = encoded.toString().substring(0, encoded.toString().length ~/ 4);
    var d2 = encoded.toString().substring(
        encoded.toString().length ~/ 4, encoded.toString().length ~/ 2);
    var d3 = encoded
        .toString()
        .substring(encoded.toString().length ~/ 2, encoded.toString().length);

    var decoded = d2 + d1 + d3;

    return decoded;
  }

  String aesEncryptionDecrypt(encrypted) {
    final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows2');
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    return decrypted;
  }
}
