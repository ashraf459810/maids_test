// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'dart:convert';

import 'package:maids_test/features/auth/domain/entities/user_entity.dart';

UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends UserEntity {
  String username;
  String email;
  String firstName;
  String lastName;
  String gender;
  String image;

  UserModel({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required super.id,
    required super.token,
  }) ;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        image: json["image"],
        id: json["id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "image": image,
      };
}
