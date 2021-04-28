import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';


class Deductions extends StatefulWidget {
  @override
  _DeductionsState createState() => _DeductionsState();
}

class _DeductionsState extends State<Deductions> {
  String filePath;

  String fileP;

  void initState() {
    // TODO: implement initState
    super.initState();
    getStringValue();
  }

  String userCompany;
  String currentUser;
  getStringValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userCompany = prefs.getString('company');
      currentUser = prefs.getString('user');
    });

  }

  Future<File> get _localF async {
    // the downloads folder path
    Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
    String tempPath = tempDir.path;
    var filePath = tempPath + '/${DateFormat('MMM-yyyy').format(DateTime.now())} DeductionsReport.csv';
    return File(filePath).create();
  }

  getCsv() async {

    //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.

    List<List<dynamic>> rows = List<List<dynamic>>();


    rows.add(<String>['DATE', 'NAME', 'ID', 'PF/NO','ITEMS'],);
    final QuerySnapshot result =
    await Firestore.instance.collection("deductions").where('company', isEqualTo: userCompany).orderBy('timestamp', descending: true).getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents != null) {
//row refer to each column of a row in csv file and rows refer to each row in a file
      documents.forEach((snapshot) {
        List<String> recind = <String>[
          snapshot.data['date'],
          snapshot.data['name'],
          snapshot.data['id'],
          snapshot.data['pfn'],
          snapshot.data['Items'].toString(),

        ];
        rows.add(recind);
      });

      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      File f = await _localF;

      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("File downloaded Succefully"),
            content: new Text("It is located in the Download folder"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Row(children: [
          new Icon(Icons.file_download),
          SizedBox(width: 5.0,),
          new Text('Download Report')
        ],),
        //Widget to display inside Floating Action Button, can be `Text`, `Icon` or any widget.
        onPressed: () {
          getCsv();
        },
      ),
      body: new Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          SingleChildScrollView(
            child: RepaintBoundary(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new SizedBox(
                    height: 40.0,
                  ),
                  new Card(
                    child: new Container(
                      margin: new EdgeInsets.only(left: 5.0, right: 5.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new SizedBox(
                            height: 10.0,
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                new Text(
                                  "Items Issued as at: ${DateFormat(' dd MMM yyyy').format(DateTime.now())}",
                                  style: new TextStyle(
                                      fontSize: 12.0, fontWeight: FontWeight.w700),
                                ),



                              ],
                            ),
                          ),
                          new SizedBox(
                            height: 10.0,
                          ),

                        ],
                      ),
                    ),
                  ),

                  new Card(
                    child: Column(
                      mainAxisSize:MainAxisSize.min,
                      children: <Widget>[
                        new StreamBuilder(
                          stream: Firestore.instance.collection("deductions").where('company', isEqualTo: userCompany).orderBy('timestamp', descending: true).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return new Text('Loading...');

                            return new FittedBox(
                              child: Center(
                                child: DataTable(
                                  columnSpacing: 10,
                                  headingRowColor: MaterialStateProperty.all(Colors.grey[400]),
                                  columns: <DataColumn>[
                                    new DataColumn(label: Text('DATE',style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),)),
                                    new DataColumn(label: Row(
                                      children: [
                                        VerticalDivider(),
                                        Text('NAME',style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
                                      ],
                                    )),
                                    new DataColumn(label: Row(
                                      children: [
                                        VerticalDivider(),
                                        Text('ID',style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
                                      ],
                                    )),
                                    new DataColumn(label: Row(
                                      children: [
                                        VerticalDivider(),
                                        Text('PF/NO',style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
                                      ],
                                    )),
                                    new DataColumn(label: Row(
                                      children: [
                                        VerticalDivider(),
                                        Text('ITEMS',style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
                                      ],
                                    )),
                                  ],
                                  rows: _createRows(snapshot.data),

                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                  )

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  List<DataRow> _createRows(QuerySnapshot snapshot) {

    List<DataRow> newList = snapshot.documents.map((doc) {
      return new DataRow(
          cells: [
            DataCell(Text(doc.data["date"],
              style: new TextStyle(fontSize: 12.0),)),
            DataCell(Row(
              children: [
                VerticalDivider(),
                Text(doc.data["name"],
                  style: new TextStyle(fontSize: 12.0),),
              ],
            )),
            DataCell(Row(
              children: [
                VerticalDivider(),
                Text(doc.data["id"],
                  style: new TextStyle(fontSize: 12.0),),
              ],
            )),
            DataCell(Row(
              children: [
                VerticalDivider(),
                Text(doc.data["pfn"],
                  style: new TextStyle(fontSize: 12.0),),
              ],
            )),
            DataCell(Row(
              children: [
                VerticalDivider(),
                Text(doc.data["Items"].toString(),
                  style: new TextStyle(fontSize: 12.0),),
              ],
            )),
          ]);}).toList();

    return newList;
  }

}