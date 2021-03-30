import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;


class Summary extends StatefulWidget {
  final Map<String,dynamic> uniform ;
  final Map<String,dynamic> assets;
  String name;
  String id;
  String docID;
  String form;
  String region;
  String assign;
  String reason;
  String dateCleared;
  String pfn;
  Summary({
    this.uniform,
    this.name,
    this.assets,
    this.id,
    this.docID,
    this.form,
    this.region,
    this.assign,
    this.dateCleared,
    this.reason,
    this.pfn,
  });

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Summary"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color(0xffC3B1E1),
      ),
      body:  Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: new StreamBuilder(
                      stream: Firestore.instance.collection(widget.form).where('id',isEqualTo: widget.id).orderBy('timestamp', descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<DocumentSnapshot> documents = snapshot.data.documents;
                          return ListView(
                              children: documents
                                  .map((doc) => Card(
                                child:
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(new CupertinoPageRoute(
                                        builder: (context) => SummaryDetail(
                                          name: doc['name'].toUpperCase(),
                                          id: doc['id'],
                                          date: doc['date'] ,
                                          docID: doc.documentID,
                                          userID: widget.docID,
                                          form: widget.form,
                                          sign: doc['sig'],
                                          assign: widget.assign,
                                          region: widget.region,
                                          dateCleared: widget.dateCleared,
                                          reason: widget.reason,
                                          pfn: widget.pfn,
                                        )));
                                  },
                                  title: Text(doc['dt'],
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  ),
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

class SummaryDetail extends StatefulWidget {
  final Map<String,dynamic> uniform ;
  final Map<String,dynamic> assets;
  String name;
  String id;
  String docID;
  String userID;
  String date;
  String sign;
  String form;
  String region;
  String assign;
  String reason;
  String dateCleared;
  String pfn;

  SummaryDetail({
    this.uniform,
    this.name,
    this.assets,
    this.id,
    this.docID,
    this.userID,
    this.date,
    this.sign,
    this.form,
    this.region,
    this.assign,
    this.dateCleared,
    this.reason,
    this.pfn,
  });

  @override
  _SummaryDetailState createState() => _SummaryDetailState();
}

class _SummaryDetailState extends State<SummaryDetail> {

  final _renderObjectKey = GlobalKey<ScaffoldState>();
  Future<Uint8List> _getWidgetImage() async {
    try {
      RenderRepaintBoundary boundary =
      _renderObjectKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      debugPrint(bs64.length.toString());
      return pngBytes;
    } catch (exception) {}
  }
  Future<void> _printScreen() async {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pdf.Document();
      final image = pdf.MemoryImage(
        base64Decode(widget.sign),
      );
      final img = await WidgetWraper.fromKey(
        key: _renderObjectKey,
        pixelRatio: 2.0,
      );

      doc.addPage(pdf.Page(
          pageFormat: format,
          build: (pdf.Context context) {
            return pdf.Column(
              children: [
                pdf.Expanded(
                  child: pdf.Image(img),
                ),
                pdf.Row(
                  children: [
                    pdf.Text('Signature: '),
                    pdf.SizedBox(width: 20),
                    pdf.Image(image),
                  ]
                ),

              ]
            );
          }));

      return doc.save();
    });
}


  @override
  Widget build(BuildContext context) {
    final decodedBytes = base64Decode(widget.sign);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){_printScreen();},
        child: Icon(Icons.print_rounded,),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            RepaintBoundary(
              key: _renderObjectKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Name: ${widget.name}'
                    ,style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'ID: ${widget.id}'
                        ,style: TextStyle(
                          fontSize: 12.0,
                          color:Colors.blueGrey,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w400
                      ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      VerticalDivider(),
                      Text(
                        'PF.NO.: ${widget.pfn}'
                        ,style: TextStyle(
                          fontSize: 12.0,
                          color:Colors.blueGrey,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w400
                      ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  widget.form != 'cleared' ? new Offstage():Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Assignment: ${widget.assign}'
                          ,style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400
                        ),
                        ),
                        Text(
                          'Reason For discharge: ${widget.reason}'
                          ,style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400
                        ),
                        ),
                        Text(
                          'Clearance date: ${widget.dateCleared}'
                          ,style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400
                        ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize:MainAxisSize.min,
                      children: <Widget>[

                        SizedBox(
                          height: 20,
                        ),
                        new StreamBuilder(
                            stream: Firestore.instance.collection(widget.form).document(widget.docID).snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final Map<String,dynamic> items = Map<String, dynamic>.from(snapshot.data["Items"]) ;
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
                                          new Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  new SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  new Text(
                                                    '$key',
                                                    style: new TextStyle(color: Colors.black, fontSize: 18.0,),
                                                  )
                                                ],
                                              ),
                                              new Text(
                                                "${items[key].toString()}",
                                                style: new TextStyle(
                                                    fontSize: 11.0,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          new SizedBox(
                                            height: 5.0,
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
                        SizedBox(
                          height: 20,
                        ),

                        widget.form != 'cleared' ? new Offstage(): new StreamBuilder(
                            stream: Firestore.instance.collection("issuance").document(widget.userID).snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final Map<String,dynamic> items = Map<String, dynamic>.from(snapshot.data["uniform"]) ;
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    new Text('Uncleared Items'),
                                    Flexible(
                                      child: new ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: items.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          String key = items.keys.elementAt(index);
                                          return Column(
                                            children: [
                                              new Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  items[key] <= 0? new Offstage(): new Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      new Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: <Widget>[
                                                          new SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          new Text(
                                                            '$key',
                                                            style: new TextStyle(color: Colors.black, fontSize: 18.0,),
                                                          )
                                                        ],
                                                      ),
                                                      new Text(
                                                        "${items[key].toString()}",
                                                        style: new TextStyle(
                                                            fontSize: 11.0,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                    ],
                                                  ),
                                                  new SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  new Divider(
                                                    height: 2.0,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Text('');
                              }
                            }),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.sign == null ? new Offstage() :Row(
              children: [
                new Text('SIGNATURE:'),
                SizedBox(
                  width: 20,
                ),
                Container(
                    child: Image.memory(
                      base64Decode(widget.sign),
                    )
                ),
              ],
            ),
          ],
        ),


      ),
    );
  }
}
