import 'package:deardiary/models/journalentry.dart';
import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:deardiary/widgets/journalentry_form_inputs_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class JournalEntryDialogStructureWidget extends StatefulWidget {
  const JournalEntryDialogStructureWidget({Key? key}) : super(key: key);

  @override
  _JournalEntryDialogStructureWidgetState createState() =>
      _JournalEntryDialogStructureWidgetState();
}

/**
 * private class for the state
 *
 * Source: https://docs.flutter.dev/cookbook/forms/validation
 * Source: https://api.flutter.dev/flutter/material/AlertDialog-class.html
 */
class _JournalEntryDialogStructureWidgetState
    extends State<JournalEntryDialogStructureWidget> {
  // Global key that is unique for identifying the form widget
  // and to have validation of the form
  final _formKey = GlobalKey<FormState>();

  // This is storing the task information card
  String title = '';
  String description = '';
  String imageFile = '';
  ImagePicker image = ImagePicker();

  @override
  Widget build(BuildContext context) => ListView(
    children: [
  AlertDialog(
  content: Form(
  key: _formKey,

    // Want to put the data inside the column
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The text header for the task card
        const Text('Add A Journal Entry',
            // text style
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.blueGrey,
            )),

        Container(height: 10),

        // display the image
        Center(
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.black38,
                child: imageFile == '' ? Icon(Icons.image,)
                    : Image.memory(base64Decode(imageFile)),
              ),

              // buttons to select if they want camera or gallery
              Row(
                children: [
                  FloatingActionButton(
                    // change the background color
                    backgroundColor: Colors.black,
                    child: Icon(Icons.camera_alt_rounded),
                    onPressed: () {
                      getCamera();
                    },
                  ),

                  Container(width: 10),

                  FloatingActionButton(
                    // change the background color
                    backgroundColor: Colors.black,
                    child: Icon(Icons.photo),
                    onPressed: () {
                      getGallery();
                    },
                  ),

                ],
              ),
            ],
          ),
        ),

        // Adding spaces
        Container(height: 5),

        // The form for the task card to fill out and save the users input
        JournalEntryFormInputsWidget(
          userEntryTitle: (title) => setState(() => this.title = title),
          userEntryContent: (description) =>
              setState(() => this.description = description),
          onSaved: addEntry,
        ),
      ],
    ),
  ),
  ),
    ]
  );


  void addEntry() {
    // Add the todos to the list

    final entry = JournalEntryModel(
      //journalEntryID: "", //no more journal entry id.
      ownerID: "",
      journalEntryTitle: title,
      journalEntryContent: description,
      journalEntryCreationDate: DateTime.now(),
      journalEntryLastUpdate: DateTime.now(),
      journalEntryImage: imageFile,
    );

    // Call the provider
    final provider = Provider.of<JournalEntryProvider>(context, listen: false);
    //provider.journalEntryIDCounter(entry);
    provider.addJournalEntry(entry);
    // Once the user hit save. Get out of the screen
    Navigator.of(context).pop();
  }

  /**
   * Allow users to take photo and save it
   */
  getCamera() async {
    var img = await image.pickImage(source: ImageSource.camera);
    if(img != null) {
      setState(() {
        File filename = File(img!.path);
        List<int> name =filename.readAsBytesSync();
        imageFile = base64Encode(name);
      });
    }
  }

  /**
   * Allow users to get pic from gallery and save it
   */
  getGallery() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    if(img != null){
      setState(() {
        File filename = File(img!.path);
        List<int> name =filename.readAsBytesSync();
        imageFile = base64Encode(name);
      });
    }
  }

}
