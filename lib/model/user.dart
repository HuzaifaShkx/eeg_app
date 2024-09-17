class User {
  String? contact;
  String? dob;
  String? gender;
  String? id;
  String? name;
  String? password;
  String? role;

  User({required this.contact,required this.dob,required this.gender,required this.id,required this.name,required this.password,required this.role});

  User.fromJson(Map<String, dynamic> json) {
    contact = json['contact'];
    dob = json['dob'];
    gender = json['gender'];
    id = json['email'];
    //imgpath = json['imgpath'];
    name = json['name'];
    password = json['password'];
    role=json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact'] = this.contact;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['email'] = this.id;
    data['name'] = this.name;
    data['password'] = this.password;
    data['role'] = this.role;
    return data;
  }
}
