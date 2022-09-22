import '../model/token_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TokenService {
  Future<List<Token>> getData(String email, String password) async {

    var bodyString = '{"email": "$email", "password": "$password"}';

    var response = await http.post(Uri.parse('http://176.88.169.230:5005/api/v1/auth/Login'),
    body: bodyString,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List tempData = [];

      data.forEach((key, value) {
        tempData.add(data);
      });

      // for (var i in data['']) {
      //   tempData.add(i);
      // }
      return Token.loadFromDB(tempData);
    } else {
      throw Exception('Failed to load');
    }
  }
}