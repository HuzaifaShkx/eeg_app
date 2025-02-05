import 'package:eeg_app/model/user.dart';

class Patient extends User {
  double? height;
  double? weight;
  String? imgpath;
  int? id;
  Patient({
    
    String? contact,
    String? dob,
    String? gender,
    String? email,
    String? name,
    String? password,
    String? role,
    this.height,
    this.weight,
    this.imgpath,
    this.id
  }) : super(
          contact: contact,
          dob: dob,
          gender: gender,
          email: email,
          name: name,
          password: password,
          role:role,
        );

  Patient.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    height = json['height'];
    weight = json['weight'];
    imgpath = json['imgpath'];
    id=int.parse(json['id']);
    
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['height'] = height;
    data['weight'] = weight;


    return data;
  }
}