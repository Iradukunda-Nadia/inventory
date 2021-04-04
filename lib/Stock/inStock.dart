import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';


class inStock extends StatefulWidget {
  @override
  _inStockState createState() => _inStockState();
}

class _inStockState extends State<inStock> {
  String _cat;
  String Item;
  String qt;
  String up;
  String supplier;

  Future getCourse() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("inStock").where("type", isEqualTo: _cat ).getDocuments();
    return qn.documents;

  }
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qt = '0';
    up ='0';
    setState(() {
      _cat = "uniform";
    });
  }
  var qtController = TextEditingController();
  var upController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Items In Stock"), centerTitle: true,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: new Text('Add Item'),
        //Widget to display inside Floating Action Button, can be `Text`, `Icon` or any widget.
        onPressed: () {Navigator.of(context).push(new CupertinoPageRoute(
            builder: (context) => addStock()));
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Flexible(
                  child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      minHeight: 20.0,
                      maxHeight: 40.0,
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: MaterialButton(
                            onPressed: (){
                              setState(() {
                                _cat = "uniform";
                              });
                            },
                            child: Text(_cat == 'uniform'?  'UNIFORMS': 'Uniforms',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'SFUIDisplay',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: _cat == 'uniform'?  Colors.purple[300]: const Color(0xffC3B1E1,),
                            elevation: 10.0,
                            minWidth: 150,
                            height: _cat == 'uniform'?  20: 30,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: MaterialButton(
                            onPressed: (){
                              setState(() {
                                _cat = "asset";
                              });
                            },
                            child: Text(_cat == 'asset'?  'ASSETS': 'Assets',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'SFUIDisplay',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: _cat == 'asset'?  Colors.purple[300]: const Color(0xffC3B1E1,),
                            elevation: 10.0,
                            minWidth: 150,
                            height: _cat == 'asset'?  20: 30,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                new Flexible(
                  fit: FlexFit.loose,
                  child: StreamBuilder(
                      stream: Firestore.instance.collection("inStock").where("type", isEqualTo: _cat ).snapshots(),
                      builder: (context, snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: Text("Loading... Please wait"),
                          );
                        }if (snapshot.data == null){
                          return Center(
                            child: Text("There is no data"),);
                        }else{
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return new GestureDetector(
                                onTap: (){},
                                child: new Card(
                                  child: Stack(
                                    alignment: FractionalOffset.topLeft,
                                    children: <Widget>[
                                      new ListTile(
                                        title: new Text("${snapshot.data[index].data["item"]}",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 25.0,
                                              ),),
                                        trailing: new Text("${(snapshot.data[index].data["count"]).toString()}",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 30.0,
                                              ),),
                                      ),

                                    ],
                                  ),
                                ),
                              );

                            },
                          );

                        }
                      }),)
              ]
          ),
        ),
      ),
    );
  }
}

class addStock extends StatefulWidget {
  @override
  _addStockState createState() => _addStockState();
}

class _addStockState extends State<addStock> {
  String _cat;
  String Item;
  String qt;
  String up;
  String supplier;

  Future getCourse() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("inStock").where("type", isEqualTo: _cat ).getDocuments();
    return qn.documents;

  }
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qt = '0';
    up ='0';
    setState(() {
      _cat = "uniform";
    });
    isLoading = false;
  }
  var qtController = TextEditingController();
  var upController = TextEditingController();
  bool isLoading;
  void _submitCommand() {
    //get state of our Form
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      _loginCommand();
    }
  }
  Future<void> _loginCommand() async {
    final form = formKey.currentState;
    setState(() {
      isLoading = true;

    });

    print('Loading');

    CollectionReference ref = Firestore.instance
        .collection('inStock');

    QuerySnapshot eventsQuery =  await ref.where('item', isEqualTo: Item).getDocuments();

    eventsQuery.documents.forEach((msgDoc) {
      msgDoc.reference.updateData({'count': FieldValue.increment(int.parse(qt))});
    });

    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('addedStock');

      await reference.add({
        "Item": Item,
        "Quantity": qt,
        "unitPrice": up,
        "Total": (int.parse(up)*int.parse(qt)).toString(),
        "supplier": supplier,
        "date" : DateFormat(' yyyy- MM - dd').format(DateTime.now()),
        "month" : DateFormat(' yyyy- MM').format(DateTime.now()),
        'timestamp': DateTime.now(),
        "company": 'pelt',
        'status': 'pending',
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
      body: new SafeArea(
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
                          value: Item,
                          validator: (value) => value == null
                              ? 'Please Select a Item' : null,
                          onChanged: (value) {
                            print(value);

                            setState(() {
                              Item = value;
                            });
                          },
                          hint: new Text("Select Item"),
                          style: TextStyle(color: Colors.black),

                        );
                      }
                  ),
                ),
                SizedBox(
                  height: 60.0,
                  child:  new StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection("suppliers").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return new Text("Please wait");
                        var length = snapshot.data.documents.length;
                        DocumentSnapshot ds = snapshot.data.documents[length - 1];
                        return new DropdownButtonFormField(
                          items: snapshot.data.documents.map((
                              DocumentSnapshot document) {
                            return DropdownMenuItem(
                                value: document.data["name"],
                                child: new Text(document.data["name"]));
                          }).toList(),
                          value: supplier,
                          validator: (value) => value == null
                              ? 'Please Select a supplier' : null,
                          onChanged: (value) {
                            print(value);

                            setState(() {
                              supplier = value;
                            });
                          },
                          hint: new Text("Select Supplier"),
                          style: TextStyle(color: Colors.black),

                        );
                      }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Container(
                    child: TextFormField(
                      controller: qtController,
                      keyboardType: TextInputType.numberWithOptions(decimal: false),
                      textCapitalization: TextCapitalization.sentences,
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
                      onSaved: (val) => qt = val,
                      onChanged: (val){
                        setState(() {
                          qt = val;
                        });
                      },

                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Container(
                    child: TextFormField(
                      controller: upController,
                      keyboardType: TextInputType.numberWithOptions(decimal: false),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SFUIDisplay'
                      ),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          suffixText: '(KSH)',
                          labelText: 'Unit Price',
                          labelStyle: TextStyle(
                              fontSize: 11
                          )
                      ),
                      validator: (val) =>
                      val.isEmpty  ? 'Field cannot be empty' : null,
                      onSaved: (val) => up = val,
                      onChanged: (val){
                        setState(() {
                          up = val;
                        });
                      },
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: ListTile(
                    title: Text('Total (KSH)', style: TextStyle(fontSize: 11),),
                    subtitle:  Text(qtController.text == '' || upController.text == '' ? '...':(int.parse(qtController.text)*int.parse(upController.text)).toString()),
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
        ),
      ),
    );
  }
}
