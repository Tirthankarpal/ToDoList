import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'homepage.dart'; // Import the homepage.dart file

void main() => runApp(TodoApp());

=======
import 'package:shared_preferences/shared_preferences.dart';
void main() => runApp(TodoApp());
>>>>>>> 974fe25705cd4597c6660e2b40292985c7dc05b7
class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Roboto'),
        ),
      ),
<<<<<<< HEAD
      home: TodoHomePage(), // Use the TodoHomePage widget here
    );
  }
}
=======
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<String> tasks = [];
  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  // Save tasks to SharedPreferences
  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', tasks);
  }

  // Add a task
  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(taskController.text);
      });
      saveTasks();
      taskController.clear();
    }
  }

  // Delete a task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks();
  }

  void markTaskAsDone(int index) {
    setState(() {
      tasks[index] = "${tasks[index]} - Done";
    });
    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List',style:TextStyle(
          fontSize:27,
          fontFamily:'Times New Roman',
        ),),
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
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  labelText:'Enter task',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 25
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    color:Colors.white,
                    onPressed: addTask,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
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
                          tasks[index],
                          style: TextStyle(
                            decoration: tasks[index].endsWith("Done")
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: Colors.black,
                            fontSize:25
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
    );
  }
}
>>>>>>> 974fe25705cd4597c6660e2b40292985c7dc05b7
