import 'dart:convert';

class Staff {
  final String title;
  final String image;
  final String designation;
  final String? phone;
  final String? email;
  final String office;
  final String? dept;

  const Staff(
      {required this.title,
      required this.image,
      required this.designation,
      this.phone,
      this.email,
      required this.office,
      this.dept});

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
      title: json['title'],
      image: json['image'],
      designation: json['designation'],
      phone: json['phone'],
      email: json['email'],
      office: json['office'],
      dept: json['dept']);
}

List<Staff> staffFromJson(String str) =>
    List<Staff>.from(json.decode(str).map((x) => Staff.fromJson(x)));
