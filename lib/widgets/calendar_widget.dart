import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:deardiary/models/journalentry.dart';
import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:provider/provider.dart';
import 'package:deardiary/widgets/journalentry_individual_ui_widget.dart';


/***
 * Class calendar to allow users to filter based on date for their entry cards
 *
 * Source: https://pub.dev/packages/table_calendar
 */
class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});
  _CalendarWidgetState createState() => _CalendarWidgetState(); 
}

class _CalendarWidgetState extends State<CalendarWidget>{

  // An empty list to contain the entries of the current date
  List<JournalEntryModel> currentDate = [];

  // Display the current date
  DateTime _focusedDay = DateTime.now();

  // Display the selected date
  DateTime? _selectedDay;

  // The start of when the calendar start.
  DateTime firstDay = DateTime(2023);

  // The end of when the calendar will end. Set it this high because who knows if this app can last that long
  DateTime lastDay = DateTime(10000);

  // Set the default calendar format to month
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // counter to keep track of how many entries for that day selected
  int _totalCount = 0;
  String _theSelectedDayDisplay = "";

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get the entries
    final List<JournalEntryModel> entries = Provider
        .of<JournalEntryProvider>(context)
        .allJournalEntries;

    return ListView(
      children: [
        Column(
          children: [
            TableCalendar(
              calendarStyle: CalendarStyle(rangeHighlightColor: Colors.yellow) ,
              daysOfWeekVisible: true,
              daysOfWeekStyle: DaysOfWeekStyle(

                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.deepPurple[50]!,
                        Colors.deepPurple[200]!,
                        //Colors.green[300]!,
                      ],
                    )
               ),

              ),
              firstDay: firstDay,
              lastDay: lastDay,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                // highlighted the day when selected
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _getEntryDay(selectedDay, entries);
                    _totalCount = _getCount(selectedDay, entries);
                    _theSelectedDayDisplay = _getDateToString(selectedDay);
                  });
                }
              },
              onFormatChanged: (format) {
                // Allow the user to switch between what kind of calendar they want to display as
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
            ),

            // Display the selected date
            Text(_theSelectedDayDisplay, style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),),

            // Display the selected date count
            Text("Total Count = " + _totalCount.toString(), style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),),

            // Display the ui of the journal entry and add space between each
            for(int i = 0; i < currentDate.length; i++)
              Column(
                children: [
                  JournalEntryIndividualUIWidget(journalEntryModel: currentDate[i]),
                  Container(
                    height: 18,
                    color: Colors.black12,
                  ),
                ],
              )
          ],
        )
      ],
    );
  }


  /**
   * To string of the selected day
   */
  String _getDateToString(DateTime selectedDay){
    return selectedDay.year.toString() + "-" + selectedDay.month.toString() + "-" + selectedDay.day.toString();
  }

  /***
   * Get the entries of the todos for that day
   */
  void _getEntryDay(DateTime selectedDay, List<JournalEntryModel> entries){
    // Clear out the list so that every time this function is called it is clean.
    currentDate.clear();

    // The selected date from the calendar
    String selectedDate = selectedDay.year.toString() + "-" + selectedDay.month.toString() + "-" + selectedDay.day.toString();

    // If the date is selected and there are entries add it to the list
    for(int i= 0; i < entries.length; i++){
      if(selectedDate == entries[i].journalEntryCreationDate.year.toString() + "-" + entries[i].journalEntryCreationDate.month.toString() + "-" + entries[i].journalEntryCreationDate.day.toString())
        currentDate.add(entries[i]);
    }
  }


  /**
   * Get the count of how many entries are there for that day
   */
  int _getCount(DateTime selectedDay, List<JournalEntryModel> entries){
    // counter to keep track of how many entries
    int counter = 0;

    // The selected date from the calendar
    String selectedDate = selectedDay.year.toString() + "-" + selectedDay.month.toString() + "-" + selectedDay.day.toString();

    // If the date is selected and there are entries increment counter
    for(int i= 0; i < entries.length; i++){
      if(selectedDate == entries[i].journalEntryCreationDate.year.toString() + "-" + entries[i].journalEntryCreationDate.month.toString() + "-" + entries[i].journalEntryCreationDate.day.toString())
        counter++;
    }
    return counter;
  }

}