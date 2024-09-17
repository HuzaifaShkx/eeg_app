import 'package:eeg_app/model/user.dart';

class Patient extends User {
  double? height;
  double? weight;

  Patient({
    String? contact,
    String? dob,
    String? gender,
    String? id,
    String? imgpath,
    String? name,
    String? password,
    String? role,
    this.height,
    this.weight,
  }) : super(
          contact: contact,
          dob: dob,
          gender: gender,
          id: id,
   //       imgpath: imgpath,
          name: name,
          password: password,
          role:role,
        );

  Patient.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    height = json['height'];
    weight = json['weight'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['height'] = this.height;
    data['weight'] = this.weight;
    return data;
  }
}