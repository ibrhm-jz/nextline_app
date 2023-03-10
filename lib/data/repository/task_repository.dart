import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nextline_app/data/constants/api_constants.dart';
import 'package:nextline_app/data/constants/api_routes.dart';
import 'package:nextline_app/data/models/task_model.dart';
import 'package:nextline_app/data/utils/api_utils.dart';

class TaskRepository {
  Future<List<TaskModel>> getListTask() async {
    Uri _baseUri = Uri.parse(
        'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks?token=uJMacdKbm');
    http.Response response = await http.get(_baseUri, headers: headers);
    List<TaskModel> listTask = [];
    final data = jsonDecode(response.body);
    for (var item in data) {
      listTask.add(TaskModel.fromJson(item));
    }

    return listTask;
  }

  Future<TaskModel> getTask({String? id}) async {
    Uri _baseUri = buildUri('$taskRoute/$id', params: queryToken);
    http.Response response = await http.get(_baseUri, headers: jsonHeaders);
    final data = jsonDecode(response.body);
    TaskModel task = TaskModel.fromJson(data[0]);
    return task;
  }

  Future<bool> deleteTask({String? id}) async {
    Uri _baseUri = buildUri('$taskRoute/$id', params: queryToken);
    http.Response response = await http.delete(_baseUri, headers: headers);
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<TaskModel> updateTask({String? id, Map<String, String>? body}) async {
    Uri _baseUri = buildUri('$taskRoute/$id', params: queryToken);
    http.Response response =
        await http.put(_baseUri, body: body, headers: headers);
    final data = jsonDecode(response.body);
    TaskModel task = TaskModel.fromJson(data['task']);
    return task;
  }

  Future<TaskModel> createTask({Map<String, String>? body}) async {
    // final Uri _baseUri = Uri.parse('$baseUrl$taskRoute');
    Uri _baseUri = buildUri(taskRoute, params: queryToken);
    http.Response response =
        await http.post(_baseUri, body: body, headers: headers);
    final data = jsonDecode(response.body);
    TaskModel task = TaskModel.fromJson(data['task']);
    return task;
  }
}
