class Task {
  final String title;

  bool isCompleted;

  Task({ required this.title, required this.isCompleted});

  void isDone() {
    isCompleted = !isCompleted;
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'isCompleted': isCompleted};
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}
