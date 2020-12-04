import 'package:flutter/material.dart';
import 'package:safer_hackathon/ui/home-components/chat-page.dart';
import 'package:safer_hackathon/ui/home-components/dashboard-page.dart';
import 'package:safer_hackathon/ui/home-components/map-page.dart';
import 'package:safer_hackathon/ui/home-components/profile-page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  final user;
  HomePage({Key key, this.user}) : super(key: key);
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var completedOrders = [];
  var currentOrder = {
    "placeHolder": "placeHolder",
    "orderDelivered": true,
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [DashboardPage(), MapPage(), ChatPage(), ProfilePage()],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: TabBar(
            labelColor: Color(0xFF364DB9),
            unselectedLabelColor: Colors.grey,
            labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 25),
            indicator: BoxDecoration(),
            tabs: [
              Tab(
                icon: Icon(Icons.layers),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.explore),
                text: 'Map',
              ),
              Tab(
                icon: Icon(Icons.chat),
                text: 'Chat',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'About Me',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
