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

class guardProfile extends StatefulWidget {
  final Map<String,dynamic> uniform ;
  final Map<String,dynamic> assets;
  String name;
  String id;
  String docID;
  String assign;
  String region;
  String pfn;

  guardProfile({
  this.uniform,
  this.pfn,
  this.name,
  this.assets,
  this.id,
  this.docID,
  this.assign,
  this.region});

  @override
  _guardProfileState createState() => _guardProfileState();
}

class _guardProfileState extends State<guardProfile> {
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
      await reference.document(widget.docID).updateData({
        "assign": assign,
        'region': region,

      });

      Firestore.instance.collection('company').document('pelt').updateData({
        'clients' : FieldValue.increment(1),
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
  String assign;
  String region;

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
          new RaisedButton(
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
                    docID: widget.docID,
                    form: "issued",
                  )));
              },
          ),

        ],
      )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: new Text('Add Item'),
        //Widget to display inside Floating Action Button, can be `Text`, `Icon` or any widget.
        onPressed: () {Navigator.of(context).push(new CupertinoPageRoute(
            builder: (context) => SOF(
              name: widget.name,
              id: widget.id,
              docID: widget.docID,
              pfn: widget.pfn,
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
                     ListTile(
                       subtitle:  Row(
                         children: [
                           Text(
                             'ID: ${widget.id}'
                             ,style: TextStyle(
                               fontSize: 14.0,
                               color:Colors.blueGrey,
                               letterSpacing: 1.5,
                               fontWeight: FontWeight.w400
                           ),
                           ),
                           SizedBox(
                             width: 10,
                           ),
                           Text(
                             'PF NO: ${widget.pfn}'
                             ,style: TextStyle(
                               fontSize: 14.0,
                               color:Colors.blueGrey,
                               letterSpacing: 1.5,
                               fontWeight: FontWeight.bold
                           ),
                           ),
                         ],
                       ),
                     ),
                      Divider(),
                      ListTile(
                        onTap: (){
                          _settingModalBottomSheet(context);
                        },
                        subtitle: Column(
                          children: [
                            Text(
                              assign == '' || assign == null ? 'Assignment: ${widget.assign}': 'Assignment: ${assign}'
                              ,style: TextStyle(
                                fontSize: 12.0,
                                color:Colors.blueGrey,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold
                            ),
                            ),
                            Text(
                              region == '' || region == null ? 'Region: ${widget.region}': 'Region: ${region}'
                              ,style: TextStyle(
                                fontSize: 12.0,
                                color:Colors.blueGrey,
                                fontWeight: FontWeight.w400
                            ),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.edit, color: Colors.purple[300],),
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
  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc){
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
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
                      SizedBox(height: 40.0,),
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
                              labelText: 'New Assignment',
                            ),
                            validator: (val) =>
                            val.isEmpty  ? 'Field cannot be empty' : null,
                            onSaved: (val) => assign = val,
                            onChanged: (val){
                              setState(() {
                                assign = val;
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
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 0),
                        child: MaterialButton(
                          onPressed: _submitCommand,
                          child : Text('Submit',
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
          );
        }
    );
  }
}

class SOF extends StatefulWidget {
  String name;
  String id;
  String docID;
  String pfn;

  SOF({
    this.name, this.id, this.docID, this.pfn
});

  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<SOF> {
  var itemTECs = <TextEditingController>[];
  var qtTECs = <TextEditingController>[];
  var cards = <Card>[];
  bool see;
  Card createCard() {
    var itemController = TextEditingController();
    var qtController = TextEditingController();
    itemTECs.add(itemController);
    qtTECs.add(qtController);
    return Card(
      child:  ListTile(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Item ${cards.length + 1}'),
            SizedBox(
              height: 60.0,
              child:  new StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("inStock").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return new Text("Please wait");
                    var length = snapshot.data.documents.length;
                    DocumentSnapshot ds = snapshot.data.documents[length - 1];
                    return new DropdownButtonFormField(
                      items: snapshot.data.documents.map((
                          DocumentSnapshot document) {
                        return DropdownMenuItem(
                            value: document.data["item"],
                            child: new Text(document.data["item"]));
                      }).toList(),
                      validator: (value) => value == null
                          ? 'Please Select a Item' : null,
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
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Container(
                child: TextFormField(
                  enabled: isLoading == true ? false: true,
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
    cards.add(createCard());
    isLoading = false;
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
      QuerySnapshot eventsQuery = await ref.where(
          'item', isEqualTo: itemTECs[i].text).getDocuments();

      eventsQuery.documents.forEach((msgDoc) {
        msgDoc.reference.updateData(
            {'count': FieldValue.increment(-(int.parse(qtTECs[i].text)))});
      });
      Firestore.instance.collection('issuance')
          .document(widget.docID)
          .updateData({
        'uniform.${itemTECs[i].text}': FieldValue.increment(
            int.parse(qtTECs[i].text)),
      });

        CollectionReference reference = Firestore.instance.collection('issued');
        CollectionReference reff = Firestore.instance.collection('issueRep');

        await reference.document(
            '${widget.id}-${DateFormat('yyyy-MM-dd').format(DateTime.now())}')
            .setData({
          "date": DateFormat(' yyyy- MM - dd').format(DateTime.now()),
          "dt": DateFormat('dd MMM yyyy').format(DateTime.now()),
          "month": DateFormat(' yyyy- MM').format(DateTime.now()),
          'timestamp': DateTime.now(),
          "company": 'pelt',
          'status': 'pending',
          'name': widget.name,
          'id': widget.id,
          'sig': bs64,

        }, merge: true);
        if (itemTECs[i].text == 'Boots' || itemTECs[i].text == 'Torch' ){
          Firestore.instance.collection('deductions')
              .document(
              '${widget.id}-${DateFormat('yyyy-MM-dd').format(DateTime.now())}')
              .setData({
            'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
            'timestamp': DateTime.now(),
            'id': widget.id,
            'name': widget.name,
            'pfn': widget.pfn,

          }, merge: true);
          Firestore.instance.collection('deductions')
              .document(
              '${widget.id}-${DateFormat('yyyy-MM-dd').format(DateTime.now())}')
              .updateData({
            'Items.${itemTECs[i].text}': FieldValue.increment(
                int.parse(qtTECs[i].text)),
          });
        }
        Firestore.instance.collection('issued')
            .document(
            '${widget.id}-${DateFormat('yyyy-MM-dd').format(DateTime.now())}')
            .updateData({
          'Items.${itemTECs[i].text}': FieldValue.increment(
              int.parse(qtTECs[i].text)),
        });

        await reff.add({
          'item': itemTECs[i].text,
          'quantity': qtTECs[i].text,
          "dt": DateFormat('dd MMM yyyy').format(DateTime.now()),
          "date": DateFormat(' yyyy- MM - dd').format(DateTime.now()),
          "month": DateFormat(' yyyy- MM').format(DateTime.now()),
          'timestamp': DateTime.now(),
          "company": 'pelt',
          'name': widget.name,
          'id': widget.id,
          'type': 'issued',
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form  (
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                        ),),
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

            ],
          ),
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