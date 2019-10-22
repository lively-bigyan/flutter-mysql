import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' show get;
import 'dart:convert';

class CriminalDb {
  final String id;
  final String name,
      image_url,
      dateofcrime,
      crime_committed,
      added_by,
      added_on;
  CriminalDb(
      {this.id,
      this.name,
      this.crime_committed,
      this.dateofcrime,
      this.image_url,
      this.added_by,
      this.added_on});
  factory CriminalDb.fromJson(Map<String, dynamic> jsonData) {
    return CriminalDb(
      id: jsonData['id'],
      name: jsonData['nameofcriminal'],
      crime_committed: jsonData['crime_committed'],
      dateofcrime: jsonData['dateofcrime'],
      added_by: jsonData['added_by'],
      added_on: jsonData['added_on'],
      image_url:
          "http://192.168.100.41/projectdb/images/" + jsonData['image_url'],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<CriminalDb> criminaldb;
  CustomListView(this.criminaldb);
  Widget build(context) {
    return ListView.builder(
      itemCount: criminaldb.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(criminaldb[currentIndex], context);
      },
    );
  }

  Widget createViewItem(CriminalDb criminaldb, BuildContext context) {
    return new ListTile(
        title: new Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 10.0,
          child: new Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.lightBlue)),
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Padding(
                  child: Image.network(criminaldb.image_url),
                  padding: EdgeInsets.only(bottom: 8.0),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                          child: Text(
                            criminaldb.name,
                            style: new TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          padding: EdgeInsets.all(1.0)),
                      Text(" | "),
                      Padding(
                          child: Text(
                            criminaldb.crime_committed,
                            style: new TextStyle(fontStyle: FontStyle.italic),
                            textAlign: TextAlign.right,
                          ),
                          padding: EdgeInsets.all(1.0)),
                      Text(" | "),
                      Padding(
                          child: Text(
                            criminaldb.dateofcrime,
                            style: new TextStyle(fontStyle: FontStyle.italic),
                            textAlign: TextAlign.right,
                          ),
                          padding: EdgeInsets.all(1.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
//We start by creating a Page Route.
//A MaterialPageRoute is a modal route that replaces the entire
//screen with a platform-adaptive transition.
          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                new SecondScreen(value: criminaldb),
          );
//A Navigator is a widget that manages a set of child widgets with
//stack discipline.It allows us navigate pages.
          Navigator.of(context).push(route);
        });
  }
}

//Future is n object representing a delayed computation.
Future<List<CriminalDb>> downloadJSON() async {
  final jsonEndpoint = "http://192.168.100.41/projectdb";
  final response = await get(jsonEndpoint);
  if (response.statusCode == 200) {
    List criminaldb = json.decode(response.body);
    return criminaldb
        .map((criminaldb) => new CriminalDb.fromJson(criminaldb))
        .toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

class SecondScreen extends StatefulWidget {
  final CriminalDb value;
  SecondScreen({Key key, this.value}) : super(key: key);
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: new Scaffold(
        /* appBar: new AppBar(
          title: new Text('Detail Page')), */
        body: SingleChildScrollView(
          child: new Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  child: Align(
                    alignment: Alignment.center,
                                      child: new Text(
                      'CRIMINAL DETAILS',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.orangeAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 20.0),
                ),
                Padding(
                  child: Container(
                    decoration: BoxDecoration(
                      color:Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  child: Image.network('${widget.value.image_url}'),
                  ),
                  padding: EdgeInsets.all(12.0),
                ),
                Padding(
                  child: new Text(
                    'Name : ${widget.value.name}',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Padding(
                  child: new Text(
                    'Crime Committed : ${widget.value.crime_committed}',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Padding(
                  child: new Text(
                    'Date of Crime : ${widget.value.dateofcrime}',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Padding(
                  child: new Text(
                    'Added By : ${widget.value.added_by}',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Padding(
                  child: new Text(
                    'Added On : ${widget.value.added_on}',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.all(10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyAppDatabase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
//FutureBuilder is a widget that builds itself based on the latest snapshot
// of interaction with a Future.
        child: new FutureBuilder<List<CriminalDb>>(
          future: downloadJSON(),
//we pass a BuildContext and an AsyncSnapshot object which is an
//Immutable representation of the most recent interaction with
//an asynchronous computation.
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CriminalDb> criminaldb = snapshot.data;
              return new CustomListView(criminaldb);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
//return  a circular progress indicator.
            return new CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
