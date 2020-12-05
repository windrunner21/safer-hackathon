import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:safer_hackathon/ui/additional-components/detailed-chat-page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:encrypt/encrypt.dart';

final databaseReference = FirebaseDatabase.instance.reference();
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool searchEnabled = false;
  bool undoPressed = false;
  List<String> options = ['Messages', 'Contacts', 'Archives'];
  int selectedIndex = 0;

  Future<void> _launched;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return SizedBox.shrink();
    } else {
      return SizedBox.shrink();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5b70d9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: IconButton(
              onPressed: () {
                setState(() {
                  searchEnabled = !searchEnabled;
                });
              },
              icon: Icon(
                searchEnabled ? Icons.cancel : Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // just in case
          FutureBuilder<void>(future: _launched, builder: _launchStatus),
          // search
          Visibility(
            visible: searchEnabled,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Search",
                  isDense: true,
                  prefixIcon: Icon(Icons.search, color: Colors.black38),
                ),
              ),
            ),
          ),
          // options
          Container(
            color: Color(0xFF5b70d9),
            height: MediaQuery.of(context).size.height / 10,
            child: ListView.builder(
              itemCount: options.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Text(
                      options[index],
                      style: TextStyle(
                          color: index == selectedIndex
                              ? Colors.white
                              : Colors.white60,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2),
                    ),
                  ),
                );
              },
            ),
          ),
          // favorite and chats
          Expanded(
            child: Column(
              children: [
                // favorite
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: selectedIndex == 1
                            ? EdgeInsets.all(0)
                            : EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: selectedIndex == 2
                            ? Text(
                                "Archived chats",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.grey[700],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            : selectedIndex == 0
                                ? Text(
                                    "Favorite chats",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: Colors.grey[700],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                : SizedBox(),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: selectedIndex == 2
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Text(
                                  "You can archive a conversation from your chats screen and access it later, if needed.",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 1),
                                ))
                            : selectedIndex == 0
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: Text(
                                      "No favorite chats found. Swipe left to add a favorite chat.",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          letterSpacing: 1),
                                    ),
                                  )
                                : SizedBox(),
                      )
                    ],
                  ),
                ),
                // chats
                selectedIndex == 0 || selectedIndex == 2
                    ? Expanded(
                        child: Container(
                            color: Colors.white,
                            child: FutureBuilder(
                              future: _getMessages(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    padding: EdgeInsets.only(top: 6.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Slidable(
                                        key: ValueKey(index),
                                        dismissal: SlidableDismissal(
                                          child: SlidableDrawerDismissal(),
                                          onDismissed: (actionType) {
                                            if (actionType ==
                                                SlideActionType.primary) {
                                              if (!undoPressed) {
                                                setState(() {});
                                              }
                                            } else {
                                              if (!undoPressed) {
                                                setState(() {});
                                              }
                                            }

                                            Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                duration: actionType ==
                                                        SlideActionType.primary
                                                    ? const Duration(
                                                        seconds: 10)
                                                    : const Duration(
                                                        seconds: 10),
                                                content: Text(
                                                    actionType ==
                                                            SlideActionType
                                                                .primary
                                                        ? 'Chat archived'
                                                        : 'Chat Deleted',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                action: SnackBarAction(
                                                  label: 'Undo',
                                                  onPressed: () {
                                                    setState(() {
                                                      undoPressed = true;
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        actionPane: SlidableDrawerActionPane(),
                                        actions: <Widget>[
                                          IconSlideAction(
                                            caption: snapshot.data[index]
                                                    ['archived']
                                                ? 'Unarchive'
                                                : 'Archive',
                                            color: Colors.grey[800],
                                            icon: snapshot.data[index]
                                                    ['archived']
                                                ? Icons.unarchive
                                                : Icons.archive,
                                            onTap: () {
                                              if (snapshot.data[index]
                                                  ['archived']) {
                                                setState(() {});
                                              } else {
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          IconSlideAction(
                                            caption: 'Call',
                                            color: Colors.green,
                                            icon: Icons.phone,
                                            onTap: () => setState(() {
                                              _launched = _makePhoneCall(
                                                  'tel:+994517807929');
                                            }),
                                          ),
                                        ],
                                        secondaryActions: <Widget>[
                                          IconSlideAction(
                                            caption: snapshot.data[index]
                                                    ['favorite']
                                                ? 'Unfavorite'
                                                : 'Favorite',
                                            color: Colors.blue,
                                            icon: snapshot.data[index]
                                                    ['favorite']
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            onTap: () {
                                              if (snapshot.data[index]
                                                  ['favorite']) {
                                                setState(() {});
                                              } else {
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          IconSlideAction(
                                            caption: 'Delete',
                                            color: Colors.red,
                                            icon: Icons.delete,
                                            onTap: () {
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                        child: ListTile(
                                          leading: CircleAvatar(
                                              child: Icon(Icons.person)),
                                          title: Text(snapshot.data[index]
                                              ['sender']['fullName']),
                                          subtitle: Text(aesEncryptionDecrypt(
                                              Encrypted.from64(
                                                  decryptMessageAfterAES(snapshot
                                                                  .data[index]
                                                              ['messageList'][
                                                          snapshot
                                                              .data[index]
                                                                  ['messageList']
                                                              .keys
                                                              .last
                                                              .toString()]
                                                      ['message'])))),
                                          trailing: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(snapshot.data[index]
                                                      ['messageList'][
                                                  snapshot
                                                      .data[index]
                                                          ['messageList']
                                                      .keys
                                                      .last
                                                      .toString()]['date']),
                                              Text(snapshot.data[index]
                                                      ['messageList'][
                                                  snapshot
                                                      .data[index]
                                                          ['messageList']
                                                      .keys
                                                      .last
                                                      .toString()]['time']),
                                            ],
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailedChat(
                                                        receiver:
                                                            snapshot.data[index]
                                                                    ['sender']
                                                                ['fullName'],
                                                        messages:
                                                            snapshot.data[index]
                                                                ['messageList'],
                                                        messageId:
                                                            snapshot.data[index]
                                                                ['enid']),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        indent:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        color: Colors.grey[350],
                                        height: 0,
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Color(0xFF364DB9),
                                    ),
                                  );
                                }
                              },
                            )),
                      )
                    : Expanded(
                        child: Container(
                          color: Colors.white,
                          child: FutureBuilder(
                            future: _getContacts(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  padding: EdgeInsets.only(top: 6.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    bool newGroup = false;

                                    if (index == 0) {
                                      newGroup = true;
                                    } else {
                                      if (snapshot.data[index][0] !=
                                          snapshot.data[index - 1][0]) {
                                        newGroup = true;
                                      } else {
                                        newGroup = false;
                                      }
                                    }

                                    return Column(
                                      children: [
                                        newGroup
                                            ? Container(
                                                color: Colors.grey.shade300,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 30),
                                                child: Text(
                                                  snapshot.data[index][0],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                            : SizedBox.shrink(),
                                        ListTile(
                                          leading: CircleAvatar(
                                            child: Icon(Icons.person),
                                          ),
                                          title: Text(snapshot.data[index]),
                                          onTap: () {},
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      indent:
                                          MediaQuery.of(context).size.width / 5,
                                      color: Colors.grey.shade300,
                                      height: 0,
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Color(0xFF364DB9),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

String formatDate(date) {
  date = date.split("T")[0];
  if (date.contains("-")) {
    var today = DateTime.now().toString().split(" ")[0];

    if (date.split("-")[0] == today.split("-")[0] &&
        date.split("-")[1] == today.split("-")[1]) {
      var todaysDate = int.parse(today.split("-")[2]);
      var incomingDate = int.parse(date.split("-")[2]);

      if (todaysDate - incomingDate >= 7) {
        return date.split("-")[2] +
            "." +
            date.split("-")[1] +
            "." +
            date.split("-")[0].substring(2, 4);
      } else {
        if (todaysDate - incomingDate == 1) {
          return "Yesterday";
        } else if (todaysDate - incomingDate == 2) {
          return getWeekday(DateTime.parse(date).weekday);
        } else if (todaysDate - incomingDate == 3) {
          return getWeekday(DateTime.parse(date).weekday);
        } else if (todaysDate - incomingDate == 4) {
          return getWeekday(DateTime.parse(date).weekday);
        } else if (todaysDate - incomingDate == 5) {
          return getWeekday(DateTime.parse(date).weekday);
        } else if (todaysDate - incomingDate == 6) {
          return getWeekday(DateTime.parse(date).weekday);
        }
      }
      return date.split("-")[2] +
          "." +
          date.split("-")[1] +
          "." +
          date.split("-")[0].substring(2, 4);
    }
  }
  return date;
}

String getWeekday(index) {
  if (index == 1) {
    return "Mon";
  } else if (index == 2) {
    return "Tue";
  } else if (index == 3) {
    return "Wed";
  } else if (index == 4) {
    return "Thu";
  } else if (index == 5) {
    return "Fri";
  } else if (index == 6) {
    return "Sat";
  } else {
    return "Sun";
  }
}

Future<List> _getMessages() async {
  var listOfEncIds = [];
  var listOfChats = [];

  await databaseReference
      .child('citizens')
      .child(user.uid)
      .child('chats')
      .child('messages')
      .once()
      .then((DataSnapshot data) {
    listOfEncIds = data.value;
  });

  for (var enids in listOfEncIds) {
    await databaseReference
        .child('messages')
        .child(enids)
        .once()
        .then((DataSnapshot data) {
      listOfChats.add(data.value);
    });
  }

  // print(aesEncryptionEncrypt("Hey, where are you?").base64);
  // print(aesEncryptionDecrypt(aesEncryptionEncrypt("Hey, where are you?")));

  // print(decryptMessageAfterAES(encryptMessageAfterAES(
  //     aesEncryptionEncrypt("Hey, where are you?").base64)));

  for (var i = 0; i < listOfChats.length; i++) {
    await databaseReference
        .child('citizens')
        .child(aesEncryptionDecrypt(Encrypted.from64(listOfChats[i]['sender'])))
        .once()
        .then((DataSnapshot data) {
      listOfChats[i]['sender'] = data.value;
      listOfChats[i]['enid'] = listOfEncIds[i];
    });
  }

  return listOfChats;
}

Future<List> _getContacts() async {
  var listOfUids = [];
  var listOfNames = [];

  await databaseReference
      .child('citizens')
      .child(user.uid)
      .child('chats')
      .child('contacts')
      .once()
      .then((DataSnapshot data) {
    listOfUids = data.value;
  });

  for (var uid in listOfUids) {
    await databaseReference
        .child('citizens')
        .child(uid)
        .once()
        .then((DataSnapshot data) {
      listOfNames.add(data.value['fullName']);
    });
  }

  return listOfNames;
}

String randomChatKeyGenerator() {
  var random = Random.secure();
  var values = List<int>.generate(16, (i) => random.nextInt(256));

  return base64UrlEncode(values);
}

Encrypted aesEncryptionEncrypt(plain) {
  final plainText = plain;
  final key = Key.fromUtf8('my32lengthsupersecretnooneknows2');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted;
}

String aesEncryptionDecrypt(encrypted) {
  final key = Key.fromUtf8('my32lengthsupersecretnooneknows2');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  return decrypted;
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
