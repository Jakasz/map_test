import 'dart:io';

import 'package:untitled/model/project_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ProjectService {
  Future<List<Project>> getData(int projectId, String token) async {
    var response = await http.get(Uri.parse('http://176.88.169.230:5005/api/v1/dashboard/GetTrainsInfoWithDistance?projectId=$projectId'),
    headers: {HttpHeaders.authorizationHeader: 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List tempData = [];
      data.forEach((key, value) {
        tempData.add(data);
      });
      return Project.loadFromDB(tempData);
    } else {
      throw Exception('Failed to load');
    }
  }
}