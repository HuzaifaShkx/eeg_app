class Supervisor {
  String? dob;
  String? email;
  String? gender;
  int? id;
  String? imgpath;
  String? name;

  Supervisor(
      {this.dob, this.email, this.gender, this.id, this.imgpath, this.name});

  Supervisor.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    email = json['email'];
    gender = json['gender'];
    id = json['id'];
    imgpath = json['imgpath'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['imgpath'] = this.imgpath;
    data['name'] = this.name;
    return data;
  }
}
