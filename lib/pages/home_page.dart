import 'package:deardiary/widgets/journalentry_dialog_structure_widget.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    // Need to create Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        // Getting the title variable from main.dart
      ),

      //Want to add the button to add the task
      floatingActionButton: FloatingActionButton(

        // change the background color
        backgroundColor: Colors.black,
        child: Icon(Icons.add),

        // This will create the popup for the task
        // user will enter the tasks and description
        onPressed: () => showDialog(
          // This will prevent the pop-up screen to not go away
          // if click outside the box entry area.
          barrierDismissible: false,
          context: context,
          builder: (context) =>JournalEntryDialogStructureWidget(),
        ),
      ),
    );
  }
}
