class Patient {
  int userID,nationalID,age,phoneNumber;
  String dateBirth,eMail,password,address,fullName,image,gender;
  Patient(this.userID,this.image,this.nationalID,this.address,this.age,this.dateBirth,
      this.eMail,this.fullName,this.password,this.phoneNumber,this.gender);
  Patient.fromJson(Map<String,dynamic> json){
    nationalID = json['nationalId'];
    password = json['password'];
    age = json['age'];
    dateBirth = json['dateBirth'];
    eMail = json['eMail'];
    address = json['address'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];
    userID = json['userID'];
    gender = json['gender'];
  }
}