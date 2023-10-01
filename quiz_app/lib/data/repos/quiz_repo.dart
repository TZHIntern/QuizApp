import 'dart:convert';

import 'package:http/http.dart' as http;

class QuizRepo {
  final String url;

  QuizRepo({required this.url});

  Future getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      String data = response.body;
      return jsonDecode(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
