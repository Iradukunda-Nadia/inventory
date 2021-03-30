import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class newStaff extends StatefulWidget {
  @override
  _newStaffState createState() => _newStaffState();
}

class _newStaffState extends State<newStaff> {
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
      CollectionReference reference = Firestore.instance.collection('issuance');

      await reference.add({
        'date': DateFormat(' yyyy- MM - dd').format(DateTime.now()),
        "name": name,
        'id': id,
        'company': 'pelt',
        'assign': assignment,
        'region': region,
        'pfn': pfn,
        "uniform": {},
      });

      Firestore.instance.collection('company').document('pelt').updateData({
        'staff' : FieldValue.increment(1),
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
                            labelText: 'Name',

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
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Container(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                        ),
                        decoration: InputDecoration(

                            errorStyle: TextStyle(color: Colors.red),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            labelText: 'ID Number',

                        ),
                        validator: (val) =>
                        val.isEmpty  ? 'Field cannot be empty' : null,
                        onSaved: (val) => id = val,
                        onChanged: (val){
                          setState(() {
                            id = val;
                          });
                        },

                      ),
                    ),
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
                          labelText: 'Assignment',

                        ),
                        validator: (val) =>
                        val.isEmpty  ? 'Field cannot be empty' : null,
                        onSaved: (val) => assignment = val,
                        onChanged: (val){
                          setState(() {
                            assignment = val;
                          });
                        },

                      ),
                    ),
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
                          labelText: 'Region',

                        ),
                        validator: (val) =>
                        val.isEmpty  ? 'Field cannot be empty' : null,
                        onSaved: (val) => region = val,
                        onChanged: (val){
                          setState(() {
                            region = val;
                          });
                        },

                      ),
                    ),
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
                          labelText: 'PF NO.',

                        ),
                        validator: (val) =>
                        val.isEmpty  ? 'Field cannot be empty' : null,
                        onSaved: (val) => pfn = val,
                        onChanged: (val){
                          setState(() {
                            pfn = val;
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
