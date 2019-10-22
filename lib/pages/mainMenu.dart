import 'dart:io';

import 'package:criminal_face_updat/adddata.dart';
import 'package:criminal_face_updat/details.dart';
import 'package:criminal_face_updat/pages/developers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;

  MainMenu(this.signOut);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  int currentIndex = 0;
  String selectedIndex = 'TAB: 0';

  String email = "", name = "", id = "";
  TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      email = preferences.getString("email");
      name = preferences.getString("name");
    });
    print("id" + id);
    print("user" + email);
    print("name" + name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[200],
        title: Text(
          'Add Criminal Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.lock_open), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        elevation: 0,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Logged in as:'),
              accountEmail: Text('$email'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white54,
                child: Icon(Icons.person_pin, size: 50,),
              ),
            ),
            ListTile(
                title: Text('Add to Database'),
                leading: Icon(Icons.add_circle_outline),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));
                }),
            Divider(),
            ListTile(
                title: Text('About'),
                leading: Icon(Icons.short_text),
                trailing: Icon(Icons.arrow_right),
                onTap: () {}),
            Divider(),
            ListTile(
                title: Text('Log Out'),
                leading: Icon(Icons.exit_to_app),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  signOut();
                }),
                Divider(),
            ListTile(
                title: Text('Exit App'),
                leading: Icon(Icons.save_alt),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  exit(0);
                }),
                Divider(),
            ListTile(
                title: Text('Developers'),
                leading: Icon(Icons.save_alt),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                   Navigator.push(
              context, MaterialPageRoute(builder: (context) => Developers()));
                }),
          ],
        ),
      ),
      body: MyAppDatabase(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));
        },
      ),
    );
    /* Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.lock_open),
          )
        ],
      ),
      body: Center(
        child: Text(
          "WelCome",
          style: TextStyle(fontSize: 30.0, color: Colors.blue),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.black,
        iconSize: 30.0,
//        iconSize: MediaQuery.of(context).size.height * .60,
        currentIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
          selectedIndex = 'TAB: $currentIndex';
//            print(selectedIndex);
          reds(selectedIndex);
        },

        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Color(0xFFf7d426)),
          BottomNavyBarItem(
              icon: Icon(Icons.view_list),
              title: Text('List'),
              activeColor: Color(0xFFf7d426)),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              activeColor: Color(0xFFf7d426)),
        ],
      ),
    ); */
  }

  //  Action on Bottom Bar Press
  void reds(selectedIndex) {
//    print(selectedIndex);

    switch (selectedIndex) {
      case "TAB: 0":
        {
          callToast("Tab 0");
        }
        break;

      case "TAB: 1":
        {
          callToast("Tab 1");
        }
        break;

      case "TAB: 2":
        {
          callToast("Tab 2");
        }
        break;
    }
  }

  callToast(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.green[200],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}