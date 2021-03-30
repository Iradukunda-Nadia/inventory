import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:inventory/Reports/issuanceReport.dart';
import 'package:inventory/Reports/supReports.dart';
import 'package:inventory/Stock/issuance.dart';
import 'package:inventory/comp/suppliers.dart';
import 'package:inventory/returns/replace.dart';
import 'package:inventory/returns/returns.dart';
import 'Stock/inStock.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState() {
    _messaging.subscribeToTopic('procurement');
    super.initState();
    _messaging.getToken().then((token) {
      print(token);
    });
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );

        print(message['notification']['title']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffC3B1E1),
        appBar: new AppBar(
          title: new Text("INVENTORY"),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: const Color(0xffC3B1E1),
        ),
      body:SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => inStock()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 60.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.arrow_downward_sharp),
                        new SizedBox(
                          height: 5.0,
                        ),
                        new Text("Stock-In"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => issue(

                        )));
                  },
                  child: new CircleAvatar(
                    maxRadius: 60.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.arrow_upward_sharp),
                        new SizedBox(
                          height: 5.0,
                        ),
                        new Text("Stock-Out"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(
              height: 20.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => Return()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 60.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.exit_to_app),
                        new SizedBox(
                          height: 5.0,
                        ),
                        new Text("Clearance"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => Replace()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 60.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.autorenew_rounded),
                        new SizedBox(
                          height: 5.0,
                        ),
                        new Text("Replacement"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(
              height: 70.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shadowColor: Colors.black12,
                color: Colors.white70,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,35.0,8.0,35.0),
                  child: StreamBuilder(
                      stream: Firestore.instance.collection("company").document('pelt').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: new ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (BuildContext context, int index) {
                                    return new IntrinsicHeight(
                                        child: new Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                           GestureDetector(
                                              onTap: (){
                                                Navigator.of(context).push(new CupertinoPageRoute(
                                                    builder: (context) => Suppliers()));

                                              },
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text('${snapshot.data['suppliers'
                                                      ].toString()}+',
                                                      style: new TextStyle(
                                                        fontSize: 40.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black87,
                                                      ),),
                                                    Text('SUPPLIER \n Reports'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(color: Colors.purpleAccent),
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.of(context).push(new CupertinoPageRoute(
                                                    builder: (context) => issuanceReport()));

                                              },
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text('3+',
                                                      style: new TextStyle(
                                                        fontSize: 40.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black87,
                                                      ),),
                                                    Text('ISSUANCE \n Reports'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Text('');
                        }
                      }),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
