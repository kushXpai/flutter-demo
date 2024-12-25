import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _result = "";

  void _calculate(String operation) {
    final double? num1 = double.tryParse(_num1Controller.text);
    final double? num2 = double.tryParse(_num2Controller.text);

    if (num1 == null || num2 == null) {
      setState(() {
        _result = "Invalid Input";
      });
      return;
    }

    double result;
    switch (operation) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num2 != 0 ? num1 / num2 : double.nan;
        break;
      default:
        result = 0;
    }

    setState(() {
      _result = result.isNaN ? "Cannot divide by zero" : "Result: $result";
    });
  }

  Widget _buildOperationButton(String text, Color color) {
    return SizedBox(
      height: 50,
      width: 90,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _calculate(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter first number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter second number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildOperationButton("+", Colors.blue),
                _buildOperationButton("-", Colors.blue),
                _buildOperationButton("*", Colors.blue),
                _buildOperationButton("/", Colors.blue),
              ],
            ),
            const SizedBox(height: 16),
            _buildOperationButton("Clear", Colors.red),
            const SizedBox(height: 16),
            Text(
              _result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
