// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:challenge_fudo/src/features/users/domain/address.dart';
import 'package:challenge_fudo/src/features/users/domain/company.dart';
import 'package:equatable/equatable.dart';

List<User> usersFromJson(String str) => List<User>.from(
      json.decode(str).map((x) => User.fromJson(x)),
    );

String usersToJson(List<User> data) => json.encode(
      List<dynamic>.from(data.map((x) => x.toJson())),
    );

class User extends Equatable {
  const User({
    required this.phone,
    required this.website,
    required this.company,
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
  });

  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: Address.fromJson(json["address"]),
        phone: json["phone"],
        website: json["website"],
        company: Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address.toJson(),
        "phone": phone,
        "website": website,
        "company": company.toJson(),
      };

  @override
  List<Object?> get props => [id, name, username, email, address];
}
