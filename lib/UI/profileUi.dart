import 'package:flutter/material.dart';
import 'package:login/Models/patientModel.dart';
import 'package:login/Models/resultModel.dart';
import 'package:login/UI/analysisUi.dart';
import 'package:login/UI/prescriptionUi.dart';
import 'package:login/UI/xrayUi.dart';

class Profile extends StatefulWidget {
  final Patient patient;
  List<resultModel>resultModelA;List<resultModel>resultModelPer;List<resultModel>resultModelX;
  Profile({Key key, this.patient,this.resultModelX,this.resultModelPer,this.resultModelA}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int current = 0;
  PageController _c;
  void initState() {
    _c = new PageController(
      initialPage: current,
    );
    super.initState();
  }
  Widget chooseResult(String s,int c){
    return Stack(
      children: [
        Container(
          color: current == c ? Colors.black : Colors.blue[800],
          width: 100,
          height: 50,
        ),
        Container(
          color: Colors.blue[800],
          width: 100,
          height: 48,
          child: TextButton(
            child: Container(child: Image.asset(s)),
            onPressed: () {
              this._c.animateToPage(c,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutSine);
              setState(() {
                Future.delayed(Duration(milliseconds: 500))
                    .then((value) => current = c);
              });
              //_c.jumpToPage(current);
            },
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: Column(
        children: [
          // Padding(padding: EdgeInsets.only(top: 50)),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 15, top: 130)),
                CircleAvatar(backgroundColor: Colors.white,
                  /*backgroundImage:widget.patient.image!=null
                      ?NetworkImage(widget.patient.image)
                      //:AssetImage('Image/blank-profile.png'),
                      :*/backgroundImage:AssetImage('Image/p.jpg'),
                  radius: MediaQuery.of(context).size.height * 0.08,
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   /* widget.patient.fullName!=null
                        ? Text('Name: ${widget.patient.fullName}', style: TextStyle(fontWeight: FontWeight.bold))
                        :*/ Text('Name: Ahmed Mohamed Samy', style: TextStyle(fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.only(top: 15)),
                   /* widget.patient.age!=null
                        ?Text('Age: ${widget.patient.age}', style: TextStyle(fontWeight: FontWeight.bold),)
                        :*/Text('Age: 25', style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(padding: EdgeInsets.only(top: 15)),
                    /*widget.patient.nationalID!=null
                        ?Text('NationalId: ${widget.patient.nationalID}', style: TextStyle(fontWeight: FontWeight.bold),)
                        :*/Text('National Id: 23526458491321', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue[800],
                border: Border.all(color: Colors.black)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                chooseResult('Image/lab.png', 0),
                chooseResult('Image/x-ray.png', 1),
                chooseResult('Image/prescription.png', 2),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: PageView(
                controller: _c,
                onPageChanged: (newPage) {
                  setState(() {
                    this.current = newPage;
                  });
                },
                children: [
                  anslysisUi(resultModelA: widget.resultModelA,),
                  xrayUi(resultModelX: widget.resultModelX,),
                  PrescriptionUi(resultModelPer: widget.resultModelPer,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
