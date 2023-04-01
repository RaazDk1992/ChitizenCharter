import 'package:http/http.dart' as http;
import 'package:noticeboard/models/elected.dart';

class FetchElected {
  Future<List<Elected>?> getElected() async {
    var client = http.Client();
    var uri = Uri.parse('https://lekbeshimun.gov.np/elected-api');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return electedFromJson(data);
    }
  }
}
