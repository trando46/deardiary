import 'package:flutter/material.dart';

class JournalEntryFormInputsWidget extends StatefulWidget {
  // Declaring the variables
  final String entryTitle;
  final String entryContent;
  final VoidCallback onSaved;
  final ValueChanged<String> userEntryTitle;
  final ValueChanged<String> userEntryContent;
  final ValueChanged<bool> userGeolocation;

  const JournalEntryFormInputsWidget({
    super.key,
    this.entryTitle = '',
    this.entryContent = '',
    required this.onSaved,
    required this.userEntryTitle,
    required this.userEntryContent,
    required this.userGeolocation,
  });

  @override
  State<JournalEntryFormInputsWidget> createState() =>
      _JournalEntryFormInputsWidgetState();
}

class _JournalEntryFormInputsWidgetState
    extends State<JournalEntryFormInputsWidget> {
  // Declaring the variables
  late String entryTitle = widget.entryTitle;
  late String entryContent = widget.entryContent;
  late VoidCallback onSaved = widget.onSaved;
  late ValueChanged<String> userEntryTitle = widget.userEntryTitle;
  late ValueChanged<String> userEntryContent = widget.userEntryContent;
  late ValueChanged<bool> userGeolocation = widget.userGeolocation;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 5), // Adding spaces
            titleFormWidget(),
            Container(height: 5), // Create the space
            descriptionFormWidget(),
            Container(height: 5), // Create the space
            geolocationToggle(),
            Container(height: 5), // Create the space
            saveFormWidget(),
            exitFormWidget(context),
          ],
        ),
      );

  Widget titleFormWidget() => TextFormField(
       key: Key("Journalentry form title"),
        // The initial title of the task that is displayed for the user to enter
        initialValue: entryTitle,
        // This will display whatever the user type for the task
        onChanged: userEntryTitle,
        // The max line that will be display for the user to fill out is 1
        maxLines: 1,
        style: const TextStyle(height: 1),

        // Display the input text box for the title
        decoration: const InputDecoration(
          labelText: 'Title',
          border: OutlineInputBorder(),
        ),
      );

  Widget descriptionFormWidget() => TextFormField(
    key: Key("Journalentry form description"),
    // The initial description of the task that is displayed for the user to enter
        initialValue: entryContent,
        // This will display whatever the user type for the task
        onChanged: userEntryContent,
        // The max line that will be display for the user to fill out is 1
        maxLines: 4,
        style: const TextStyle(height: 2),

        // Display the input text box for the title
        decoration: const InputDecoration(
          labelText: 'Description',
          border: OutlineInputBorder(),
        ),
      );

  /***
   * The exit form widget allow the user to exit if they changed their mind
   * about recording their journal
   */
  Widget exitFormWidget(context) => Container(
        key: Key('Journalentry form exit'),
        child: ElevatedButton(
          child: Text('Exit'),
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            alignment: Alignment.center,
          ), //
          // Go back to the original screen (this case it is home)
        ),
      );

  Widget saveFormWidget() => ElevatedButton(
    key: Key("Journalentry form save"),
        onPressed: onSaved,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
          alignment: Alignment.center,
        ),
        child: const Text('Save'),
      );

  bool usingGeolocation = false;
  Widget geolocationToggle() => Row(
        children: [
          const Text("Use Geolocation?    "),
          Switch(
            key: Key("Journalentry form geolocation"),
            value: usingGeolocation,
            onChanged: (value) => setState(
              () {
                usingGeolocation = value;
                userGeolocation(value);
              },
            ),
          )
        ],
      );
}

// /***
//  * Stateless class for the form inputs
//  */
// class JournalEntryFormInputsWidget extends StatelessWidget {
//   // Declaring the variables
//   final String entryTitle;
//   final String entryContent;
//   final VoidCallback onSaved;
//   final ValueChanged<String> userEntryTitle;
//   final ValueChanged<String> userEntryContent;
//   final ValueChanged<bool> userGeolocation;

//   JournalEntryFormInputsWidget({
//     super.key,
//     this.entryTitle = '',
//     this.entryContent = '',
//     required this.onSaved,
//     required this.userEntryTitle,
//     required this.userEntryContent,
//     required this.userGeolocation,
//   });

//   @override
//   Widget build(BuildContext context) => SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(height: 5), // Adding spaces
//             titleFormWidget(),
//             Container(height: 5), // Create the space
//             descriptionFormWidget(),
//             Container(height: 5), // Create the space
//             geolocationToggle(),
//             Container(height: 5), // Create the space
//             saveFormWidget(),
//             exitFormWidget(context),
//           ],
//         ),
//       );

//   Widget titleFormWidget() => TextFormField(
//         // The initial title of the task that is displayed for the user to enter
//         initialValue: entryTitle,
//         // This will display whatever the user type for the task
//         onChanged: userEntryTitle,
//         // The max line that will be display for the user to fill out is 1
//         maxLines: 1,
//         style: const TextStyle(height: 1),

//         // Display the input text box for the title
//         decoration: const InputDecoration(
//           labelText: 'Title',
//           border: OutlineInputBorder(),
//         ),
//       );

//   Widget descriptionFormWidget() => TextFormField(
//         // The initial description of the task that is displayed for the user to enter
//         initialValue: entryContent,
//         // This will display whatever the user type for the task
//         onChanged: userEntryContent,
//         // The max line that will be display for the user to fill out is 1
//         maxLines: 4,
//         style: const TextStyle(height: 2),

//         // Display the input text box for the title
//         decoration: const InputDecoration(
//           labelText: 'Description',
//           border: OutlineInputBorder(),
//         ),
//       );

//   /***
//    * The exit form widget allow the user to exit if they changed their mind
//    * about recording their journal
//    */
//   Widget exitFormWidget(context) => Container(
//         key: Key('Exit'),
//         child: ElevatedButton(
//           child: Text('Exit'),
//           onPressed: () => Navigator.pop(context),
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(Colors.black),
//             alignment: Alignment.center,
//           ), //
//           // Go back to the original screen (this case it is home)
//         ),
//       );

//   Widget saveFormWidget() => ElevatedButton(
//         onPressed: onSaved,
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Colors.green),
//           alignment: Alignment.center,
//         ),
//         child: const Text('Save'),
//       );

//   bool usingGeolocation = false;
//   Widget geolocationToggle() => Switch(
//         value: usingGeolocation,
//         onChanged: userGeolocation,
//       );
// }
