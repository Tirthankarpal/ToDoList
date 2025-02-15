import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'createNewTask.dart';

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<Map<String, String>> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskStrings = prefs.getStringList('tasks');
    if (taskStrings != null) {
      setState(() {
        tasks = taskStrings.map((taskString) {
          List<String> parts = taskString.split('|');
          return {
            'name': parts[0],
            'start': parts[1],
            'end': parts[2],
            'description': parts[3],
            'date': parts.length > 4 ? parts[4] : '', // Handle optional date
          };
        }).toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = tasks.map((task) {
      return '${task['name']}|${task['start']}|${task['end']}|${task['description']}|${task['date']}';
    }).toList();
    await prefs.setStringList('tasks', taskStrings);
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    _saveTasks();
  }

  void markTaskAsDone(int index) {
    setState(() {
      tasks[index]['name'] = "${tasks[index]['name']} - Done";
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List', style: TextStyle(
          fontSize: 27,
          fontFamily: 'Times New Roman',
        )),
        backgroundColor: Colors.teal,
        elevation: 10,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(
                          '${task['name']} (${task['start']} - ${task['end']}) - ${task['date']}', // Show date
                          style: TextStyle(
                            decoration: (task['name']?.endsWith("Done") ?? false) // Use ?. and ??
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.black),
                              onPressed: () => markTaskAsDone(index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.black),
                              onPressed: () => deleteTask(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNewTaskPage()),
          );

          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
              _saveTasks();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}