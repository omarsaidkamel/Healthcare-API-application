class resultModel {
  //int dateTime,drName;
  String /*drName,*/note,/*dateTime,*/result,dateTime,drName;
  resultModel({this.note,this.drName,this.dateTime,this.result});
  resultModel.fromJson(Map<String,dynamic> json){
    result = json['url'];
    drName = json['id'];
    dateTime = json['albumId'];
    note = json['title'];
  }
}