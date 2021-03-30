import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';

class supRep extends StatefulWidget {
  String supplier;

  supRep({
    this.supplier,
  });
  @override
  _supRepState createState() => _supRepState();
}

class _supRepState extends State<supRep> {
  String filePath;

  String fileP;

  Future<String> get _localP async {
    final directory = await getExternalStorageDirectory();
    return directory.absolute.path;
  }

  Future<File> get _localF async {
    final path = await _localP;
    fileP = '/storage/emulated/0/Download/data.csv';
    return File('/storage/emulated/0/Download/${DateFormat('MMM-yyyy').format(DateTime.now())} ${widget.supplier}.csv').create();
  }
  getCsv() async {

    //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.

    List<List<dynamic>> rows = List<List<dynamic>>();


    rows.add(<String>['DATE', 'ITEM','QUANTITY','SUPPLIER', 'TOTAL (KSH.)'],);
    final QuerySnapshot result =
    searchController.text == '' ||  searchController.text == null  ?
    await Firestore.instance.collection("addedStock").where('supplier', isEqualTo: widget.supplier).orderBy('timestamp', descending: true).getDocuments():
    await Firestore.instance.collection("addedStock").where('month', isEqualTo: searchController.text).where('supplier', isEqualTo: widget.supplier).orderBy('timestamp', descending: true).getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents != null) {
//row refer to each column of a row in csv file and rows refer to each row in a file
      documents.forEach((snapshot) {
        List<String> recind = <String>[
          snapshot.data['date'],
          snapshot.data['Item'],
          snapshot.data['Quantity'],
          snapshot.data["supplier"],
          snapshot.data['Total'],
        ];
        rows.add(recind);
      });
      await Permission.storage.request().isGranted;
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
  TextEditingController searchController = TextEditingController();
  String sQuery;
  String _cont;
  int _contri;
  String contString;
  int total = 0;
  int newTotal;

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderDateTimePicker(
                      initialEntryMode: DatePickerEntryMode.calendar,
                      pickerType: PickerType.cupertino,
                      name: 'dDate',
                      inputType: InputType.date,
                      format: DateFormat(" yyyy- MM"),
                      valueTransformer: (value) {
                        return value.toString().substring(0,10);
                      },
                      validator: FormBuilderValidators.required(context),
                      decoration:
                      InputDecoration(
                        labelText: "Select Month and year",
                        hintText:'Month & Year',
                        prefixIcon: Icon(Icons.date_range),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)))
                      ),
                      controller: searchController,
                      onChanged: (value){
                        setState(() {
                          sQuery = searchController.text;
                        });
                      },

                    ),
                  ),
                  new Card(
                    color: searchController.text == '' ||  searchController.text == null ? Colors.white: Colors.purple[300],
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
                                  searchController.text == '' ||  searchController.text == null ?
                                  "Supplies as at: ${DateFormat('dd MMM yyyy').format(DateTime.now())}": 'Total spent: KSH.${contString}',
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
                          stream: searchController.text == '' ||  searchController.text == null ?
                          Firestore.instance.collection("addedStock").where('supplier', isEqualTo: widget.supplier).orderBy('timestamp', descending: true).snapshots():
                          Firestore.instance.collection("addedStock").where('month', isEqualTo: searchController.text).where('supplier', isEqualTo: widget.supplier).orderBy('timestamp', descending: true).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return new Text('Loading...');

                            return new FittedBox(
                              child: DataTable(
                                columnSpacing: 10,
                                columns: <DataColumn>[
                                  new DataColumn(label: Text('DATE',style: new TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),)),
                                  new DataColumn(label: Row(
                                    children: [
                                      VerticalDivider(),
                                      Text('ITEM',style: new TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),),
                                    ],
                                  )),
                                  new DataColumn(label: Row(
                                    children: [
                                      VerticalDivider(),
                                      Text('QUANTITY',style: new TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),),
                                    ],
                                  )),
                                  new DataColumn(label: Row(
                                    children: [
                                      VerticalDivider(),
                                      Text('SUPPLIER',style: new TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),),
                                    ],
                                  )),
                                  new DataColumn(label: Row(
                                    children: [
                                      VerticalDivider(),
                                      Text('TOTAL (KSH.)',style: new TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),),
                                    ],
                                  )),

                                ],
                                rows: _createRows(snapshot.data),

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
    int tot = 0;
    snapshot.documents.forEach((document)
    {
      SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
        _cont = document['Total'];
        _contri = int.parse(_cont);
        newTotal = tot += _contri;
        contString = newTotal.toString();
      }));

    });

    List<DataRow> newList = snapshot.documents.map((doc) {
      return new DataRow(
          cells: [
            DataCell(Text(doc.data["date"],
              style: new TextStyle(fontSize: 10.0),)),
            DataCell(Row(
              children: [
                VerticalDivider(),
                Text(doc.data["Item"],
                  style: new TextStyle(fontSize: 10.0),),
              ],
            )),
            DataCell(Row(
              children: [
                VerticalDivider(),
                Text(doc.data["Quantity"],
                  style: new TextStyle(fontSize: 10.0),),
              ],
            )),
            DataCell(Row(
              children: [
                VerticalDivider(),
                Text(doc.data["supplier"],
                  style: new TextStyle(fontSize: 10.0),),
              ],
            )),
            DataCell(Row(
              children: [
                VerticalDivider(),
                Text(doc.data["Total"],
                  style: new TextStyle(fontSize: 10.0),),
              ],
            )),
          ]);}).toList();

    return newList;
  }

}