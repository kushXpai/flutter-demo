import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _tempController = TextEditingController();
  String _convertedTemp = "";
  String _fromUnit = "C";
  String _toUnit = "F";

  void _convertTemperature() {
    final double? temp = double.tryParse(_tempController.text);

    if (temp == null) {
      setState(() {
        _convertedTemp = "Invalid Input";
      });
      return;
    }

    double convertedTemp = temp;
    if (_fromUnit == "C" && _toUnit == "F") {
      convertedTemp = (temp * 9 / 5) + 32;
    } else if (_fromUnit == "C" && _toUnit == "K") {
      convertedTemp = temp + 273.15;
    } else if (_fromUnit == "F" && _toUnit == "C") {
      convertedTemp = (temp - 32) * 5 / 9;
    } else if (_fromUnit == "F" && _toUnit == "K") {
      convertedTemp = (temp - 32) * 5 / 9 + 273.15;
    } else if (_fromUnit == "K" && _toUnit == "C") {
      convertedTemp = temp - 273.15;
    } else if (_fromUnit == "K" && _toUnit == "F") {
      convertedTemp = (temp - 273.15) * 9 / 5 + 32;
    }

    setState(() {
      _convertedTemp = "${convertedTemp.toStringAsFixed(2)} °$_toUnit";
    });
  }

  Widget _buildDropdown(String label, String value, Function(String?) onChanged) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          DropdownButton<String>(
            value: value,
            isExpanded: true,
            onChanged: onChanged,
            items: ["C", "F", "K"].map((unit) {
              return DropdownMenuItem<String>(
                value: unit,
                child: Text(unit),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Temperature Converter")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter temperature",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildDropdown("From", _fromUnit, (value) {
                  setState(() {
                    _fromUnit = value!;
                  });
                }),
                const SizedBox(width: 16),
                _buildDropdown("To", _toUnit, (value) {
                  setState(() {
                    _toUnit = value!;
                  });
                }),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text("Convert", style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 16),
            Text(
              _convertedTemp,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}