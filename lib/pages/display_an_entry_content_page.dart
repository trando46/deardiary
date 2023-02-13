
import 'package:deardiary/models/journalentry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayAnEntryContentPage extends StatelessWidget{
  final JournalEntryModel entry;

  DisplayAnEntryContentPage({
    required this.entry,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Journal Entry'),
    ),
    body: Container(
      child: Row(
        children: [
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title: ' + entry.journalEntryTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 30,
                  ),
                ),

              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  'Created Date: ' + entry.journalEntryCreationDate.toString(),
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),

              if(entry.journalEntryLastUpdate.toString().isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    'Last Updated: ' + entry.journalEntryLastUpdate.toString(),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),

              //If we have the description we want to display the description
              if(entry.journalEntryContent.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    'Description: ' + entry.journalEntryContent,
                    style: TextStyle(
                      fontSize: 22,
                      ),
                  ),
                ),


          ],
        )
      ),
    ],
    )
    )
    );
  }

}