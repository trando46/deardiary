import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';



class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});
  _CalendarWidgetState createState() => _CalendarWidgetState(); 
}

class _CalendarWidgetState extends State<CalendarWidget>{

  @override
  void initState()
  {
    super.initState();
  }

  /**
   * https://pub.dev/packages/table_calendar/example
   * https://github.com/aleksanderwozniak/table_calendar/blob/master/example/lib/pages/complex_example.dart
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(2023),
        lastDay: DateTime(3300),
      ),
    );
  }
  
}