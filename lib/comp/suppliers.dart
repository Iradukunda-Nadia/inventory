import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Reports/issuanceReport.dart';
import 'package:inventory/Reports/supReports.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Suppliers extends StatefulWidget {
  @override
  _SuppliersState createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> {
  TextEditingController searchController = TextEditingController();
  String sQuery;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sQuery = '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Suppliers"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color(0xffC3B1E1),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: new Text('New Supplier'),
        //Widget to display inside Floating Action Button, can be `Text`, `Icon` or any widget.
        onPressed: () {
          Navigator.of(context).push(new CupertinoPageRoute(
              builder: (context) => newSupplier()));
        },
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {

                    });
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      labelText: "Enter name",
                      hintText: "Name",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                  child: new StreamBuilder(
                      stream: Firestore.instance.collection("suppliers").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                          // ignore: missing_return
                          final List<DocumentSnapshot> documents = snapshot.data.documents;
                          return ListView(
                              children: documents
                              // ignore: missing_return
                                  .map((doc) => Card(
                                child: doc['name'].toLowerCase().contains(searchController.text.toLowerCase()) ?
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(new CupertinoPageRoute(
                                        builder: (context) => supRep(
                                          supplier: doc['name'],
                                        )));
                                  },
                                  title: Text(doc['name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ): new Offstage(),
                              ))
                                  .toList());
                        } else {
                          return Text('');
                        }

                      })
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class suppliersSummary extends StatefulWidget {
  @override
  _suppliersSummaryState createState() => _suppliersSummaryState();
}

class _suppliersSummaryState extends State<suppliersSummary> {
  TextEditingController searchController = TextEditingController();
  String sQuery;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sQuery = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suppliers'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: new Text('New Supplier'),
        //Widget to display inside Floating Action Button, can be `Text`, `Icon` or any widget.
        onPressed: () {},
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                    labelText: "Enter name",
                    hintText: "Name",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
                child: new StreamBuilder(
                    stream: Firestore.instance.collection("suppliers").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                        // ignore: missing_return
                        final List<DocumentSnapshot> documents = snapshot.data.documents;
                        return ListView(
                            children: documents
                            // ignore: missing_return
                                .map((doc) => doc['name'].toLowerCase().contains(searchController.text.toLowerCase()) ?
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(new CupertinoPageRoute(
                                    builder: (context) => supRep(
                                      supplier: doc['name'],
                                    )));
                              },
                              title: Text(doc['name'].toUpperCase(),

                              ),
                            ): new Offstage(),)
                                .toList());
                      } else {
                        return Text('');
                      }

                    })
            ),
          ],
        ),
      ),
    );
  }
}

class newSupplier extends StatefulWidget {
  @override
  _newSupplierState createState() => _newSupplierState();
}

class _newSupplierState extends State<newSupplier> {
  String name;
  String id;
  String Item;
  String qt;
  String pfn;
  String region;
  String assignment;

  final formKey = GlobalKey<FormState>();
  final itemsKey = GlobalKey<FormBuilderState>();
  bool isLoading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qt = '0';
    isLoading = false;
  }

  void _submitCommand() {
    //get state of our Form
    final form = formKey.currentState;

    if (form.validate() ) {
      form.save();

      _loginCommand();
    }
  }
  Future<void> _loginCommand() async {
    final form = formKey.currentState;
    setState(() {
      isLoading = true;
    });

    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('suppliers');
      await reference.add({
        "name": name,
        'company': 'pelt',

      });

      Firestore.instance.collection('company').document('pelt').updateData({
        'suppliers' : FieldValue.increment(1),
      });

    }).then((result) =>

        _showRequest());

  }

  void _showRequest() {
    // flutter defined function
    final form = formKey.currentState;
    form.reset();
    setState(() {
      isLoading = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("Your data has been added"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: new SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Container(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                        ),
                        decoration: InputDecoration(

                          errorStyle: TextStyle(color: Colors.red),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          labelText: 'Supplier Name',

                        ),
                        validator: (val) =>
                        val.isEmpty  ? 'Field cannot be empty' : null,
                        onSaved: (val) => name = val,
                        onChanged: (val){
                          setState(() {
                            name = val;
                          });
                        },

                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(70, 10, 70, 0),
                    child: MaterialButton(
                      onPressed: isLoading == true ? null: _submitCommand,
                      child : Text(isLoading == true? 'Loading ...':'Submit',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),),
                      color: Colors.white,
                      elevation: 16.0,
                      minWidth: 400,
                      height: 50,
                      textColor: Colors.purple[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
