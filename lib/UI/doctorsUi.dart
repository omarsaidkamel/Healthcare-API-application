import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/Models/doctorModel.dart';
import 'package:http/http.dart' as http;
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';

class Doctors extends StatefulWidget {
  List<doctorModel>doc;
  Doctors({Key key,this.doc}) : super(key: key);
  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  bool x = false;
  getData() async {
    try {
      var response = await http.get(Uri.parse('http://kirollos:8070/get_employees'));
      if (response.statusCode == 200) {
        var xvx1 = jsonDecode(response.body);
        for (var h in xvx1) {
          setState(() {
            widget.doc.add(doctorModel.fromJson(h));
          });
        }
      }
      print("$response");
    } catch (e) {
      setState(() {
        x = true;
      });
    }
  }

  Widget listReload(){
    return ListView.builder(
      itemCount: widget.doc.length,
      itemBuilder: (context, index) {
        return Card(color: Colors.white,
          child: Column(mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(color: Colors.blue[700],
                    height: 30,
                  ),
                 Center(
                    child:CircleAvatar(
                      backgroundImage:
                      widget.doc[index].image!=null
                          //? NetworkImage('${widget.doc[index].image}')
                          ? AssetImage('${widget.doc[index].image}')
                          : Image.asset('Image/blank-profile.png'),
                      radius: 30,
                    ),),
                ],
              ),
                   Padding(padding:EdgeInsets.only(top: 10) ),
                   widget.doc[index].fullName != null
                       ? Text('DR.${widget.doc[index].fullName}',style: TextStyle(fontWeight: FontWeight.bold),)
                       : Text('None',style: TextStyle(fontWeight: FontWeight.bold),),
                   Padding(padding:EdgeInsets.only(top: 10) ),
                  widget.doc[index].qualification != null
                      ? Text('${widget.doc[index].qualification}')
                      : Text('None'),
                   Padding(padding:EdgeInsets.only(top: 10) ),
                  widget.doc[index].nationality != null
                      ? Text('${widget.doc[index].nationality}')
                      : Text('None'),
                   Padding(padding:EdgeInsets.only(top: 10) ),
                  widget.doc[index].dateofscan != null
                      ? Text('${widget.doc[index].dateofscan}')
                      : Text('None'),
                   Padding(padding:EdgeInsets.only(bottom: 10) ),
            ],
          ),
        );
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[700],
        body: Center(
          child: RefreshIndicator(color: Colors.black,
              onRefresh: () {
                setState(() {
                  widget.doc = [];
                  x = false;
                });
                getData();
                return Future.value(true);
              },
              child: widget.doc.isEmpty == false
                  ? listReload()
                   : x == false
                     ? Column(
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
        ),),
    );
  }
}
