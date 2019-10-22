import 'dart:async';
import 'package:criminal_face_updat/adddata.dart';
import 'package:criminal_face_updat/details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Database extends StatefulWidget {
  @override
  _DatabaseState createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
  Future<List> getData() async {
    final response = await http.get('http://192.168.100.41/projectdb/getdata.php');
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? ItemList(
                  list: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        final x = list[i];
        return Card(
          child: ListTile(
            title: Text('Name:   '+x['nameofcriminal'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            leading: Icon(Icons.data_usage),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Crime: ',style: TextStyle(color: Colors.red[200],fontSize: 16),),
                Container(
                  padding: const EdgeInsets.all(7.0),
                  decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5.0)),
                      child: Text(x['crime_committed'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            onTap: () {
            },
          ),
        );
      },
    );
  }
}
