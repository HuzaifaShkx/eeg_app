class User {
  String? contact;
  String? dob;
  String? gender;
  String? email;
  String? name;
  String? password;
  String? role;

  User({required this.contact,required this.dob,required this.gender,required this.email,required this.name,required this.password,required this.role, String? imgpath});

  User.fromJson(Map<String, dynamic> json) {
    contact = json['contact'];
    dob = json['dob'];
    gender = json['gender'];
    email = json['email'];
    //imgpath = json['imgpath'];
    name = json['name'];
    password = json['password'];
    role=json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contact'] = contact;
    data['dob'] = dob;
    data['gender'] = gender;
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    data['role'] = role;
    return data;
  }
}
