import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nextline_app/data/constants/api_constants.dart';
import 'package:nextline_app/data/constants/api_routes.dart';
import 'package:nextline_app/data/models/task_model.dart';

class TaskRepository {
  Future<List<TaskModel>> getListTask() async {
    Uri _baseUri = Uri.parse(baseUrl + taskRoute);
    http.Response response = await http.get(_baseUri, headers: jsonHeaders);
    List<TaskModel> listTask = [];
    final data = jsonDecode(response.body);
    for (var item in data) {
      listTask.add(TaskModel.fromJson(item));
    }
    return listTask;
  }
}
