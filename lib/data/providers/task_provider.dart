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
  DateTime selectTime = DateTime.now();
  List<TaskModel> get getTask => taskList;
  TaskModel getTaskIndividual(int index) => taskList[index];
  setListIncompleteTask(List<TaskModel> _tasks) {
    _tasks.removeWhere((i) => i.getCompleted() == true);
    taskList = _tasks;
  }

  setListCompletedTask(List<TaskModel> _tasks) {
    _tasks.removeWhere((i) => i.getCompleted() == false);
    taskList = _tasks;
  }

  setListTask(List<TaskModel> _tasks) {
    taskList = _tasks;
  }

  onEditTask({
    required String? title,
    String comments = "",
    String description = "",
    String tags = "",
    bool completed = false,
    String date = '',
  }) {
    titleController.text = title!;
    commentsController.text = comments;
    descriptionController.text = description;
    tagsController.text = tags;
    isCompleted = completed;
    chosenDate = date;
  }

  Future<void> orderAscendent() async {
    taskList.sort((a, b) => b.dueDate!.compareTo(a.dueDate!));
    notifyListeners();
  }

  Future<void> orderDescendent() async {
    taskList.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
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

  Future<void> creteTask({TaskModel? task}) async {
    taskList.add(TaskModel(
      id: task!.id,
      title: task.title,
      isCompleted: task.isCompleted,
      tags: task.tags,
      comments: task.comments,
      description: task.description,
      dueDate: task.dueDate,
    ));
    notifyListeners();
  }

  Future<void> updateTask({required TaskModel? task, required int i}) async {
    taskList[i].title = task!.title;
    taskList[i].isCompleted = task.isCompleted;
    taskList[i].tags = task.tags;
    taskList[i].comments = task.comments;
    taskList[i].description = task.description;
    taskList[i].dueDate = task.dueDate;
    notifyListeners();
  }

  Future<void> createTask({required TaskModel? task, required int i}) async {
    // taskList.add(TaskModel(id: id, title: title, isCompleted: isCompleted));
    notifyListeners();
  }

  Future<Map<String, String>> serializeData() async {
    Map<String, String> body = {
      'title': titleController.text,
      'is_completed': isCompleted.toString(),
      'due_date': formattDateSendApi(selectTime),
      'comments': commentsController.text,
      'description': descriptionController.text,
      'tags': tagsController.text,
      'token ': bearerToken
    };
    return body;
  }

  clean() {
    titleController.clear();
    commentsController.clear();
    descriptionController.clear();
    tagsController.clear();
    isCompleted = false;
  }
}
