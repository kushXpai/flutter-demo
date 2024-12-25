import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static const _databaseName = "user_data.db";
  static const _databaseVersion = 1;

  static const table = 'user_details';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnGender = 'gender';
  static const columnAge = 'age';
  static const columnCountry = 'country';

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $table($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnEmail TEXT, $columnGender TEXT, $columnAge INTEGER, $columnCountry TEXT)',
        );
      },
    );
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await instance.database;
    return await db.insert(table, user);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await instance.database;
    return await db.query(table);
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _selectedGender = 'Male';
  bool _isChecked = false;
  String _selectedCountry = '';
  final List<String> _countries = ['USA', 'Canada', 'India', 'Australia'];

  void _insertUser() async {
    final user = {
      'name': _nameController.text,
      'email': _emailController.text,
      'gender': _selectedGender,
      'age': int.parse(_ageController.text),
      'country': _selectedCountry,
    };

    await DBHelper.instance.insertUser(user);

    _nameController.clear();
    _emailController.clear();
    _ageController.clear();

    setState(() {});
  }

  Future<List<Map<String, dynamic>>> _getUsers() async {
    return await DBHelper.instance.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter User Details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(color: Colors.deepPurple),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.deepPurple),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      labelStyle: const TextStyle(color: Colors.deepPurple),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Gender: ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple)),
                      Radio<String>(
                        value: 'Male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      const Text(
                        'Male',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      Radio<String>(
                        value: 'Female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      const Text(
                        'Female',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                      const Text(
                        'Accept Terms & Conditions',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedCountry.isEmpty ? null : _selectedCountry,
                    hint: const Text(
                      'Select Country',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCountry = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                    items: _countries.map((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.deepPurple,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              country,
                              style: const TextStyle(color: Colors.deepPurple),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _insertUser,
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 15)),
                      ),
                      child: const Text(
                        'Insert User',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Inserted Users:',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No users inserted.'));
                }
                final users = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      color: Colors.deepPurple.shade100,
                      child: ListTile(
                        title: Text(
                          user['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        subtitle: Text(
                          '${user['email']} | ${user['country']}',
                          style: const TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}