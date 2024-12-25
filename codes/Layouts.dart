import 'package:flutter/material.dart';

class AllLayoutsPage extends StatefulWidget {
  const AllLayoutsPage({super.key});

  @override
  _AllLayoutsPageState createState() => _AllLayoutsPageState();
}

class _AllLayoutsPageState extends State<AllLayoutsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Layout Example'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Example of correctly defined widgets
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Welcome to Flutter!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(16),
                color: Colors.blue[100],
                child: Text(
                  'This is a simple layout with scrolling enabled.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),

              // Example of a widget that requires proper layout handling
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.green[100],
                child: Column(
                  children: [
                    Text(
                      'Here is a nested layout inside a Column',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Container(
                      color: Colors.red[100],
                      height: 150,
                      width: double.infinity, // Ensure it takes available width
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Another widget to demonstrate scrolling and layout
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.orange[100],
                child: Text(
                  'More content will follow. Scroll down!',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}