import 'package:flutter/material.dart';
import 'package:login/Models/patientModel.dart';
import 'package:login/Models/resultModel.dart';
import 'package:login/UI/doctorsUi.dart';
import 'package:login/UI/profileUi.dart';
import 'package:login/UI/queuingUi.dart';
import 'Models/doctorModel.dart';
import 'Models/queuingModel.dart';

class MainHC extends StatefulWidget {
  final Patient patient;
  List<doctorModel>doctors;List<queuingModel>queuing;
  List<resultModel>resultModelA;List<resultModel>resultModelPer;List<resultModel>resultModelX;
  MainHC({Key key,this.patient,this.doctors,this.queuing,this.resultModelA,this.resultModelPer,this.resultModelX}) : super(key: key);
  @override
  _MainHCState createState() => _MainHCState();
}

class _MainHCState extends State<MainHC> {
  int current = 0;
  PageController _c;
  void initState() {
    _c = new PageController(
      initialPage: current,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _c,
        onPageChanged: (newPage) {
          setState(() {
            this.current = newPage;
          });
        },
        children: [
          Profile(patient: widget.patient,resultModelA: widget.resultModelA,resultModelPer: widget.resultModelPer,resultModelX: widget.resultModelX,),
          Queuing(queuing: widget.queuing,),
          Doctors(doc: widget.doctors,),
        ]
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current,
        onTap: (index) {
          this._c.animateToPage(index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label:'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome_motion),
              label: 'Queuing System'),
          BottomNavigationBarItem(
              icon: Image.asset('Image/doc(2).png',width: 40,height: 30,color: current==2?Colors.blue:Colors.black54,), label: 'Doctors'),
        ],
      ),
    );
  }
}
