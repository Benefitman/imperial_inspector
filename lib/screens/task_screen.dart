import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [
    Task(id: "1", title: "System X sichern", description: "BGS pushen", status: "open"),
    Task(id: "2", title: "Mining Operation", description: "Benötigen Painite", status: "in_progress"),
  ];

  void _addTask() {
    setState(() {
      tasks.add(Task(id: DateTime.now().toString(), title: "Neue Mission", description: "Details hier"));
    });
  }

  void _changeStatus(int index, String newStatus) {
    setState(() {
      tasks[index] = Task(
        id: tasks[index].id,
        title: tasks[index].title,
        description: tasks[index].description,
        status: newStatus,
        assignedTo: tasks[index].assignedTo,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aufgaben & Ziele")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text("${task.description} - Status: ${task.status}"),
            trailing: PopupMenuButton<String>(
              onSelected: (value) => _changeStatus(index, value),
              itemBuilder: (context) => [
                PopupMenuItem(value: "open", child: Text("Offen")),
                PopupMenuItem(value: "in_progress", child: Text("In Bearbeitung")),
                PopupMenuItem(value: "done", child: Text("Abgeschlossen")),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
