import 'package:http/http.dart' as http;
import 'package:noticeboard/models/services.dart';
import 'package:noticeboard/models/staffs.dart';

class FetchServices {
  Future<List<Service>?> fetchServices() async {
    var client = http.Client();
    var uri = Uri.parse('https://lekbeshimun.gov.np/services-api1');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return serviceFromJson(data);
    }
  }
}
