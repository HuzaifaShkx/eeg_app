import 'package:eeg_app/model/user.dart';

class Doctor extends User {
  String? imgpath;
  int? id;
  Doctor({
    String? contact,
    String? dob,
    String? gender,
    String? email,
    String? name,
    String? password,
    String? role,
    this.imgpath,
    this.id,
  }) : super(
          contact: contact,
          dob: dob,
          gender: gender,
          email: email,
          name: name,
          password: password,
          role: role,
        );

  Doctor.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    imgpath = json['imgpath'];
    id = json['id'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
   // data['imgPath'] = imgpath;
    return data;
  }
}
