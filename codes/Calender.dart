import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  List<Widget> _generateCalendar(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday % 7;

    List<Widget> calendarDays = [];

    for (int i = 1; i < firstWeekday; i++) {
      calendarDays.add(Container());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(month.year, month.month, day);
      final isWeekend =
          date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
      calendarDays.add(
        Container(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: isWeekend ? Colors.red.shade100 : Colors.blue.shade100,
            border: Border.all(color: Colors.blue.shade400),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: TextStyle(
                fontSize: 18,
                color: isWeekend ? Colors.red : Colors.blue.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return calendarDays;
  }

  Widget _buildWeekdayHeaders() {
    final days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: days.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: day == 'S' ? Colors.red : Colors.blue.shade800,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final monthName = DateFormat.MMMM().format(_selectedDate);
    final year = _selectedDate.year;

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Calendar"))),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _selectedDate =
                        DateTime(_selectedDate.year, _selectedDate.month - 1);
                  });
                },
              ),
              Text(
                "$monthName $year",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    _selectedDate =
                        DateTime(_selectedDate.year, _selectedDate.month + 1);
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          _buildWeekdayHeaders(),
          SizedBox(height: 8),
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              children: _generateCalendar(_selectedDate),
            ),
          ),
        ],
      ),
    );
  }
}
