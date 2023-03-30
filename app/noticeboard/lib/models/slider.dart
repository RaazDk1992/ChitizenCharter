import 'dart:convert';

class Sliderx {
  final String Title;
  final String slider_image;
  final String? description;

  const Sliderx(
      {required this.Title, required this.slider_image, this.description});

  factory Sliderx.fromJson(Map<String, dynamic> json) => Sliderx(
        Title: json['Title'],
        slider_image: json['slider_image'],
        description: json['body'],
      );
}

List<Sliderx> slideFromJson(String str) =>
    List<Sliderx>.from(json.decode(str).map((x) => Sliderx.fromJson(x)));
