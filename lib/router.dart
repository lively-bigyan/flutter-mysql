import 'package:criminal_face_updat/database_screen.dart';

import 'package:criminal_face_updat/pages/login.dart';
import 'package:criminal_face_updat/pages/sharedloginregister.dart';
import 'package:criminal_face_updat/router_constants.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name)
  {
    case LoginRoute:
    return MaterialPageRoute(builder: (context)=>Login());
    case DatabaseRoute:
    return MaterialPageRoute(builder: (context)=>Database());
    default: 
    return MaterialPageRoute(builder: (context)=>MyHomePage());
  }
}