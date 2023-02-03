import 'package:nextline_app/data/constants/api_constants.dart';
import 'package:nextline_app/data/models/task_model.dart';
import 'package:flutter/widgets.dart';
import 'package:nextline_app/utils/utils.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> taskList = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  bool isCompleted = false;
  String chosenDate = 'Elegir fecha';
  DateTime? selectTime;

  List<TaskModel> get getTask => taskList;
  int get getTaskLengt => taskList.length;
  int get getTaskCompleted {
    int taskCompleted = 0;
    for (var item in taskList) {
      if (item.getCompleted()) taskCompleted++;
    }
    return taskCompleted;
  }

  int get getTaskIncompleted {
    int taskCompleted = 0;
    for (var item in taskList) {
      if (!item.getCompleted()) taskCompleted++;
    }
    return taskCompleted;
  }

  TaskModel getTaskIndividual(int index) => taskList[index];

  setListTask(List<TaskModel> _tasks) {
    taskList = _tasks;
  }

  setListIncompleteTask(List<TaskModel> _tasks) {
    _tasks.removeWhere((i) => i.getCompleted() == true);
    taskList = _tasks;
  }

  setListCompletedTask(List<TaskModel> _tasks) {
    _tasks.removeWhere((i) => i.getCompleted() == false);
    taskList = _tasks;
  }

  onEditTask({
    required String? title,
    String comments = "",
    String description = "",
    String tags = "",
    bool completed = false,
    DateTime? date,
  }) {
    titleController.text = title!;
    commentsController.text = comments;
    descriptionController.text = description;
    tagsController.text = tags;
    isCompleted = completed;
    selectTime = date;
  }

  Future<void> orderAscendent() async {
    taskList.sort((a, b) => b.title!.compareTo(a.title!));
    notifyListeners();
  }

  Future<void> orderDescendent() async {
    taskList.sort((a, b) => a.title!.compareTo(b.title!));
    notifyListeners();
  }

  Future<void> onDateEdit({String? date, DateTime? time}) async {
    chosenDate = date!;
    selectTime = time!;
    notifyListeners();
  }

  Future<void> setCompleted({bool value = false}) async {
    isCompleted = value;
    notifyListeners();
  }

  Future<void> updateTask({required TaskModel? task, required int i}) async {
    int completed = taskList[i].isCompleted!;
    taskList[i].title = task!.title;
    taskList[i].isCompleted = task.isCompleted;
    taskList[i].tags = task.tags;
    taskList[i].comments = task.comments;
    taskList[i].description = task.description;
    taskList[i].dueDate = task.dueDate;
    if (task.isCompleted != completed) taskList.removeAt(i);
    notifyListeners();
  }

  Future<void> updateTaskCompleted({required int i}) async {
    taskList[i].isCompleted = taskList[i].isCompleted == 0 ? 1 : 0;
    taskList.removeAt(i);
    notifyListeners();
  }

  Future<void> deleteTask({int? index}) async {
    taskList.removeAt(index!);
    notifyListeners();
  }

  Future<void> createTask({required TaskModel task}) async {
    taskList.add(task);
    notifyListeners();
  }

  Future<Map<String, String>> serializeDataComplete(
      {required TaskModel taskModel}) async {
    Map<String, String> body;
    if (taskModel.dueDate != null) {
      body = {
        'title': taskModel.title!,
        'is_completed': taskModel.isCompleted == 0 ? '1' : '0',
        'due_date': formattDateSendApi(taskModel.dueDate),
        'comments': taskModel.comments ?? '',
        'description': taskModel.description ?? '',
        'tags': taskModel.tags ?? '',
        'token ': bearerToken
      };
    } else {
      body = {
        'title': taskModel.title!,
        'is_completed': taskModel.isCompleted == 0 ? '1' : '0',
        'comments': taskModel.comments ?? '',
        'description': taskModel.description ?? '',
        'tags': taskModel.tags ?? '',
        'token ': bearerToken
      };
    }

    return body;
  }

  Future<Map<String, String>> serializeData() async {
    Map<String, String> body;
    if (selectTime != null) {
      body = {
        'title': titleController.text,
        'is_completed': isCompleted ? '1' : '0',
        'due_date': formattDateSendApi(selectTime),
        'comments': commentsController.text,
        'description': descriptionController.text,
        'tags': tagsController.text,
        'token ': bearerToken
      };
    } else {
      body = {
        'title': titleController.text,
        'is_completed': isCompleted ? '1' : '0',
        'comments': commentsController.text,
        'description': descriptionController.text,
        'tags': tagsController.text,
        'token ': bearerToken
      };
    }

    return body;
  }

  clean() {
    titleController.clear();
    commentsController.clear();
    descriptionController.clear();
    tagsController.clear();
    chosenDate = "Elegir Fecha";
    selectTime = null;
    isCompleted = false;
  }
}
