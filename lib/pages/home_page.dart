import 'package:deardiary/widgets/calendar_widget.dart';
import 'package:deardiary/widgets/journalentry_dialog_structure_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import '../main.dart';
import '../widgets/journalentry_entries_layout_widget.dart';
import 'package:deardiary/widgets/display_stats_of_entries_widget.dart';
import 'package:deardiary/widgets/settings_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      const JournalEntryEntriesLayoutWidget(),
      const CalendarWidget(),
      DisplayStatsOfEntiresWidget(),
      SettingsWidget(),
      //Container(), // Temporary holder so that the Settings widget does not crash
      // Settings(),
    ];

    // Need to create Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        // Getting the title variable from main.dart
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            onSelected: (String choice) {
              if (choice == 'Logout') {
                showDialog(
                  context: context,
                  builder: (context) => signOut(),
                );
              }
            },
            itemBuilder: ((context) => {'Logout'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList()),
          ),
        ],
      ),

      // Create the side naviation bar
      body: Row(
        children: [
          SideNavigationBar(
            selectedIndex: selectedIndex,
            expandable: true,
            initiallyExpanded: false,
            theme: SideNavigationBarTheme(
              backgroundColor: Colors.black54,
              dividerTheme: SideNavigationBarDividerTheme.standard(),
              togglerTheme: SideNavigationBarTogglerTheme.standard(),
              itemTheme: SideNavigationBarItemTheme(
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.white,
              ),
            ),
            items: [
              SideNavigationBarItem(icon: Icons.list_alt, label: 'Entries'),
              SideNavigationBarItem(
                  icon: Icons.calendar_month, label: 'Calendar'),
              SideNavigationBarItem(
                  icon: Icons.stacked_bar_chart, label: 'Stats'),
              SideNavigationBarItem(icon: Icons.settings, label: 'Settings'),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          // want to add the body of text
          Expanded(
            child: tabs[selectedIndex],
          ),
        ],
      ),

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

  Widget signOut() => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            child: const Text('Sign Out'),
          ),
        ],
      );
}
