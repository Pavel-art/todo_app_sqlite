class Todo {
  late int id;
  late final String title;
  late bool completed;
  Todo({
    required this.title,
    required this.completed,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['completed'] = completed == true ? 1: 0;
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    completed = map['completed'] == 1;
  }
}
