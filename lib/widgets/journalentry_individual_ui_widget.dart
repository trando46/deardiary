import 'package:deardiary/models/journalentry.dart';
import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class JournalEntryIndividualUIWidget extends StatelessWidget {
  // Declared the variables
  final JournalEntryModel journalEntryModel;

  // Constructor
  const JournalEntryIndividualUIWidget({
    super.key,
    required this.journalEntryModel,
  });

  @override
  Widget build(BuildContext context) => ClipPath(
          child: Slidable(
        key: Key(journalEntryModel.journalEntryID),

        // The start action pane is the one at the left or the top side. This
        // will be the edit and remove functionality
        startActionPane: ActionPane(
          key: ValueKey('start'),

          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // Allowing the user to edit
            SlidableAction(
              onPressed: (_) {
                //TODO: route it to the appropriate place
                //editTodo(context, journalEntryModel);
              },
              backgroundColor: Colors.black38,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),

            // Allowing the user to delete
            SlidableAction(
              onPressed: (_) {
                //TODO: route it to the appropriate place
                //deleteTodo(context, journalEntryModel);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            )
          ],
        ),
        //This is for selecting the task card it will bring you the the task
        // card containing the information
        child: individualUITaskCardWidget(context),
      ));

  /// *
  /// This is for the ui design of the task card. Only display the title of the
  /// card
  Widget individualUITaskCardWidget(BuildContext context) => GestureDetector(
        // when tap on the card it will display the todos content
        key: const ValueKey('gesture_detector'),
        //onTap: () => displayTodoContent(context, journalEntryModel),
        onTap: () {}, //TODO: route to the appropriate page later
        child: Container(
          color: Colors.white,
          // Padding between the interior boxes
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              // This is a place holder for when we need to add more attributes
              // to the card later
              Column(
                children: [
                  // The title of the card display
                  Text(
                    journalEntryModel.journalEntryTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  /***
   * Removing the totod from the list.
   */
  /*
  void deleteTodo(BuildContext context, JournalEntryModel entry){
    final provider = Provider.of<JournalEntryProvider>(context, listen: false);
    provider.removeTodo(entry);
  }*/

  /***
   * Routing this to the edit jouranl page to allow user to edit
   */
  /*
  void editTodo(BuildContext context, JournalEntryModel journalEntryModel) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => UpdateTodoPage(todo: journalEntryModel)),
      );*/

  /**(
   * Routing to the page that display all of the task attributes
   */
  /*
  void displayJournalContent(BuildContext context, JournalEntryModel  journalEntryModel) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => DisplayTodoContentPage(todo: journalEntryModel)),
      );*/
}
