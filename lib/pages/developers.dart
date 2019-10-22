import 'package:flutter/material.dart';

class Developers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Developers')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    Text('Liza Shrestha',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                    Text('lizashrestha48@gmail.com')
                  ],
                ),
              ),
              Card(
                color: Colors.blue[200],
                child: Column(
                  children: <Widget>[
                    Text('Subigya Raj Mishra',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                    Text('msubigya@gmail.com')
                  ],
                ),
              ),
              Card(
                color: Colors.blue[200],
                child: Column(
                  children: <Widget>[
                    Text('Timila Maharjan',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                    Text('timilamaharjan8@gmail.com')
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
