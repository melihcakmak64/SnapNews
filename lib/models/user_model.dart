class UserModel {
  String? username;
  String? email;
  String? password;
  String? country;
  String? uid;
  String? profileURL;

  UserModel(
      {this.username,
      this.email,
      this.password,
      this.country,
      this.uid,
      this.profileURL});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    country = json['country'];
    uid = json['uid'];
    profileURL = json["profileURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['country'] = country;
    data['uid'] = uid;
    data["profileURL"] = profileURL;
    return data;
  }
}
