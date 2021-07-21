import 'package:flutter/material.dart';
import 'package:login/Models/resultModel.dart';
import 'package:login/UI/resultUi.dart';

class PrescriptionUi extends StatefulWidget {
  List<resultModel>resultModelPer;
  PrescriptionUi({Key key,this.resultModelPer}) : super(key: key);
  @override
  _PrescriptionUiState createState() => _PrescriptionUiState();
}

class _PrescriptionUiState extends State<PrescriptionUi> {
  @override
  Widget build(BuildContext context) {
    return resultModelUi(S: 'https://jsonplaceholder.typicode.com/photos',resultModelAll: widget.resultModelPer,);
  }
}
