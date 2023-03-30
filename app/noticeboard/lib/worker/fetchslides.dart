import 'package:http/http.dart' as http;
import 'package:noticeboard/models/slider.dart';
import 'package:noticeboard/models/staffs.dart';

class FetchSlides {
  Future<List<Sliderx>?> fetchSlide() async {
    var client = http.Client();
    var uri = Uri.parse('https://lekbeshimun.gov.np/slider-api');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return slideFromJson(data);
    } else {
      print('object==========================>');
    }
  }
}
