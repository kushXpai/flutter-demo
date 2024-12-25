import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoScreenSQLite extends StatefulWidget {
  const TodoScreenSQLite({super.key});

  @override
  State<TodoScreenSQLite> createState() => _TodoScreenSQLiteState();
}

class _TodoScreenSQLiteState extends State<TodoScreenSQLite> {
  final TextEditingController _controller = TextEditingController();
  late Database _database;
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'tasks.db');

    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT)',
      );
    });

    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final tasks = await _database.query('tasks');
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _addTask(String task) async {
    await _database.insert(
      'tasks',
      {'task': task},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _controller.clear();
    _fetchTasks();
  }

  Future<void> _removeTask(int id) async {
    await _database.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    _fetchTasks();
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List with SQLite"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Enter a task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addTask(_controller.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text("Add", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  color: index % 2 == 0 ? Colors.purple.shade50 : Colors.purple.shade100,
                  child: ListTile(
                    title: Text(
                      task['task'],
                      style: TextStyle(color: Colors.purple.shade800, fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeTask(task['id']),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
