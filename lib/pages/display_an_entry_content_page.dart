import 'package:deardiary/models/journalentry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class DisplayAnEntryContentPage extends StatelessWidget {
  final JournalEntryModel entry;

  DisplayAnEntryContentPage({
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("DisplayAnEntryContentPage: ${entry.journalEntryGeo}");
    }
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
                    'Created Date: ' +
                        entry.journalEntryCreationDate.toString(),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),

                if (entry.journalEntryLastUpdate.toString().isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      'Last Updated: ' +
                          entry.journalEntryLastUpdate.toString(),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),

                Container(
                  height: 120,
                  width: 120,
                  color: Colors.black38,
                  child: entry.journalEntryImage == ''
                      ? Icon(
                          Icons.image,
                        )
                      : Image.memory(base64Decode(entry.journalEntryImage)),
                ),

                //If we have the description we want to display the description
                if (entry.journalEntryContent.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      'Description: ' + entry.journalEntryContent,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),

                if (entry.journalEntryGeo.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Location: Latitude = ${entry.journalEntryGeo}',
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
              ],
            )),
          ],
        )));
  }
}
