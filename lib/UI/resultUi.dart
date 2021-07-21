import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/Models/resultModel.dart';
import 'package:http/http.dart' as http;

class resultModelUi extends StatefulWidget {
  final String S;
  List<resultModel>resultModelAll;
  resultModelUi({Key key, this.S,this.resultModelAll}) : super(key: key);
  @override
  _resultModelUiState createState() => _resultModelUiState();
}

class _resultModelUiState extends State<resultModelUi> {
  bool x = false;
  Widget listReload() {
    return ListView.builder(
      itemCount: widget.resultModelAll.length,
      itemBuilder: (context, index) {
        return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ListTile(
              onTap: () {if(widget.resultModelAll[index].result != null) showImage(widget.resultModelAll[index].result);},
              title:Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: widget.resultModelAll[index].drName!=null
                        ?Text("Dr. ${widget.resultModelAll[index].drName}")
                        :Text("Dr. None"),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child:  widget.resultModelAll[index].dateTime!=null
                        ?Text("Date: ${widget.resultModelAll[index].dateTime}")
                        :Text("Date: 12/3/2010"),
                  ),
                 ],),
              subtitle: widget.resultModelAll[index].note!=null
                  ?Text("Note: ${widget.resultModelAll[index].note}")
                  :Text("Note: None"),
              leading: Container(
                child: (widget.resultModelAll[index].result)!=null
                  //?Image.network("${widget.resultModelAll[index].result}")
                  ?Image.asset("${widget.resultModelAll[index].result}")
                    :Image.asset('Image/broken_image.png',),
              ),
            ));
      },
    );
  }

  showImage(String X) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: InteractiveViewer(
                child:Image.asset(X)
               // child:Image.network(X)
            ),
          );
        });
  }

  getData() async {
    try {
      var responseAnalysis = await http.get(Uri.parse('${widget.S}'));
      if (responseAnalysis.statusCode == 200) {
        var xvx1 = jsonDecode(responseAnalysis.body);
        for (var h in xvx1) {
          setState(() {
            widget.resultModelAll.add(resultModel.fromJson(h));
          });
        }
      }
    } catch (e) {
      setState(() {
        x = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: Center(
        child: RefreshIndicator(color: Colors.black,
                onRefresh: () {
                 setState(() {
                  widget.resultModelAll = [];
                  x = false;
                 });
                  getData();
                  return Future.value(true);
                },
                child:(widget.resultModelAll.isEmpty == false)
                    ? listReload()
                    : x == false
                       ? Column(
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.2)),
                    CircularProgressIndicator(),
                  ],)
                       : ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom:
                          MediaQuery.of(context).size.height * 0.1),
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