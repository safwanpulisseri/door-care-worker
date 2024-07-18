import 'dart:convert';
import 'dart:developer';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? mobile;
  String? service;
  String? district;
  int? experience;
  String? profileImg;
  String? idCardImg;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.mobile,
    this.service,
    this.district,
    this.experience,
    this.profileImg,
    this.idCardImg,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    log(map.length.toString());
    map.forEach(
      (key, value) {
        log("key -> $key value -> $value");
      },
    );
    return UserModel(
      id: map['_id'] as String?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      password: map['password'] as String?,
      mobile: map['mobile'] as String?,
      service: map['service'] as String?,
      district: map['district'] as String?,
      experience: map['experience'] as int?,
      profileImg: map['profile_img'] as String?,
      idCardImg: map['idCard_img'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'mobile': mobile,
      'service': service,
      'district': district,
      'experience': experience,
      'profile_img': profileImg,
      'idCard_img': idCardImg,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.mobile == mobile &&
        other.service == service &&
        other.district == district &&
        other.experience == experience &&
        other.profileImg == profileImg &&
        other.idCardImg == idCardImg;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        mobile.hashCode ^
        service.hashCode ^
        district.hashCode ^
        experience.hashCode ^
        profileImg.hashCode ^
        idCardImg.hashCode;
  }
}
