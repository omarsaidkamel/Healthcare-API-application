import 'package:flutter/material.dart';
import 'package:login/Models/resultModel.dart';
import 'package:login/UI/resultUi.dart';

class xrayUi extends StatefulWidget{
  List<resultModel>resultModelX;
  xrayUi({Key key,this.resultModelX}) : super(key: key);
  @override
  _xrayUiState createState() => _xrayUiState();
}

class _xrayUiState extends State<xrayUi> {
  @override
  build(BuildContext context) {
    return resultModelUi(S: 'https://jsonplaceholder.typicode.com/photos',resultModelAll: widget.resultModelX,);
  }
}
