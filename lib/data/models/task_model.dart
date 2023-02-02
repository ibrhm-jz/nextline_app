class TaskModel {
  int? id;
  String? title;
  int? isCompleted;
  DateTime? dueDate;
  String? comments;
  String? description;
  String? tags;
  TaskModel({
    required this.id,
    required this.title,
    this.isCompleted = 0,
    this.dueDate,
    this.comments,
    this.description,
    this.tags,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isCompleted = int.parse(json['is_completed'].toString());

    dueDate =
        json['due_date'] != null ? DateTime.parse(json['due_date']) : null;
    comments = json.containsKey('comments') ? json['comments'] : '';
    description = json.containsKey('description') ? json['description'] : '';
    tags = json.containsKey('tags') ? json['tags'] : '';
  }
  bool getCompleted() {
    return isCompleted == 1;
  }
}
