import 'package:flutter/material.dart';
import 'package:inventory/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.nadia.e_lorry';

  var uid = prefs.getString('company');
  print(uid);
  runApp(
    MaterialApp(
        title: 'Inventory',
        theme: ThemeData(
          primaryColor: const Color(0xffC3B1E1,),
          accentColor: Colors.purple[300],

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),


        home: uid == null ? Login() : Dashboard(userID: uid,)),
  );

}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _password;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void _submitCommand() {
    //get state of our Form
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      setState(() {
        _errorMessage = "";
      });
      _loginCommand();
    }
  }


  _loginCommand() async {
    var collectionReference = Firestore.instance.collection('users');
    var query = collectionReference.where('id', isEqualTo: _password);
    query.getDocuments().then((querySnapshot) {
      if (querySnapshot.documents.length == 0) {
        setState(() {
          _errorMessage = 'invalid login details';
        });

      } else {
        querySnapshot.documents.forEach((document)
        async {

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user', document['dept']);
          prefs.setString('company', document['company']);
          prefs.setString('logo', document['logo']);
          FirebaseMessaging().subscribeToTopic('all${document['company']}');
          FirebaseMessaging().subscribeToTopic('${document['dept']}-${document['company']}');
          Navigator.of(context).pushReplacement(new CupertinoPageRoute(
              builder: (BuildContext context) => new Dashboard()
          ));




        });
      }
    });
  }
  String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC3B1E1),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Welcome', style: TextStyle(fontSize: 30, color: Colors.white, fontFamily: 'DelaGothicOne'),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 8.0),
                child: new TextFormField(
                  maxLines: 1,
                  obscureText: true,
                  autofocus: false,
                  decoration: new InputDecoration(
                      hintText: 'Please enter your Key',
                      ),
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  validator: (value) => value.length < 5 ? 'The Key should be atleast 5 characters' : null,
                  onSaved: (value) => _password = value,
                ),
              ),
              showErrorMessage(),
              Padding(
                padding: EdgeInsets.fromLTRB(70, 10, 70, 0),
                child: MaterialButton(
                  onPressed: _submitCommand,
                  child: Text('SIGN IN',

                  ),
                  color: Colors.purple[300],
                  elevation: 16.0,
                  minWidth: 400,
                  height: 50,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget showErrorMessage() {
    if (_errorMessage != "" && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}

