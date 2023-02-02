// import 'package:flutter/foundation.dart';
import 'package:nextline_app/data/models/task_model.dart';
import 'package:flutter/widgets.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _taskList = [];
  List<TaskModel> get getTask => _taskList;
  TextEditingController titleController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  bool isCompleted = false;
  String chosenDate = 'Elegir fecha';
  DateTime selectTime = DateTime.now();
  setListIncompleteTask(List<TaskModel> _tasks) {
    _tasks.removeWhere((i) => i.getCompleted() == true);
    _taskList = _tasks;
  }

  setListCompletedTask(List<TaskModel> _tasks) {
    _tasks.removeWhere((i) => i.getCompleted() == false);
    _taskList = _tasks;
  }

  setListTask(List<TaskModel> _tasks) {
    _taskList = _tasks;
  }

  onEditTask({
    String? title,
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
    _taskList.sort((a, b) => b.dueDate!.compareTo(a.dueDate!));
    notifyListeners();
  }

  Future<void> orderDescendent() async {
    _taskList.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
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

  clean() {
    titleController.clear();
    commentsController.clear();
    descriptionController.clear();
    tagsController.clear();
    isCompleted = false;
    chosenDate = 'Elegir fecha';
    selectTime = DateTime.now();
  }
}
