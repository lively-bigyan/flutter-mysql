import 'package:criminal_face_updat/widgets/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './widgets/datepicker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllername = new TextEditingController();
  TextEditingController controllercrime = new TextEditingController();
  TextEditingController controllerimage = new TextEditingController();
  TextEditingController controlleradder = new TextEditingController();
  final String uploadEndPoint =
      'http://192.168.100.41/projectdb/images/upload_image.php';
  //for storing imported image
  Future<File> file;
  //for displaying status
  String status = '';
  //for converting string into base image
  String base64Image;
  // for storing original image temporarily
  File tmpFile;
  // error message
  String errMessage = 'Error Uploading Image';
 Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Container(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.contain,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  openCamera() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
    setStatus('');
  }

//to choose image from gallery
  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

//to start upload and show server
  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

// to post image to the folder on xampp
  upload(String fileName) {
    imageName=fileName;
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }
  void addData() {
    var url = "http://192.168.100.41/projectdb/adddata.php";
    http.post(url, body: {
      "nameofcriminal": controllername.text,
      "crime_committed": controllercrime.text,
      "dateofcrime": '$tgl',
      "image_url":'$imageName',
      "added_by": controlleradder.text,
      "added_on":"$added_on"
    });
  }

  String date, labelText, imageName;
  DateTime tgl = DateTime.now();
  DateTime added_on=DateTime.now();
  final TextStyle valueStyle = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: tgl,
        firstDate: DateTime(1992),
        lastDate: DateTime(2099));

    if (picked != null && picked != tgl) {
      setState(() {
        tgl = picked;
        date = DateFormat.yMd().format(tgl);
      });
    } else {}

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                    'Please insert photo.',
                    style: TextStyle(fontSize: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlineButton(
                        child: Text('Open Camera'),
                        onPressed: openCamera,
                      ),
                      OutlineButton(
                    onPressed: chooseImage,
                    child: Text('Choose Image'),
                  ),
                    ],
                  ),
                  //for choosing image
                  
                  SizedBox(
                    height: 20.0,
                  ),
                  //for showing image
                   showImage(),
                  
                  SizedBox(
                    height: 20.0,
                  ),
                  
                  
                  //to display upload status
                  
              Container(
                  padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: controllername,
                        decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Name of Criminal',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: controllercrime,
                        decoration: InputDecoration(
                            labelText: 'Crime',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 20.0),
                      DateDropDown(
                        labelText: labelText,
                        valueText: DateFormat.yMd().format(tgl),
                        valueStyle: valueStyle,
                        onPressed: () {
                          _selectedDate(context);
                        },
                      ),
                      SizedBox(height: 40.0),
                      TextField(
                        controller: controlleradder,
                        decoration: InputDecoration(
                            labelText: 'Added By',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              startUpload();
                              addData();
                               Navigator.pop(context); 
                            },
                            child: Center(
                              child: Text(
                                'INSERT TO DATABASE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                    status,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                    ],
                  )),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
