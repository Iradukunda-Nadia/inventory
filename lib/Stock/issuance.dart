import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory/Stock/profile.dart';
import 'newStaff.dart';

class issue extends StatefulWidget {
  @override
  _issueState createState() => _issueState();
}

class _issueState extends State<issue> {
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
        title: Text('Issuance'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: new Text('New Staff'),
        //Widget to display inside Floating Action Button, can be `Text`, `Icon` or any widget.
        onPressed: () {
          Navigator.of(context).push(new CupertinoPageRoute(
              builder: (context) => newStaff()));
        },
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
                  stream: Firestore.instance.collection("issuance").orderBy('assign', descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                      // ignore: missing_return
                      final List<DocumentSnapshot> documents = snapshot.data.documents;
                      return ListView(
                          children: documents
                              // ignore: missing_return
                              .map((doc) => Card(
                            child: doc['name'].toLowerCase().contains(searchController.text.toLowerCase()) || doc['id'].contains(searchController.text.toLowerCase())  ?
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(new CupertinoPageRoute(
                                    builder: (context) => guardProfile(
                                      uniform: Map<String, dynamic>.from(doc.data["uniform"]),
                                      name: doc['name'].toUpperCase(),
                                      id: doc['id'],
                                      assign: doc['assign'],
                                      region: doc['region'],
                                      docID: doc.documentID,
                                      )));
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars.png',
                                ),
                              ),
                              title: Text(doc['name'].toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              ),
                              subtitle: Text('ID: ${doc['id']}'),
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
    );
  }
}


