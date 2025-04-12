class Todo {
  int? id;
  String title;
  String description;
  DateTime? reminder;

  Todo({
    this.id,
    required this.title,
    this.description = '',
    this.reminder,
  });

  // Convertir une tâche en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'reminder': reminder?.toIso8601String(),
    };
  }

  // Créer une tâche à partir d'un Map
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      reminder:
      map['reminder'] != null ? DateTime.parse(map['reminder']) : null,
    );
  }
}
