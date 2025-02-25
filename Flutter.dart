import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Map<String, dynamic>> _tasks = [];

  void _addTask(String task) {
    setState(() {
      _tasks.add({'title': task, 'completed': false});
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  void _showAddTaskDialog() {
    TextEditingController taskController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Task",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                  controller: taskController,
                  decoration: InputDecoration(hintText: "Enter task")),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (taskController.text.isNotEmpty) {
                    _addTask(taskController.text);
                    Navigator.pop(context);
                  }
                },
                child: Text("Add"),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: _tasks[index]['completed'],
              onChanged: (_) => _toggleTaskCompletion(index),
            ),
            title: Text(
              _tasks[index]['title'],
              style: TextStyle(
                decoration: _tasks[index]['completed']
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
