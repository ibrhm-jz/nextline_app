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
    required this.isCompleted,
    this.dueDate,
    this.comments,
    this.description,
    this.tags,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isCompleted = json['is_completed'] == 'false' ? 1 : 0;
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
