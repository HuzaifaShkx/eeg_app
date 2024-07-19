class User {
  String? contact;
  String? dob;
  String? gender;
  String? id;
  String? imgpath;
  String? name;

  User({this.contact, this.dob, this.gender, this.id, this.imgpath, this.name});

  User.fromJson(Map<String, dynamic> json) {
    contact = json['contact'];
    dob = json['dob'];
    gender = json['gender'];
    id = json['id'];
    imgpath = json['imgpath'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact'] = this.contact;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['imgpath'] = this.imgpath;
    data['name'] = this.name;
    return data;
  }
}
