import 'package:deardiary/models/journalentry.dart';
import 'package:deardiary/pages/display_an_entry_content_page.dart';
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
        //key: Key(journalEntryModel.journalEntryID),

        // The start action pane is the one at the left or the top side. This
        // will be the edit and remove functionality
        startActionPane: ActionPane(
          key: ValueKey('start'),

          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          //dismissible: DismissiblePane(onDismissed: () {}),
          dragDismissible: false,

          // All actions are defined in the children parameter.
          children: [
            // Allowing the user to edit
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
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
              borderRadius: BorderRadius.circular(10),
              onPressed: (_) {
                //TODO: route it to the appropriate place
                deleteEntry(context, journalEntryModel);
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
        //TODO: route to the appropriate page later
        onTap: () => displayJournalContent(context, journalEntryModel),
        child: Container(
          // Padding between the interior boxes
          //padding: const EdgeInsets.all(15),
          constraints: const BoxConstraints(minHeight: 70, maxHeight: 70),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          decoration: Decoration.lerp(
            BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            0.3,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      journalEntryModel.journalEntryTitle,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  /***
   * Removing the totod from the list.
   **/
  void deleteEntry(BuildContext context, JournalEntryModel entry) {
    final provider = Provider.of<JournalEntryProvider>(context, listen: false);
    provider.deleteJournalEntry(entry);
  }

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
   * Routing to the page that display all of the journal entry attributes
   */
  void displayJournalContent(
          BuildContext context, JournalEntryModel journalEntryModel) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                DisplayAnEntryContentPage(entry: journalEntryModel)),
      );
}
