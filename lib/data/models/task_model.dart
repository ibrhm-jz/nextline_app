class TaskModel {
  int? id;
  String? title;
  int? isCompleted;
  DateTime? dueDate;
  String? comments;
  String? description;
  String? tags;
  TaskModel({required this.title, required this.isCompleted});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isCompleted = json['is_completed'];
    dueDate = DateTime.parse(json['due_date']);
    comments = json.containsKey('comments') ? json['comments'] : '';
    description = json.containsKey('description') ? json['description'] : '';
    tags = json.containsKey('tags') ? json['tags'] : '';
  }
  bool getCompleted() {
    return isCompleted == 1;
  }
}
