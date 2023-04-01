import 'dart:convert';

class Service {
  final String title;
  final String resofficer;
  final String? resoffice;
  final String? servicetype;
  final String? servicecharge;
  final String time;
  final String? requireddocs;
  final String? process;

  const Service(
      {required this.title,
      required this.time,
      required this.resofficer,
      required this.resoffice,
      this.servicetype,
      this.servicecharge,
      this.requireddocs,
      this.process});

  factory Service.fromJson(Map<String, dynamic> json) => Service(
      title: json['title'],
      time: json['time'],
      resofficer: json['resofficer'],
      resoffice: json['resoffice'],
      servicetype: json['servicetype'],
      servicecharge: json['servicecharge'],
      requireddocs: json['requireddocs'],
      process: json['process']);
}

List<Service> serviceFromJson(String str) =>
    List<Service>.from(json.decode(str).map((x) => Service.fromJson(x)));
