class doctorModel{
  int nationalID;
  String fullName,dateofscan,image,nationality,qualification,jobTitle,age;
  doctorModel({this.fullName,this.dateofscan,this.image,this.nationalID,this.jobTitle,this.nationality,this.qualification});
  doctorModel.fromJson(Map<String,dynamic> json){
    fullName = json['title'];
    jobTitle = json['body'];
   }
}