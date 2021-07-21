import 'package:flutter/material.dart';
import 'package:login/Models/resultModel.dart';
import 'package:login/UI/resultUi.dart';

class anslysisUi extends StatefulWidget {
  List<resultModel>resultModelA;
  anslysisUi({Key key,this.resultModelA}) : super(key: key);
  @override
  _anslysisUiState createState() => _anslysisUiState();
}

class _anslysisUiState extends State<anslysisUi> {
  @override
  Widget build(BuildContext context) {
      return resultModelUi(S:'https://jsonplaceholder.typicode.com/photos',resultModelAll: widget.resultModelA,);
  }
}
