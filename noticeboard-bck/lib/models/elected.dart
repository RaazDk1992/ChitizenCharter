import 'dart:convert';

class Elected {
  final String title;
  final String image;
  final String? designation;
  final String? phone;
  final String? email;
  final String? body;

  const Elected(
      {required this.title,
      required this.image,
      required this.designation,
      this.phone,
      this.email,
      this.body});

  factory Elected.fromJson(Map<String, dynamic> json) => Elected(
      title: json['title'],
      image: json['image'],
      designation: json['designation'],
      phone: json['phone'],
      email: json['email'],
      body: json['body']);
}

List<Elected> electedFromJson(String str) =>
    List<Elected>.from(json.decode(str).map((x) => Elected.fromJson(x)));
