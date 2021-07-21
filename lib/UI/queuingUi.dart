import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/Models/queuingModel.dart';
import 'package:http/http.dart' as http;

class Queuing extends StatefulWidget {
  List<queuingModel>queuing;
  Queuing({Key key,this.queuing}) : super(key: key);
  @override
  _QueuingState createState() => _QueuingState();
}

class _QueuingState extends State<Queuing> {
  bool x = false;List<bool> f=[false,false,false,false];
  reserve(int h){
    setState(() {
      f[h]=!f[h];
    });
  }
  showalert(int index){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Icon(
            Icons.alarm_add,
            size: 70,
            color: Colors.red[800],
          ),
          content: Padding(padding: EdgeInsets.only(left: 70),child: Text(
            'Are you Sure?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),),
          actions: [
            RaisedButton(color: Colors.blue[700],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(20))),
                child: Text("OK"),onPressed:() {
              Navigator.of(context).pop();
              reserve(index);
            }),
          ],
        );
      },
    );
  }
  getData() async {
    try {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      if (response.statusCode == 200) {
        var xvx1 = jsonDecode(response.body);
        for (var h in xvx1) {
          setState(() {
            widget.queuing.add(queuingModel.fromJson(h));
          });
        }
      }
    } catch (e) {}
  }
  Widget listReload(){
    return ListView.builder(
      itemCount: widget.queuing.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.queuing[index].doctorName!=null
                      ? Text('DR. ${widget.queuing[index].doctorName}')
                      :Text('DR. None'),
                  widget.queuing[index].doctorJobTitle!=null
                      ? Text(' (${widget.queuing[index].doctorJobTitle})')
                      :Text(''),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  widget.queuing[index].capacityQueue!=null
                      ? Text('No.in queue : ${widget.queuing[index].capacityQueue}')
                      : Text('No.in queue : None'),
                  widget.queuing[index].cost!=null
                      ? Text('Cost : ${widget.queuing[index].cost}')
                      : Text('Cost: None'),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              widget.queuing[index].startTime !=null
                  ? Text('The time of scanning: ${widget.queuing[index].startTime}')
                  : Text('The time of scanning: None'),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(right: 20)),
                  Expanded(child:  widget.queuing[index].description!=null
                      ? Text('Description: ${widget.queuing[index].description}')
                      : Text('description: None'),
                      ),
                  Padding(padding: EdgeInsets.only(right: 40)),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20))),
                      color: !f[index]?Colors.blue[700]:Colors.red[700],
                      onPressed: () {
                        showalert(index);
                      },
                      child: Text(
                        'Reserve',
                        style: TextStyle(color: Colors.white),
                      )),
                  Padding(padding: EdgeInsets.only(right: 20)),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 5))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[700],
        body: Center(
            child: RefreshIndicator(
                color: Colors.black,
                onRefresh: () {
                  setState(() {
                    widget.queuing = [];
                    x = false;
                  });
                  getData();
                  return Future.value(true);
                },
                child: widget.queuing.isEmpty == false
                    ? listReload()
                    :x == false ?
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.4)),
                    CircularProgressIndicator(),
                  ],)
                    : ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom:
                          MediaQuery.of(context).size.height * 0.3),
                    ),
                    Center(
                      child: Icon(Icons.wifi,color: Colors.white,size:100 ,),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          bottom: 10,)
                    ),
                    Center(
                      child: Text(
                        'Check The Network Connection',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
            ),
        ),
    );
  }
}
