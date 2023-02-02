import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nextline_app/data/constants/api_constants.dart';
import 'package:nextline_app/data/constants/api_routes.dart';
import 'package:nextline_app/data/models/task_model.dart';

class TaskRepository {
  Future<List<TaskModel>> getListTask() async {
    final Uri _baseUri = Uri.parse(baseUrl + taskRoute);
    http.Response response = await http.get(_baseUri, headers: jsonHeaders);
    List<TaskModel> listTask = [];
    final data = jsonDecode(response.body);
    for (var item in data) {
      listTask.add(TaskModel.fromJson(item));
    }
    return listTask;
  }

  Future<bool> deleteTask({String? id}) async {
    final Uri _baseUri = Uri.parse('$baseUrl$taskRoute$id');
    http.Response response = await http.delete(_baseUri, headers: jsonHeaders);
    return response.statusCode == 200;
  }

  Future<bool> updateTask({
    String? id,
    String? title,
    int? isCompleted,
    String? dateDue,
    String? comments,
    String? description,
    String? tags,
  }) async {
    final Uri _baseUri = Uri.parse('$baseUrl$taskRoute$id');
    Map<String, String> body = {
      'token': bearerToken,
      'title': title!,
      'is_completed': isCompleted.toString(),
      'due_date': dateDue!,
      'comments': comments!,
      'description': description!,
      'tags': tags!,
    };
    http.Response response =
        await http.put(_baseUri, body: body, headers: jsonHeaders);
    return response.statusCode == 200;
  }
}
