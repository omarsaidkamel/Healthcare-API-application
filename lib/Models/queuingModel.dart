class queuingModel{
  int capacityQueue,cost;
  String startTime,endTime,description,doctorName,doctorJobTitle;
  queuingModel({this.capacityQueue,this.cost,this.doctorJobTitle,this.description,this.doctorName,this.endTime,this.startTime});
  queuingModel.fromJson(Map<String,dynamic> json){
    description = json['title'];
    capacityQueue = json['id'];
  }
}