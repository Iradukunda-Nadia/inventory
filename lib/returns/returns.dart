import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as encoder;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Stock/summary.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Return extends StatefulWidget {
  @override
  _ReturnState createState() => _ReturnState();
}

class _ReturnState extends State<Return> {
  TextEditingController searchController = TextEditingController();
  String sQuery;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sQuery = '';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clearance'),
        centerTitle: true,
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
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))
                ),
              ),
            ),
            Expanded(
                child: new StreamBuilder(
                    stream: Firestore.instance.collection("issuance").where('company',isEqualTo: userCompany).orderBy('assign', descending: true).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                        // ignore: missing_return
                        final List<DocumentSnapshot> documents = snapshot.data.documents;
                        return ListView(
                            children: documents
                            // ignore: missing_return
                                .map((doc) => doc['name'].toLowerCase().contains(searchController.text.toLowerCase()) || doc['id'].contains(searchController.text.toLowerCase()) ?
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(new CupertinoPageRoute(
                                    builder: (context) => Clearance(
                                      uniform: Map<String, dynamic>.from(doc.data["uniform"]),
                                      name: doc['name'].toUpperCase(),
                                      id: doc['id'],
                                      assign: doc['assign'],
                                      region: doc['region'],
                                      docID: doc.documentID,
                                      reason: doc['reason'],
                                      dateCleared: doc['dateCleared'],
                                      pfn: doc['pfn'],
                                    )));
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars.png',
                                ),
                              ),
                              title: Text(doc['name'].toUpperCase(),

                              ),
                              subtitle: Text('ID: ${doc['id']}'),
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

class Clearance extends StatefulWidget {
  final Map<String,dynamic> uniform ;
  final Map<String,dynamic> assets;
  String name;
  String id;
  String docID;
  String region;
  String assign;
  String dateCleared;
  String reason;
  String pfn;

  Clearance({
    this.uniform,
    this.name,
    this.assets,
    this.id,
    this.docID,
    this.assign,
    this.region,
    this.dateCleared,
    this.reason,
    this.pfn,
  });

  @override
  _ClearanceState createState() => _ClearanceState();
}

class _ClearanceState extends State<Clearance> {
  String Item;
  String qt;

  final formKey = GlobalKey<FormState>();
  bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qt = '0';
    isLoading = false;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        actions: <Widget>[
          new Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              RaisedButton(
                elevation: 5.0,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                color: Colors.red[700],
                child: new Text('Summary',
                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: (){
                  Navigator.of(context).push(new CupertinoPageRoute(
                      builder: (context) => Summary(
                        name: widget.name,
                        id: widget.id,
                        form: "cleared",
                        docID: widget.docID,
                        assign : widget.assign,
                        region: widget.region,
                        reason: widget.reason,
                        dateCleared: widget.dateCleared,
                        pfn: widget.pfn
                      )));
                },
              )


            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: new Text('Clear'),
        //Widget to display inside Floating Action Button, can be `Text`, `Icon` or any widget.
        onPressed: () {Navigator.of(context).push(new CupertinoPageRoute(
            builder: (context) => details(
              name: widget.name,
              id: widget.id,
              docID: widget.docID,
              company: userCompany,
            )));
        },
      ),
      body: new Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            new SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: Container(
                        alignment: Alignment(0.0,2.5),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars.png',
                          ),
                          radius: 60.0,
                        ),
                      ),
                    ),
                    Text(
                      'Name: ${widget.name}'
                      ,style: TextStyle(
                        fontSize: 18.0,
                        color:Colors.blueGrey,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ID: ${widget.id}'
                      ,style: TextStyle(
                        fontSize: 18.0,
                        color:Colors.blueGrey,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w400
                    ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new Card(child: new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize:MainAxisSize.min,
                        children: <Widget>[
                          Center(
                            child: new Text(
                              "Items",
                              style: new TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700),
                            ),
                          ),
                          new StreamBuilder(
                              stream: Firestore.instance.collection("issuance").document(widget.docID).snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final Map<String,dynamic> items = Map<String, dynamic>.from(snapshot.data["uniform"]) ;
                                  return Flexible(
                                    child: new ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: items.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        String key = items.keys.elementAt(index);
                                        return new Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            new ListTile(
                                              title: new Text("$key"),
                                              subtitle: new Text("${items[key].toString()}"),
                                            ),
                                            new Divider(
                                              height: 2.0,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Text('');
                                }
                              }),

                        ],
                      ),
                    ),),
                  ]
              ),
            ),
          ]
      ),
    );
  }
}

class details extends StatefulWidget {
  String name;
  String id;
  String docID;
  String company;
  details({
    this.name, this.id, this.docID, this.company
  });
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  var itemTECs = <TextEditingController>[];
  var qtTECs = <TextEditingController>[];
  var cards = <Card>[];
  bool see;
  var itemController = TextEditingController();
  var qtController = TextEditingController();
  Card createCard() {

    itemTECs.add(itemController);
    qtTECs.add(qtController);
    return Card(
      child:  ListTile(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Item ${cards.length + 1}'),
            new StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("inStock").where('company', isEqualTo: widget.company).orderBy('item', descending: false).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return new Text("Please wait");
                  var length = snapshot.data.documents.length;
                  DocumentSnapshot ds = snapshot.data.documents[length - 1];
                  return FormBuilderDropdown(
                    attribute: 'item',
                    items: snapshot.data.documents.map((
                        DocumentSnapshot document) {
                      return  DropdownMenuItem(
                          value: document.data["item"],
                          child: new Text(document.data["item"]));
                    }).toList(),
                    validators: [FormBuilderValidators.required()],
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        itemController.text = value;
                      });
                    },
                    hint: new Text("Select Item"),
                    style: TextStyle(color: Colors.black),
                  );
                }
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Container(
                child: TextFormField(

                  controller: qtController,
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                  ),
                  decoration: InputDecoration(

                      errorStyle: TextStyle(color: Colors.red),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      labelText: 'Quantity',
                      labelStyle: TextStyle(
                          fontSize: 11
                      )
                  ),
                  validator: (val) =>
                  val.isEmpty  ? 'Field cannot be empty' : null,
                  onChanged: (val){
                  },

                ),
              ),
            ),
          ],
        ),
        trailing: InkWell(
            onTap: (){
              setState(() {
                cards.removeAt(cards.length-1);
                itemTECs.removeAt(itemTECs.length-1);
                qtTECs.removeAt(qtTECs.length-1);
              });
            },
            child: Icon(Icons.delete,
                color: Colors.red) ),

      ),
    );
  }
  @override
  void initState() {
    super.initState();
    getStringValue();
    cards.add(createCard());
    isLoading = false;

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
  final formKey = GlobalKey<FormState>();
  void _submitCommand() {
    //get state of our Form
    final form = formKey.currentState;

    if (form.validate() && _signKey.currentState.validate()) {
      form.save();
      _signKey.currentState.save();
      _loginCommand();

    }
  }
  bool isLoading;

  final SignatureController _controller = new SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.blue[900],
    exportBackgroundColor: Colors.transparent,
  );

  String _uploadedFileURL;

  Future<void> _loginCommand() async {
    final form = formKey.currentState;
    setState(() {
      isLoading = true;

    });

    print('Loading');
    CollectionReference ref = Firestore.instance
        .collection('inStock');

    Uint8List data = await _controller.toPngBytes();
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/sign.jpg').create();
    file.writeAsBytesSync(data);
    String bs64 = base64Encode(data);

    for (int i = 0; i < cards.length; i++) {
      QuerySnapshot eventsQuery = await ref.where('company', isEqualTo: userCompany).where(
          'item', isEqualTo: itemTECs[i].text).getDocuments();

      eventsQuery.documents.forEach((msgDoc) {
        msgDoc.reference.updateData(
            {'count': FieldValue.increment(int.parse(qtTECs[i].text))});
      });
      Firestore.instance.collection('issuance')
          .document(widget.docID)
          .updateData({
        'uniform.${itemTECs[i].text}': FieldValue.increment(
            -(int.parse(qtTECs[i].text))),
        'dateCleared': DateFormat(' yyyy- MM - dd').format(DateTime.now()),
        'reason': reason,
        'company': userCompany,
      });

      CollectionReference reference = Firestore.instance.collection('cleared');
      CollectionReference reff = Firestore.instance.collection('issueRep');

      await reference.document(
          '${widget.id}-${DateFormat('yyyy-MM-dd').format(DateTime.now())}')
          .setData({
        "date": DateFormat(' yyyy- MM - dd').format(DateTime.now()),
        "dt": DateFormat('dd MMM yyyy').format(DateTime.now()),
        "month": DateFormat(' yyyy- MM').format(DateTime.now()),
        'timestamp': DateTime.now(),
        "company": userCompany,
        'status': 'pending',
        'name': widget.name,
        'id': widget.id,
        'sig': bs64,

      }, merge: true);


      Firestore.instance.collection('cleared')
          .document(
          '${widget.id}-${DateFormat('yyyy-MM-dd').format(DateTime.now())}')
          .updateData({
        'Items.${itemTECs[i].text}': FieldValue.increment(
            int.parse(qtTECs[i].text)),
      });

      await reff.add({
        'item': itemTECs[i].text,
        'quantity': '-${qtTECs[i].text}',
        "dt": DateFormat('dd MMM yyyy').format(DateTime.now()),
        "date": DateFormat(' yyyy- MM - dd').format(DateTime.now()),
        "month": DateFormat(' yyyy- MM').format(DateTime.now()),
        'timestamp': DateTime.now(),
        "company": userCompany,
        'name': widget.name,
        'id': widget.id,
        'type': 'Cleared',
      });
    }
    _showRequest();
  }

  void _showRequest() {
    // flutter defined function
    final form = formKey.currentState;
    print (_signKey.currentState.value);
    form.reset();
    _signKey.currentState.reset();
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
  final _signKey = GlobalKey<FormBuilderState>();
String dDate;
String reason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form  (
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      style: TextStyle(
                          color: Colors.black,
                      ),
                      decoration: InputDecoration(

                          errorStyle: TextStyle(color: Colors.red),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          labelText: 'Reason for being discharged',

                      ),
                      validator: (val) =>
                      val.isEmpty  ? 'Field cannot be empty' : null,
                      onChanged: (val){
                        reason = val;
                      },
                      onSaved: (val){
                        reason = val;
                      },

                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cards.length,
                          itemBuilder: (BuildContext context, int index) {
                            return cards[index];
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RaisedButton(
                            child: Text('add another item'),
                            onPressed: () => setState(() => cards.add(createCard())),
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
            FormBuilder(
              key: _signKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,0.0),
                child: FormBuilderSignaturePad(
                  controller: _controller,
                  decoration: InputDecoration(labelText: "Signature"),
                  attribute: "signature",
                  height: 150,

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(70, 10, 70, 0),
              child: MaterialButton(
                onPressed: isLoading == true ? null: _submitCommand,
                child : Text( isLoading == true? 'Loading ...':'Submit',
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
    );
  }
}

class PersonEntry {
  final String item;
  final String qt;

  PersonEntry(this.item, this.qt,);
  @override
  String toString() {
    return 'Person: name= $item, age= $qt';
  }
}