import 'package:flutter/foundation.dart';
import 'package:nextline_app/data/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _taskList = [];
  List<TaskModel> get getTask => _taskList;

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

  orderAscendent() {
    _taskList.sort((a, b) => b.dueDate!.compareTo(a.dueDate!));
    notifyListeners();
  }

  orderDescendent() {
    _taskList.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
    notifyListeners();
  }
}
