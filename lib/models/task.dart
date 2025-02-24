class Task {
  final String id;
  final String title;
  final String description;
  final String status; // "open", "in_progress", "done"
  final String assignedTo; // Spielername oder leer
  final DateTime? dueDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.status = "open",
    this.assignedTo = "",
    this.dueDate,
  });

  // JSON-Konvertierung für Speicherung
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "assignedTo": assignedTo,
        "dueDate": dueDate?.toIso8601String(),
      };

  static Task fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        assignedTo: json["assignedTo"] ?? "",
        dueDate: json["dueDate"] != null ? DateTime.parse(json["dueDate"]) : null,
      );
}
