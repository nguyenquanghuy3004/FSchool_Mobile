import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/grade.dart';

class GradeApiService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/grades';

  Future<List<Grade>> getAllGrades() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((data) => Grade.fromJson(data)).toList();
    } else {
      throw Exception('Không thể tải danh sách điểm');
    }
  }
}
