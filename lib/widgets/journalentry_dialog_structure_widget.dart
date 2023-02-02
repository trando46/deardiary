import 'package:deardiary/models/journalentry.dart';
import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:deardiary/widgets/journalentry_form_inputs_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JournalEntryDialogStructureWidget extends StatefulWidget {
  @override
  _JournalEntryDialogStructureWidgetState createState() => _JournalEntryDialogStructureWidgetState();
}

/**
 * private class for the state
 *
 * Source: https://docs.flutter.dev/cookbook/forms/validation
 * Source: https://api.flutter.dev/flutter/material/AlertDialog-class.html
 */
class _JournalEntryDialogStructureWidgetState extends State<JournalEntryDialogStructureWidget> {
  // Global key that is unique for identifying the form widget
  // and to have validation of the form
  final _formKey = GlobalKey<FormState>();

  // This is storing the task information card
  String title = '';
  String description = '';


  @override
  Widget build(BuildContext context) =>
      AlertDialog(

        content: Form(
          key: _formKey,

          // Want to put the data inside the column
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // The text header for the task card
              Text(
                  'Add A Journal Entry',
                  // text style
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueGrey,
                  )
              ),


              // Adding spaces
              Container(height: 5),

              // The form for the task card to fill out and save the users input
              JournalEntryFormInputsWidget(
                  onSaved: addEntry,
                  userEntryTitle: (title) => setState(() => this.title = title),
                  userEntryContent: (description) =>
                      setState(() => this.description = description)
              ),


            ],
          ),
        ),
      );


  void addEntry() {
    // Add the todos to the list

    final entry = JournalEntryModel(
      journalEntryID: "",
      ownerID: "",
      journalEntryTitle: title,
      journalEntryContent: description,
      journalEntryCreationDate: DateTime.now(),
      journalEntryLastUpdate: DateTime.now(),
    );

    // Call the provider
    final provider = Provider.of<JournalEntryProvider>(context, listen: false);
    provider.journalEntryIDCounter(entry);
    provider.setJournalEntry(entry);
    // Once the user hit save. Get out of the screen
    Navigator.of(context).pop();
  }


}
