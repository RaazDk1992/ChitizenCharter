import 'package:http/http.dart' as http;
import 'package:noticeboard/models/staffs.dart';

class FetchStaffs {
  Future<List<Staff>?> getStaffs() async {
    var client = http.Client();
    var uri = Uri.parse('https://lekbeshimun.gov.np/staffs-api');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return staffFromJson(data);
    }
  }
}
