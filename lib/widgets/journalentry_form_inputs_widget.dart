import 'package:flutter/material.dart';

/***
 * Stateless class for the form inputs
 */
class JournalEntryFormInputsWidget extends StatelessWidget{

  // Declaring the variables
  final String entryTitle;
  final String entryContent;
  final VoidCallback onSaved;
  final ValueChanged<String> userEntryTitle;
  final ValueChanged<String> userEntryContent;

  JournalEntryFormInputsWidget({
    this.entryTitle = '',
    this.entryContent = '',
    required this.onSaved,
    required this.userEntryTitle,
    required this.userEntryContent,

  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      children: [
        Container(height: 5), // Adding spaces
        titleFormWidget(),
        Container(height: 5), // Create the space
        descriptionFormWidget(),
        Container(height: 5), // Create the space
        saveFormWidget(),
        exitFormWidget(context),
      ],
    ),
  );


  Widget titleFormWidget() => TextFormField(
    // The initial title of the task that is displayed for the user to enter
    initialValue: entryTitle,
    // This will display whatever the user type for the task
    onChanged: userEntryTitle,
    // The max line that will be display for the user to fill out is 1
    maxLines: 1,
    style: TextStyle(height: 1),

    // Display the input text box for the title
    decoration:  InputDecoration(
      labelText: 'Title',
      border: OutlineInputBorder(),
    ),
  );

  Widget descriptionFormWidget() => TextFormField(
    // The initial description of the task that is displayed for the user to enter
    initialValue: entryContent,
    // This will display whatever the user type for the task
    onChanged: userEntryContent,
    // The max line that will be display for the user to fill out is 1
    maxLines: 2,
    style: TextStyle(height: 2),

    // Display the input text box for the title
    decoration:  InputDecoration(
      labelText: 'Description',
      border: OutlineInputBorder(),
    ),
  );

  Widget exitFormWidget(context) => Container(
    child: ElevatedButton(
      child: Text('Exit'),
      onPressed: () => Navigator.pop(context),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        alignment: Alignment.center,
      ),//
      // Go back to the original screen (this case it is home)
    ),
  );

  Widget saveFormWidget() => Container(
    child: ElevatedButton(
      child: Text('Save'),
      onPressed: onSaved,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        alignment: Alignment.center,
      ),

    ),
  );


}