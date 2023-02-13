import 'package:deardiary/widgets/calendar_widget.dart';
import 'package:deardiary/widgets/journalentry_dialog_structure_widget.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/journalentry_entries_layout_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      const JournalEntryEntriesLayoutWidget(),
      const CalendarWidget(),
      // Settings(),
    ];

    // Need to create Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        // Getting the title variable from main.dart
      ),

      //shows list of entries
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (index) => setState(() => this.index = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Entries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),

      body: tabs[index],

      //Want to add the button to add the task
      floatingActionButton: FloatingActionButton(
        // change the background color
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),

        // This will create the popup for the task
        // user will enter the tasks and description
        onPressed: () => showDialog(
          // This will prevent the pop-up screen to not go away
          // if click outside the box entry area.
          barrierDismissible: false,
          context: context,
          builder: (context) => const JournalEntryDialogStructureWidget(),
        ),
      ),
    );
  }
}
