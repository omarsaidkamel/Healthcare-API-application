import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/Models/doctorModel.dart';
import 'package:login/Models/patientModel.dart';
import 'package:login/Models/queuingModel.dart';
import 'package:login/Models/resultModel.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import '../MainHC.dart';
import 'package:odoo_api/odoo_api.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<Patient> _patient = [];
  List<doctorModel> _doctor = [
    doctorModel(fullName:'Omar Samy Ahmed', dateofscan:'Sunday 1:00 P.M 3:00 P.M\nMonday 1:00 P.M 3:00 P.M', image:'Image/1.jpg', nationalID:23498443443243, jobTitle:'Eyes', nationality:'Egypt', qualification:'Consultant of Cardiology and Vascular Diseases '),
    doctorModel(fullName:'Ali Ahmed Sayed', dateofscan:'Saturday 6:00 P.M 10:00 P.M\nMonday 6:00 P.M 10:00 P.M', image:'Image/2.jpg', nationalID:28239849504323, jobTitle:'Livers', nationality:'Egypt', qualification:'Consultant of Cardiology and Vascular Diseases '),
    doctorModel(fullName:'shima ahmed mohamed', dateofscan:'Thursday 3:00 P.M 6:00 P.M\nSaturday 3:00 P.M 6:00 P.M', image:'Image/3.jpg', nationalID:930282638372627, jobTitle:'Brain', nationality:'Egypt', qualification:'Consultant of Cardiology and Vascular Diseases '),
  ];
  List<queuingModel> _queuing = [
    queuingModel(capacityQueue:12, cost:150, doctorJobTitle:'bones', description:'None', doctorName:'Samy Ahmed', endTime:'1:00 P.M', startTime:'11:00 A.M'),
    queuingModel(capacityQueue:10, cost:100, doctorJobTitle:'Women and childbirth', description:'None', doctorName:'Ali Sayed', endTime:'3:00 P.M', startTime:'1:00 P.M'),
    queuingModel(capacityQueue:12, cost:200, doctorJobTitle:'Women and childbirth', description:'None', doctorName:'Hoda Ahmed', endTime:'3:00 P.M', startTime:'1:00 P.M'),
    queuingModel(capacityQueue:30, cost:250, doctorJobTitle:'Neurologists', description:'None', doctorName:'Mona zaki ', endTime:'6:00 P.M', startTime:'8:00 P.M'),
  ];
  List<resultModel> _resultModelA = [
    resultModel(dateTime: '12/5/2012 12:00',drName: 'Fathy ELSayed',note: 'None',result: 'Image/a1.jpg'),
    resultModel(dateTime: '10/1/2014 12:00',drName: 'Fathy ELSayed',note: 'None',result: 'Image/a2.jpg'),
  ];
  List<resultModel> _resultModelX = [
    resultModel(dateTime: '2/6/2017 6:00',drName: 'Atef gamal',note: 'None',result: 'Image/x.jpg'),
  ];
  List<resultModel> _resultModelPer = [
    resultModel(dateTime: '12/5/2012 4:00',drName: 'Morsy Ashraf',note: 'None',result: 'Image/P1.jpg'),
    resultModel(dateTime: '10/1/2014 7:20',drName: 'Morsy Ashraf',note: 'None',result: 'Image/P2.jpg'),
  ];

  var _userController = TextEditingController();
  var _passController = TextEditingController();
  bool x = true, _passValidate = false, _userValidate = false, loading = false;
  void password() {
    setState(() {
      x = !x;
    });
  }

  getDataP() async {
    try {
      var response = await http
          .get(Uri.parse('https://kirollos-sfen.com/get_employees'));
      if (response.statusCode == 200) {
        var xvx = jsonDecode(response.body);
        for (var h in xvx) _patient.add(Patient.fromJson(h));
      }
      print("${response.body}");
    } catch (e) {print(e);}
  }

  getDataD() async {
    try {
      var response = await http
          .get(Uri.parse('http://kirollos:8069/get_employees'));
      if (response.statusCode == 200) {
        var xvx = jsonDecode(response.body);
        for (var h in xvx) {
          setState(() {
            _doctor.add(doctorModel.fromJson(h));
          });
        }
      }print("${response.body}");
    } catch (e) {
      print(e);
    }

  }

  getDataQ() async {
    try {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        var xvx = jsonDecode(response.body);
        for (var h in xvx) _queuing.add(queuingModel.fromJson(h));
      }
    } catch (e) {}
  }

  getDataPer() async {
    try {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        var xvx = jsonDecode(response.body);
        for (var h in xvx) _resultModelPer.add(resultModel.fromJson(h));
      }
    } catch (e) {}
  }

  getDataA() async {
    try {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        var xvx = jsonDecode(response.body);
        for (var h in xvx) _resultModelA.add(resultModel.fromJson(h));
      }
    } catch (e) {}
  }

  getDataX() async {
    try {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        var xvx = jsonDecode(response.body);
        for (var h in xvx) _resultModelX.add(resultModel.fromJson(h));
      }
    } catch (e) {}
  }

  _incorrectUserPassword() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Icon(
            Icons.warning,
            size: 70,
            color: Colors.red[800],
          ),
          content: Text(
            'Incorrect User ID or password.\nPlease try again.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  _checkConnection() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Icon(
            Icons.wifi,
            size: 70,
            color: Colors.red[800],
          ),
          content: Text(
            'Check The Connection of Network.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
  _getOrders() async {
    var client = OdooClient("https://kirollos-sfen.com");
    final domain = [];
    var fields = ["name", "job_title", "work_email", "department_id"];
    AuthenticateCallback auth =
    await client.authenticate("admin", "141428", "healthcare_c");
    if (auth.isSuccess) {
      final user = auth.getUser();
      print("Hey ${user.name}");
    } else {
       print(auth.getError());
      print("Login failed");
    }

    OdooResponse result = await client.searchRead("hr.employee", domain, fields);
    if (!result.hasError()) {
      print("Successful");
      var response = result.getResult();
      var data = json.encode(response["records"]);
      var decoded = json.decode(data);
      print(data);
      List<doctorModel> users = [];
      for (var u in decoded) {
        print(u);
        doctorModel user = doctorModel.fromJson(u);
        users.add(user);
      }
    }
    else {
      print(result.getError());
    }
  }
  @override
  void initState() {
    super.initState();
   // getDataP();
   // _getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.white, Colors.red])),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
            ),
            Center(
              child: Image.asset('Image/health-care2.png'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            Center(
              child: Container(
                child: TextField(
                  controller: _userController,
                  decoration: InputDecoration(
                      errorText: _userValidate ? 'User ID is Missing.' : null,
                      hintText: 'User ID',
                      icon: Icon(Icons.vpn_key_outlined)),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            Center(
              child: Container(
                child: TextField(
                    controller: _passController,
                    obscureText: x,
                    decoration: InputDecoration(
                        errorText:
                            _passValidate ? 'Password is Missing.' : null,
                        suffix: IconButton(
                          icon:
                              Icon(x ? Icons.visibility : Icons.visibility_off),
                          iconSize: 20,
                          onPressed: password,
                        ),
                        hintText: 'Password',
                        icon: Icon(Icons.lock))),
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
            ),
            loading == false
                ? Padding(
                    padding: EdgeInsets.only(right: 100, left: 100),
                    child: RaisedButton(
                      onPressed: () {
                        /*if (_patient.length == 0) {
                          getDataP();
                          _checkConnection();
                        } else {*/
                          bool abc;
                          Patient obPatient;
                          setState(() {
                            abc = false;
                            _userController.text.isEmpty
                                ? _userValidate = true
                                : _userValidate = false;
                            _passController.text.isEmpty
                                ? _passValidate = true
                                : _passValidate = false;
                          });
                          if (!_userValidate && !_passValidate) {
                            setState(() {
                              loading = true;
                            });
                           // for (var x in _patient) {
                              //**Check the input type**
                             // print( "omar  ${_userController.text.toString()}");
                              if ('admin' == _userController.text.toString() && 'admin' == _passController.text.toString()) {
                               /* obPatient = new Patient(
                                    x.userID,
                                    x.image,
                                    x.nationalID,
                                    x.address,
                                    x.age,
                                    x.dateBirth,
                                    x.eMail,
                                    x.fullName,
                                    x.password,
                                    x.phoneNumber,
                                    x.gender);*/
                                setState(() {
                                  abc = true;
                                });
                             // }
                            }
                            if (abc == true) {
                              //getDataQ();getDataD();getDataX();getDataPer();getDataA();
                              Future.delayed(Duration(seconds: 3))
                                  .then((value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainHC(
                                              patient: obPatient,
                                              doctors: _doctor,
                                              queuing: _queuing,
                                              resultModelA: _resultModelA ,
                                              resultModelPer: _resultModelPer,
                                              resultModelX: _resultModelX,
                                            )),
                                    (r) => false);
                              });
                            } else {
                              setState(() {
                                loading = false;
                              });
                              _incorrectUserPassword();
                            }
                          }
                        //}
                      },
                      color: Colors.white,
                      child: Text('Login'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.45,
                        right: MediaQuery.of(context).size.width * 0.45
                    ),
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
